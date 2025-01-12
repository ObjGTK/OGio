/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixfdmessage.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gio.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

@class OGFileInfo;

/**
 * `GZlibCompressor` is an implementation of [iface@Gio.Converter] that
 * compresses data using zlib.
 *
 */
@interface OGZlibCompressor : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)zlibCompressorWithFormat:(GZlibCompressorFormat)format level:(int)level;

/**
 * Methods
 */

- (GZlibCompressor*)castedGObject;

/**
 * Returns the #GZlibCompressor:file-info property.
 *
 * @return a #GFileInfo, or %NULL
 */
- (OGFileInfo*)fileInfo;

/**
 * Sets @file_info in @compressor. If non-%NULL, and @compressor's
 * #GZlibCompressor:format property is %G_ZLIB_COMPRESSOR_FORMAT_GZIP,
 * it will be used to set the file name and modification time in
 * the GZIP header of the compressed data.
 * 
 * Note: it is an error to call this function while a compression is in
 * progress; it may only be called immediately after creation of @compressor,
 * or after resetting it with g_converter_reset().
 *
 * @param fileInfo a #GFileInfo
 */
- (void)setFileInfo:(OGFileInfo*)fileInfo;

@end