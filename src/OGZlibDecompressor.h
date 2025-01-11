/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

@class OGFileInfo;

/**
 * `GZlibDecompressor` is an implementation of [iface@Gio.Converter] that
 * decompresses data compressed with zlib.
 *
 */
@interface OGZlibDecompressor : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)zlibDecompressor:(GZlibCompressorFormat)format;

/**
 * Methods
 */

- (GZlibDecompressor*)castedGObject;

/**
 * Retrieves the #GFileInfo constructed from the GZIP header data
 * of compressed data processed by @compressor, or %NULL if @decompressor's
 * #GZlibDecompressor:format property is not %G_ZLIB_COMPRESSOR_FORMAT_GZIP,
 * or the header data was not fully processed yet, or it not present in the
 * data stream at all.
 *
 * @return a #GFileInfo, or %NULL
 */
- (OGFileInfo*)fileInfo;

@end