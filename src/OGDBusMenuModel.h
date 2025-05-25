/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuModel.h"

@class OGDBusConnection;

/**
 * `GDBusMenuModel` is an implementation of [class@Gio.MenuModel] that can be
 * used as a proxy for a menu model that is exported over D-Bus with
 * [method@Gio.DBusConnection.export_menu_model].
 *
 */
@interface OGDBusMenuModel : OGMenuModel
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Obtains a #GDBusMenuModel for the menu model which is exported
 * at the given @bus_name and @object_path.
 * 
 * The thread default main context is taken at the time of this call.
 * All signals on the menu model (and any linked models) are reported
 * with respect to this context.  All calls on the returned menu model
 * (and linked models) must also originate from this same context, with
 * the thread default main context unchanged.
 *
 * @param connection a #GDBusConnection
 * @param busName the bus name which exports the menu model
 *     or %NULL if @connection is not a message bus connection
 * @param objectPath the object path at which the menu model is exported
 * @return a #GDBusMenuModel object. Free with
 *     g_object_unref().
 */
+ (OGDBusMenuModel*)getWithConnection:(OGDBusConnection*)connection busName:(OFString*)busName objectPath:(OFString*)objectPath;

/**
 * Methods
 */

- (GDBusMenuModel*)castedGObject;

@end