/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBufferedInputStream.h"

#import "OGCancellable.h"
#import "OGInputStream.h"

@implementation OGBufferedInputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_BUFFERED_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_BUFFERED_INPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)bufferedInputStreamWithBaseStream:(OGInputStream*)baseStream
{
	GBufferedInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_buffered_input_stream_new([baseStream castedGObject]), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGBufferedInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGBufferedInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)bufferedInputStreamSizedWithBaseStream:(OGInputStream*)baseStream size:(gsize)size
{
	GBufferedInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_buffered_input_stream_new_sized([baseStream castedGObject], size), G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGBufferedInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGBufferedInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GBufferedInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_BUFFERED_INPUT_STREAM, GBufferedInputStream);
}

- (gssize)fillWithCount:(gssize)count cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_buffered_input_stream_fill((GBufferedInputStream*)[self castedGObject], count, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)fillAsyncWithCount:(gssize)count ioPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_buffered_input_stream_fill_async((GBufferedInputStream*)[self castedGObject], count, ioPriority, [cancellable castedGObject], callback, userData);
}

- (gssize)fillFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	gssize returnValue = (gssize)g_buffered_input_stream_fill_finish((GBufferedInputStream*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (gsize)available
{
	gsize returnValue = (gsize)g_buffered_input_stream_get_available((GBufferedInputStream*)[self castedGObject]);

	return returnValue;
}

- (gsize)bufferSize
{
	gsize returnValue = (gsize)g_buffered_input_stream_get_buffer_size((GBufferedInputStream*)[self castedGObject]);

	return returnValue;
}

- (gsize)peekWithBuffer:(void*)buffer offset:(gsize)offset count:(gsize)count
{
	gsize returnValue = (gsize)g_buffered_input_stream_peek((GBufferedInputStream*)[self castedGObject], buffer, offset, count);

	return returnValue;
}

- (void*)peekBufferWithCount:(gsize*)count
{
	void* returnValue = (void*)g_buffered_input_stream_peek_buffer((GBufferedInputStream*)[self castedGObject], count);

	return returnValue;
}

- (int)readByteWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	int returnValue = (int)g_buffered_input_stream_read_byte((GBufferedInputStream*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setBufferSize:(gsize)size
{
	g_buffered_input_stream_set_buffer_size((GBufferedInputStream*)[self castedGObject], size);
}


@end