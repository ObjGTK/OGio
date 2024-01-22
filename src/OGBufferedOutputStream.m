/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBufferedOutputStream.h"

#import "OGOutputStream.h"

@implementation OGBufferedOutputStream

- (instancetype)init:(OGOutputStream*)baseStream
{
	GBufferedOutputStream* gobjectValue = G_BUFFERED_OUTPUT_STREAM(g_buffered_output_stream_new([baseStream castedGObject]));

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

- (instancetype)initSizedWithBaseStream:(OGOutputStream*)baseStream size:(gsize)size
{
	GBufferedOutputStream* gobjectValue = G_BUFFERED_OUTPUT_STREAM(g_buffered_output_stream_new_sized([baseStream castedGObject], size));

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

- (GBufferedOutputStream*)castedGObject
{
	return G_BUFFERED_OUTPUT_STREAM([self gObject]);
}

- (bool)autoGrow
{
	bool returnValue = g_buffered_output_stream_get_auto_grow([self castedGObject]);

	return returnValue;
}

- (gsize)bufferSize
{
	gsize returnValue = g_buffered_output_stream_get_buffer_size([self castedGObject]);

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