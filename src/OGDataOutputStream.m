/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDataOutputStream.h"

#import "OGCancellable.h"
#import "OGOutputStream.h"

@implementation OGDataOutputStream

- (instancetype)init:(OGOutputStream*)baseStream
{
	GDataOutputStream* gobjectValue = G_DATA_OUTPUT_STREAM(g_data_output_stream_new([baseStream castedGObject]));

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

- (GDataOutputStream*)castedGObject
{
	return G_DATA_OUTPUT_STREAM([self gObject]);
}

- (GDataStreamByteOrder)byteOrder
{
	GDataStreamByteOrder returnValue = g_data_output_stream_get_byte_order([self castedGObject]);

	return returnValue;
}

- (bool)putByteWithData:(guchar)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_byte([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putInt16WithData:(gint16)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_int16([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putInt32WithData:(gint32)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_int32([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putInt64WithData:(gint64)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_int64([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putStringWithStr:(OFString*)str cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_string([self castedGObject], [str UTF8String], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putUint16WithData:(guint16)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_uint16([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putUint32WithData:(guint32)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_uint32([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)putUint64WithData:(guint64)data cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_data_output_stream_put_uint64([self castedGObject], data, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)setByteOrder:(GDataStreamByteOrder)order
{
	g_data_output_stream_set_byte_order([self castedGObject], order);
}


@end