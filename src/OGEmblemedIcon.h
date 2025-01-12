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

@class OGEmblem;

/**
 * `GEmblemedIcon` is an implementation of [iface@Gio.Icon] that supports
 * adding an emblem to an icon. Adding multiple emblems to an
 * icon is ensured via [method@Gio.EmblemedIcon.add_emblem].
 * 
 * Note that `GEmblemedIcon` allows no control over the position
 * of the emblems. See also [class@Gio.Emblem] for more information.
 *
 */
@interface OGEmblemedIcon : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)emblemedIconWithIcon:(GIcon*)icon emblem:(OGEmblem*)emblem;

/**
 * Methods
 */

- (GEmblemedIcon*)castedGObject;

/**
 * Adds @emblem to the #GList of #GEmblems.
 *
 * @param emblem a #GEmblem
 */
- (void)addEmblem:(OGEmblem*)emblem;

/**
 * Removes all the emblems from @icon.
 *
 */
- (void)clearEmblems;

/**
 * Gets the list of emblems for the @icon.
 *
 * @return a #GList of
 *     #GEmblems that is owned by @emblemed
 */
- (GList*)emblems;

/**
 * Gets the main icon for @emblemed.
 *
 * @return a #GIcon that is owned by @emblemed
 */
- (GIcon*)icon;

@end