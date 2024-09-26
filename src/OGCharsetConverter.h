/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixmounts.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

/**
 * `GCharsetConverter` is an implementation of [iface@Gio.Converter] based on
 * [struct@GLib.IConv].
 *
 */
@interface OGCharsetConverter : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initWithToCharset:(OFString*)toCharset fromCharset:(OFString*)fromCharset;

/**
 * Methods
 */

- (GCharsetConverter*)castedGObject;

/**
 * Gets the number of fallbacks that @converter has applied so far.
 *
 * @return the number of fallbacks that @converter has applied
 */
- (guint)numFallbacks;

/**
 * Gets the #GCharsetConverter:use-fallback property.
 *
 * @return %TRUE if fallbacks are used by @converter
 */
- (bool)useFallback;

/**
 * Sets the #GCharsetConverter:use-fallback property.
 *
 * @param useFallback %TRUE to use fallbacks
 */
- (void)setUseFallback:(bool)useFallback;

@end