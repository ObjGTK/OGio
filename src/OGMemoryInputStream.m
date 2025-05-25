/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMemoryInputStream.h"

@implementation OGMemoryInputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MEMORY_INPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MEMORY_INPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)memoryInputStream
{
	GMemoryInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_input_stream_new(), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMemoryInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGMemoryInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)memoryInputStreamFromBytes:(GBytes*)bytes
{
	GMemoryInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_input_stream_new_from_bytes(bytes), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMemoryInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGMemoryInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)memoryInputStreamFromData:(void*)data len:(gssize)len destroy:(GDestroyNotify)destroy
{
	GMemoryInputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_input_stream_new_from_data(data, len, destroy), G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMemoryInputStream* wrapperObject;
	@try {
		wrapperObject = [[OGMemoryInputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GMemoryInputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MEMORY_INPUT_STREAM, GMemoryInputStream);
}

- (void)addBytes:(GBytes*)bytes
{
	g_memory_input_stream_add_bytes([self castedGObject], bytes);
}

- (void)addData:(void*)data len:(gssize)len destroy:(GDestroyNotify)destroy
{
	g_memory_input_stream_add_data([self castedGObject], data, len, destroy);
}


@end