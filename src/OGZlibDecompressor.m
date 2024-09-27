/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGZlibDecompressor.h"

#import "OGFileInfo.h"

@implementation OGZlibDecompressor

- (instancetype)init:(GZlibCompressorFormat)format
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
	GFileInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_zlib_decompressor_get_file_info([self castedGObject]), GFileInfo, GFileInfo);

	OGFileInfo* returnValue = [OGFileInfo withGObject:gobjectValue];
	return returnValue;
}


@end