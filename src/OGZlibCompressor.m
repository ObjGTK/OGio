/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGZlibCompressor.h"

#import "OGFileInfo.h"

@implementation OGZlibCompressor

- (instancetype)initWithFormat:(GZlibCompressorFormat)format level:(int)level
{
	GZlibCompressor* gobjectValue = G_ZLIB_COMPRESSOR(g_zlib_compressor_new(format, level));

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

- (GZlibCompressor*)castedGObject
{
	return G_ZLIB_COMPRESSOR([self gObject]);
}

- (OGFileInfo*)fileInfo
{
	GFileInfo* gobjectValue = G_FILE_INFO(g_zlib_compressor_get_file_info([self castedGObject]));

	OGFileInfo* returnValue = [OGFileInfo withGObject:gobjectValue];
	return returnValue;
}

- (void)setFileInfo:(OGFileInfo*)fileInfo
{
	g_zlib_compressor_set_file_info([self castedGObject], [fileInfo castedGObject]);
}


@end