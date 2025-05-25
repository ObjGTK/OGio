/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGZlibCompressor.h"

#import "OGFileInfo.h"

@implementation OGZlibCompressor

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_ZLIB_COMPRESSOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_ZLIB_COMPRESSOR);
	return gObjectClass;
}

+ (instancetype)zlibCompressorWithFormat:(GZlibCompressorFormat)format level:(int)level
{
	GZlibCompressor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_zlib_compressor_new(format, level), G_TYPE_ZLIB_COMPRESSOR, GZlibCompressor);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGZlibCompressor* wrapperObject;
	@try {
		wrapperObject = [[OGZlibCompressor alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GZlibCompressor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_ZLIB_COMPRESSOR, GZlibCompressor);
}

- (OGFileInfo*)fileInfo
{
	GFileInfo* gobjectValue = g_zlib_compressor_get_file_info([self castedGObject]);

	OGFileInfo* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (void)setFileInfo:(OGFileInfo*)fileInfo
{
	g_zlib_compressor_set_file_info([self castedGObject], [fileInfo castedGObject]);
}


@end