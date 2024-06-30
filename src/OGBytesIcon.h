/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixoutputstream.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

/**
 * #GBytesIcon specifies an image held in memory in a common format (usually
 * png) to be used as icon.
 *
 */
@interface OGBytesIcon : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init:(GBytes*)bytes;

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