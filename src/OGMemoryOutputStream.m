/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMemoryOutputStream.h"

@implementation OGMemoryOutputStream

- (instancetype)initWithData:(gpointer)data size:(gsize)size reallocFunction:(GReallocFunc)reallocFunction destroyFunction:(GDestroyNotify)destroyFunction
{
	GMemoryOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_output_stream_new(data, size, reallocFunction, destroyFunction), GMemoryOutputStream, GMemoryOutputStream);

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

- (instancetype)initResizable
{
	GMemoryOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_output_stream_new_resizable(), GMemoryOutputStream, GMemoryOutputStream);

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

- (GMemoryOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GMemoryOutputStream, GMemoryOutputStream);
}

- (gpointer)data
{
	gpointer returnValue = g_memory_output_stream_get_data([self castedGObject]);

	return returnValue;
}

- (gsize)dataSize
{
	gsize returnValue = g_memory_output_stream_get_data_size([self castedGObject]);

	return returnValue;
}

- (gsize)size
{
	gsize returnValue = g_memory_output_stream_get_size([self castedGObject]);

	return returnValue;
}

- (GBytes*)stealAsBytes
{
	GBytes* returnValue = g_memory_output_stream_steal_as_bytes([self castedGObject]);

	return returnValue;
}

- (gpointer)stealData
{
	gpointer returnValue = g_memory_output_stream_steal_data([self castedGObject]);

	return returnValue;
}


@end