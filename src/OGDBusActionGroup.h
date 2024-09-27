/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>

#import <OGObject/OGObject.h>

@class OGDBusConnection;

/**
 * `GDBusActionGroup` is an implementation of the [iface@Gio.ActionGroup]
 * interface.
 * 
 * `GDBusActionGroup` can be used as a proxy for an action group
 * that is exported over D-Bus with [method@Gio.DBusConnection.export_action_group].
 *
 */
@interface OGDBusActionGroup : OGObject
{

}

/**
 * Functions
 */

/**
 * Obtains a #GDBusActionGroup for the action group which is exported at
 * the given @bus_name and @object_path.
 * 
 * The thread default main context is taken at the time of this call.
 * All signals on the menu model (and any linked models) are reported
 * with respect to this context.  All calls on the returned menu model
 * (and linked models) must also originate from this same context, with
 * the thread default main context unchanged.
 * 
 * This call is non-blocking.  The returned action group may or may not
 * already be filled in.  The correct thing to do is connect the signals
 * for the action group to monitor for changes and then to call
 * g_action_group_list_actions() to get the initial list.
 *
 * @param connection A #GDBusConnection
 * @param busName the bus name which exports the action
 *     group or %NULL if @connection is not a message bus connection
 * @param objectPath the object path at which the action group is exported
 * @return a #GDBusActionGroup
 */
+ (OGDBusActionGroup*)getWithConnection:(OGDBusConnection*)connection busName:(OFString*)busName objectPath:(OFString*)objectPath;

/**
 * Methods
 */

- (GDBusActionGroup*)castedGObject;

@end