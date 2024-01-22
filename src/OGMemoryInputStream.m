/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMemoryInputStream.h"

@implementation OGMemoryInputStream

- (instancetype)init
{
	GMemoryInputStream* gobjectValue = G_MEMORY_INPUT_STREAM(g_memory_input_stream_new());

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

- (instancetype)initFromBytes:(GBytes*)bytes
{
	GMemoryInputStream* gobjectValue = G_MEMORY_INPUT_STREAM(g_memory_input_stream_new_from_bytes(bytes));

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

- (instancetype)initFromDataWithData:(void*)data len:(gssize)len destroy:(GDestroyNotify)destroy
{
	GMemoryInputStream* gobjectValue = G_MEMORY_INPUT_STREAM(g_memory_input_stream_new_from_data(data, len, destroy));

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

- (GMemoryInputStream*)castedGObject
{
	return G_MEMORY_INPUT_STREAM([self gObject]);
}

- (void)addBytes:(GBytes*)bytes
{
	g_memory_input_stream_add_bytes([self castedGObject], bytes);
}

- (void)addDataWithData:(void*)data len:(gssize)len destroy:(GDestroyNotify)destroy
{
	g_memory_input_stream_add_data([self castedGObject], data, len, destroy);
}


@end