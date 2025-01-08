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

/**
 * `GThemedIcon` is an implementation of [iface@Gio.Icon] that supports icon
 * themes.
 * 
 * `GThemedIcon` contains a list of all of the icons present in an icon
 * theme, so that icons can be looked up quickly. `GThemedIcon` does
 * not provide actual pixmaps for icons, just the icon names.
 * Ideally something like [method@Gtk.IconTheme.choose_icon] should be used to
 * resolve the list of names so that fallback icons work nicely with
 * themes that inherit other themes.
 *
 */
@interface OGThemedIcon : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initWithIconname:(OFString*)iconname;
- (instancetype)initFromNamesWithIconnames:(char**)iconnames len:(int)len;
- (instancetype)initWithIconnameWithDefaultFallbacks:(OFString*)iconname;

/**
 * Methods
 */

- (GThemedIcon*)castedGObject;

/**
 * Append a name to the list of icons from within @icon.
 * 
 * Note that doing so invalidates the hash computed by prior calls
 * to g_icon_hash().
 *
 * @param iconname name of icon to append to list of icons from within @icon.
 */
- (void)appendName:(OFString*)iconname;

/**
 * Gets the names of icons from within @icon.
 *
 * @return a list of icon names.
 */
- (const gchar* const*)names;

/**
 * Prepend a name to the list of icons from within @icon.
 * 
 * Note that doing so invalidates the hash computed by prior calls
 * to g_icon_hash().
 *
 * @param iconname name of icon to prepend to list of icons from within @icon.
 */
- (void)prependName:(OFString*)iconname;

@end