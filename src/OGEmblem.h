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
 * `GEmblem` is an implementation of [iface@Gio.Icon] that supports
 * having an emblem, which is an icon with additional properties.
 * It can than be added to a [class@Gio.EmblemedIcon].
 * 
 * Currently, only metainformation about the emblem's origin is
 * supported. More may be added in the future.
 *
 */
@interface OGEmblem : OGObject
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
+ (instancetype)emblemWithIcon:(GIcon*)icon;
+ (instancetype)emblemWithOriginWithIcon:(GIcon*)icon origin:(GEmblemOrigin)origin;

/**
 * Methods
 */

- (GEmblem*)castedGObject;

/**
 * Gives back the icon from @emblem.
 *
 * @return a #GIcon. The returned object belongs to
 *          the emblem and should not be modified or freed.
 */
- (GIcon*)icon;

/**
 * Gets the origin of the emblem.
 *
 * @return the origin of the emblem
 */
- (GEmblemOrigin)origin;

@end