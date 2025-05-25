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
 * `GBytesIcon` specifies an image held in memory in a common format (usually
 * PNG) to be used as icon.
 *
 */
@interface OGBytesIcon : OGObject
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
+ (instancetype)bytesIconWithBytes:(GBytes*)bytes;

/**
 * Methods
 */

- (GBytesIcon*)castedGObject;

/**
 * Gets the #GBytes associated with the given @icon.
 *
 * @return a #GBytes.
 */
- (GBytes*)bytes;

@end