/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBufferedOutputStream.h"

#import "OGOutputStream.h"

@implementation OGBufferedOutputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_BUFFERED_OUTPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_BUFFERED_OUTPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)bufferedOutputStreamWithBaseStream:(OGOutputStream*)baseStream
{
	GBufferedOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_buffered_output_stream_new([baseStream castedGObject]), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGBufferedOutputStream* wrapperObject;
	@try {
		wrapperObject = [[OGBufferedOutputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)bufferedOutputStreamSizedWithBaseStream:(OGOutputStream*)baseStream size:(gsize)size
{
	GBufferedOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_buffered_output_stream_new_sized([baseStream castedGObject], size), G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGBufferedOutputStream* wrapperObject;
	@try {
		wrapperObject = [[OGBufferedOutputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GBufferedOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_BUFFERED_OUTPUT_STREAM, GBufferedOutputStream);
}

- (bool)autoGrow
{
	bool returnValue = (bool)g_buffered_output_stream_get_auto_grow([self castedGObject]);

	return returnValue;
}

- (gsize)bufferSize
{
	gsize returnValue = (gsize)g_buffered_output_stream_get_buffer_size([self castedGObject]);

	return returnValue;
}

- (void)setAutoGrow:(bool)autoGrow
{
	g_buffered_output_stream_set_auto_grow([self castedGObject], autoGrow);
}

- (void)setBufferSize:(gsize)size
{
	g_buffered_output_stream_set_buffer_size([self castedGObject], size);
}


@end