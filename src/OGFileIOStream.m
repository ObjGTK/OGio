/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileIOStream.h"

#import "OGCancellable.h"
#import "OGFileInfo.h"

@implementation OGFileIOStream

- (GFileIOStream*)castedGObject
{
	return G_FILE_IO_STREAM([self gObject]);
}

- (char*)etag
{
	char* gobjectValue = g_file_io_stream_get_etag([self castedGObject]);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (OGFileInfo*)queryInfoWithAttributes:(OFString*)attributes cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GFileInfo* gobjectValue = G_FILE_INFO(g_file_io_stream_query_info([self castedGObject], [attributes UTF8String], [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGFileInfo* returnValue = [OGFileInfo wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)queryInfoAsyncWithAttributes:(OFString*)attributes ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_file_io_stream_query_info_async([self castedGObject], [attributes UTF8String], ioPriority, [cancellable castedGObject], callback, userData);
}

- (OGFileInfo*)queryInfoFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GFileInfo* gobjectValue = G_FILE_INFO(g_file_io_stream_query_info_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGFileInfo* returnValue = [OGFileInfo wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}


@end