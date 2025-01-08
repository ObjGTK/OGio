/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGZlibDecompressor.h"

#import "OGFileInfo.h"

@implementation OGZlibDecompressor

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_ZLIB_DECOMPRESSOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithFormat:(GZlibCompressorFormat)format
{
	GZlibDecompressor* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_zlib_decompressor_new(format), GZlibDecompressor, GZlibDecompressor);

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

- (GZlibDecompressor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GZlibDecompressor, GZlibDecompressor);
}

- (OGFileInfo*)fileInfo
{
	GFileInfo* gobjectValue = g_zlib_decompressor_get_file_info([self castedGObject]);

	OGFileInfo* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}


@end