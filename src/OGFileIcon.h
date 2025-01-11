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
 * `GFileIcon` specifies an icon by pointing to an image file
 * to be used as icon.
 * 
 * It implements [iface@Gio.LoadableIcon].
 *
 */
@interface OGFileIcon : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)fileIcon:(GFile*)file;

/**
 * Methods
 */

- (GFileIcon*)castedGObject;

/**
 * Gets the #GFile associated with the given @icon.
 *
 * @return a #GFile.
 */
- (GFile*)file;

@end