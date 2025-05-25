/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileIOStream.h"

#import "OGCancellable.h"
#import "OGFileInfo.h"

@implementation OGFileIOStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILE_IO_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_FILE_IO_STREAM);
	return gObjectClass;
}

- (GFileIOStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_FILE_IO_STREAM, GFileIOStream);
}

- (OFString*)etag
{
	char* gobjectValue = g_file_io_stream_get_etag([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OGFileInfo*)queryInfoWithAttributes:(OFString*)attributes cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GFileInfo* gobjectValue = g_file_io_stream_query_info([self castedGObject], [attributes UTF8String], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGFileInfo* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)queryInfoAsyncWithAttributes:(OFString*)attributes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_file_io_stream_query_info_async([self castedGObject], [attributes UTF8String], ioPriority, [cancellable castedGObject], callback, userData);
}

- (OGFileInfo*)queryInfoFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GFileInfo* gobjectValue = g_file_io_stream_query_info_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGFileInfo* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}


@end