/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDataInputStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"

@implementation OGDataInputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DATA_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DATA_INPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)dataInputStreamWithBaseStream:(OGInputStream*)baseStream
{
	GDataInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_data_input_stream_new([baseStream castedGObject]), G_TYPE_DATA_INPUT_STREAM, GDataInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDataInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGDataInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDataInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DATA_INPUT_STREAM, GDataInputStream);
}

- (GDataStreamByteOrder)byteOrder
{
	GDataStreamByteOrder returnValue = (GDataStreamByteOrder)g_data_input_stream_get_byte_order([self castedGObject]);

	return returnValue;
}

- (GDataStreamNewlineType)newlineType
{
	GDataStreamNewlineType returnValue = (GDataStreamNewlineType)g_data_input_stream_get_newline_type([self castedGObject]);

	return returnValue;
}

- (guchar)readByteWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guchar returnValue = (guchar)g_data_input_stream_read_byte([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint16)readInt16WithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint16 returnValue = (gint16)g_data_input_stream_read_int16([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint32)readInt32WithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint32 returnValue = (gint32)g_data_input_stream_read_int32([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gint64)readInt64WithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint64 returnValue = (gint64)g_data_input_stream_read_int64([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OFString*)readLineWithLength:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line([self castedGObject], length, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)readLineAsyncWithIoPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_data_input_stream_read_line_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (OFString*)readLineFinishWithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line_finish([self castedGObject], result, length, &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OFString*)readLineFinishUtf8WithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line_finish_utf8([self castedGObject], result, length, &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OFString*)readLineUtf8WithLength:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line_utf8([self castedGObject], length, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (guint16)readUint16WithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guint16 returnValue = (guint16)g_data_input_stream_read_uint16([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint32)readUint32WithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guint32 returnValue = (guint32)g_data_input_stream_read_uint32([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (guint64)readUint64WithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guint64 returnValue = (guint64)g_data_input_stream_read_uint64([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OFString*)readUntilWithStopChars:(OFString*)stopChars length:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_until([self castedGObject], [stopChars UTF8String], length, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)readUntilAsyncWithStopChars:(OFString*)stopChars ioPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_data_input_stream_read_until_async([self castedGObject], [stopChars UTF8String], ioPriority, [cancellable castedGObject], callback, userData);
}

- (OFString*)readUntilFinishWithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_until_finish([self castedGObject], result, length, &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OFString*)readUptoWithStopChars:(OFString*)stopChars stopCharsLen:(gssize)stopCharsLen length:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_upto([self castedGObject], [stopChars UTF8String], stopCharsLen, length, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)readUptoAsyncWithStopChars:(OFString*)stopChars stopCharsLen:(gssize)stopCharsLen ioPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_data_input_stream_read_upto_async([self castedGObject], [stopChars UTF8String], stopCharsLen, ioPriority, [cancellable castedGObject], callback, userData);
}

- (OFString*)readUptoFinishWithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_upto_finish([self castedGObject], result, length, &err);

	[OGErrorException throwForError:err];

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)setByteOrder:(GDataStreamByteOrder)order
{
	g_data_input_stream_set_byte_order([self castedGObject], order);
}

- (void)setNewlineType:(GDataStreamNewlineType)type
{
	g_data_input_stream_set_newline_type([self castedGObject], type);
}


@end