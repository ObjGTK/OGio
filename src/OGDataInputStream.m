/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDataInputStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"

@implementation OGDataInputStream

- (instancetype)init:(OGInputStream*)baseStream
{
	GDataInputStream* gobjectValue = G_DATA_INPUT_STREAM(g_data_input_stream_new([baseStream castedGObject]));

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GDataInputStream*)castedGObject
{
	return G_DATA_INPUT_STREAM([self gObject]);
}

- (GDataStreamByteOrder)byteOrder
{
	GDataStreamByteOrder returnValue = g_data_input_stream_get_byte_order([self castedGObject]);

	return returnValue;
}

- (GDataStreamNewlineType)newlineType
{
	GDataStreamNewlineType returnValue = g_data_input_stream_get_newline_type([self castedGObject]);

	return returnValue;
}

- (guchar)readByte:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guchar returnValue = g_data_input_stream_read_byte([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gint16)readInt16:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint16 returnValue = g_data_input_stream_read_int16([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gint32)readInt32:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint32 returnValue = g_data_input_stream_read_int32([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gint64)readInt64:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint64 returnValue = g_data_input_stream_read_int64([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (char*)readLineWithLength:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line([self castedGObject], length, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (void)readLineAsyncWithIoPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_data_input_stream_read_line_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (char*)readLineFinishWithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line_finish([self castedGObject], result, length, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (char*)readLineFinishUtf8WithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line_finish_utf8([self castedGObject], result, length, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (char*)readLineUtf8WithLength:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_line_utf8([self castedGObject], length, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (guint16)readUint16:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guint16 returnValue = g_data_input_stream_read_uint16([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint32)readUint32:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guint32 returnValue = g_data_input_stream_read_uint32([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (guint64)readUint64:(OGCancellable*)cancellable
{
	GError* err = NULL;

	guint64 returnValue = g_data_input_stream_read_uint64([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (char*)readUntilWithStopChars:(OFString*)stopChars length:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_until([self castedGObject], [stopChars UTF8String], length, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (void)readUntilAsyncWithStopChars:(OFString*)stopChars ioPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_data_input_stream_read_until_async([self castedGObject], [stopChars UTF8String], ioPriority, [cancellable castedGObject], callback, userData);
}

- (char*)readUntilFinishWithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_until_finish([self castedGObject], result, length, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (char*)readUptoWithStopChars:(OFString*)stopChars stopCharsLen:(gssize)stopCharsLen length:(gsize*)length cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_upto([self castedGObject], [stopChars UTF8String], stopCharsLen, length, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
	return returnValue;
}

- (void)readUptoAsyncWithStopChars:(OFString*)stopChars stopCharsLen:(gssize)stopCharsLen ioPriority:(gint)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_data_input_stream_read_upto_async([self castedGObject], [stopChars UTF8String], stopCharsLen, ioPriority, [cancellable castedGObject], callback, userData);
}

- (char*)readUptoFinishWithResult:(GAsyncResult*)result length:(gsize*)length
{
	GError* err = NULL;

	char* gobjectValue = g_data_input_stream_read_upto_finish([self castedGObject], result, length, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	char* returnValue = gobjectValue;
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