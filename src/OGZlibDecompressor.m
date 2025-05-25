/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGZlibDecompressor.h"

#import "OGFileInfo.h"

@implementation OGZlibDecompressor

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_ZLIB_DECOMPRESSOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_ZLIB_DECOMPRESSOR);
	return gObjectClass;
}

+ (instancetype)zlibDecompressorWithFormat:(GZlibCompressorFormat)format
{
	GZlibDecompressor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_zlib_decompressor_new(format), G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressor);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGZlibDecompressor* wrapperObject;
	@try {
		wrapperObject = [[OGZlibDecompressor alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GZlibDecompressor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_ZLIB_DECOMPRESSOR, GZlibDecompressor);
}

- (OGFileInfo*)fileInfo
{
	GFileInfo* gobjectValue = g_zlib_decompressor_get_file_info((GZlibDecompressor*)[self castedGObject]);

	OGFileInfo* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}


@end