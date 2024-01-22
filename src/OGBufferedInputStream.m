/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBufferedInputStream.h"

#import "OGInputStream.h"
#import "OGCancellable.h"

@implementation OGBufferedInputStream

- (instancetype)init:(OGInputStream*)baseStream
{
	GBufferedInputStream* gobjectValue = G_BUFFERED_INPUT_STREAM(g_buffered_input_stream_new([baseStream castedGObject]));

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

- (instancetype)initSizedWithBaseStream:(OGInputStream*)baseStream size:(gsize)size
{
	GBufferedInputStream* gobjectValue = G_BUFFERED_INPUT_STREAM(g_buffered_input_stream_new_sized([baseStream castedGObject], size));

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

- (GBufferedInputStream*)castedGObject
{
	return G_BUFFERED_INPUT_STREAM([self gObject]);
}

- (gssize)fillWithCount:(gssize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = g_buffered_input_stream_fill([self castedGObject], count, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)fillAsyncWithCount:(gssize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_buffered_input_stream_fill_async([self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)fillFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = g_buffered_input_stream_fill_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (gsize)available
{
	gsize returnValue = g_buffered_input_stream_get_available([self castedGObject]);

	return returnValue;
}

- (gsize)bufferSize
{
	gsize returnValue = g_buffered_input_stream_get_buffer_size([self castedGObject]);

	return returnValue;
}

- (gsize)peekWithBuffer:(void*)buffer offset:(gsize)offset count:(gsize)count
{
	gsize returnValue = g_buffered_input_stream_peek([self castedGObject], buffer, offset, count);

	return returnValue;
}

- (void*)peekBuffer:(gsize*)count
{
	void* returnValue = (void*)g_buffered_input_stream_peek_buffer([self castedGObject], count);

	return returnValue;
}

- (int)readByte:(OGCancellable*)cancellable
{
	GError* err = NULL;

	int returnValue = g_buffered_input_stream_read_byte([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)setBufferSize:(gsize)size
{
	g_buffered_input_stream_set_buffer_size([self castedGObject], size);
}


@end