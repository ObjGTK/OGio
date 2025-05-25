/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>

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
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Constructors
 */
+ (instancetype)fileIconWithFile:(GFile*)file;

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