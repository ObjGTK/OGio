/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBufferedInputStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"

@implementation OGBufferedInputStream

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_BUFFERED_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithBaseStream:(OGInputStream*)baseStream
{
	GBufferedInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_buffered_input_stream_new([baseStream castedGObject]), GBufferedInputStream, GBufferedInputStream);

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
	GBufferedInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_buffered_input_stream_new_sized([baseStream castedGObject], size), GBufferedInputStream, GBufferedInputStream);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GBufferedInputStream, GBufferedInputStream);
}

- (gssize)fillWithCount:(gssize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_buffered_input_stream_fill([self castedGObject], count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)fillAsyncWithCount:(gssize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_buffered_input_stream_fill_async([self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)fillFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_buffered_input_stream_fill_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gsize)available
{
	gsize returnValue = (gsize)g_buffered_input_stream_get_available([self castedGObject]);

	return returnValue;
}

- (gsize)bufferSize
{
	gsize returnValue = (gsize)g_buffered_input_stream_get_buffer_size([self castedGObject]);

	return returnValue;
}

- (gsize)peekWithBuffer:(void*)buffer offset:(gsize)offset count:(gsize)count
{
	gsize returnValue = (gsize)g_buffered_input_stream_peek([self castedGObject], buffer, offset, count);

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

	int returnValue = (int)g_buffered_input_stream_read_byte([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setBufferSize:(gsize)size
{
	g_buffered_input_stream_set_buffer_size([self castedGObject], size);
}


@end