/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMemoryInputStream.h"

@implementation OGMemoryInputStream

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MEMORY_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GMemoryInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_input_stream_new(), GMemoryInputStream, GMemoryInputStream);

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

- (instancetype)initWithBytesFromBytes:(GBytes*)bytes
{
	GMemoryInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_input_stream_new_from_bytes(bytes), GMemoryInputStream, GMemoryInputStream);

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
	GMemoryInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_input_stream_new_from_data(data, len, destroy), GMemoryInputStream, GMemoryInputStream);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GMemoryInputStream, GMemoryInputStream);
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