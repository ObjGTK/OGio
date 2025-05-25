/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMemoryOutputStream.h"

@implementation OGMemoryOutputStream

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MEMORY_OUTPUT_STREAM;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MEMORY_OUTPUT_STREAM);
	return gObjectClass;
}

+ (instancetype)memoryOutputStreamWithData:(gpointer)data size:(gsize)size reallocFunction:(GReallocFunc)reallocFunction destroyFunction:(GDestroyNotify)destroyFunction
{
	GMemoryOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_output_stream_new(data, size, reallocFunction, destroyFunction), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMemoryOutputStream* wrapperObject;
	@try {
		wrapperObject = [[OGMemoryOutputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)memoryOutputStreamResizable
{
	GMemoryOutputStream* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_memory_output_stream_new_resizable(), G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStream);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGMemoryOutputStream* wrapperObject;
	@try {
		wrapperObject = [[OGMemoryOutputStream alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GMemoryOutputStream*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MEMORY_OUTPUT_STREAM, GMemoryOutputStream);
}

- (gpointer)data
{
	gpointer returnValue = (gpointer)g_memory_output_stream_get_data([self castedGObject]);

	return returnValue;
}

- (gsize)dataSize
{
	gsize returnValue = (gsize)g_memory_output_stream_get_data_size([self castedGObject]);

	return returnValue;
}

- (gsize)size
{
	gsize returnValue = (gsize)g_memory_output_stream_get_size([self castedGObject]);

	return returnValue;
}

- (GBytes*)stealAsBytes
{
	GBytes* returnValue = (GBytes*)g_memory_output_stream_steal_as_bytes([self castedGObject]);

	return returnValue;
}

- (gpointer)stealData
{
	gpointer returnValue = (gpointer)g_memory_output_stream_steal_data([self castedGObject]);

	return returnValue;
}


@end