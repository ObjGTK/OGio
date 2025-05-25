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

@class OGCancellable;
@class OGDBusAuthObserver;

/**
 * `GDBusServer` is a helper for listening to and accepting D-Bus
 * connections. This can be used to create a new D-Bus server, allowing two
 * peers to use the D-Bus protocol for their own specialized communication.
 * A server instance provided in this way will not perform message routing or
 * implement the
 * [`org.freedesktop.DBus` interface](https://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-messages).
 * 
 * To just export an object on a well-known name on a message bus, such as the
 * session or system bus, you should instead use [func@Gio.bus_own_name].
 * 
 * An example of peer-to-peer communication with GDBus can be found
 * in [gdbus-example-peer.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-peer.c).
 * 
 * Note that a minimal `GDBusServer` will accept connections from any
 * peer. In many use-cases it will be necessary to add a
 * [class@Gio.DBusAuthObserver] that only accepts connections that have
 * successfully authenticated as the same user that is running the
 * `GDBusServer`. Since GLib 2.68 this can be achieved more simply by passing
 * the `G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER` flag to the
 * server.
 *
 */
@interface OGDBusServer : OGObject
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
+ (instancetype)dBusServerSyncWithAddress:(OFString*)address flags:(GDBusServerFlags)flags guid:(OFString*)guid observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable;

/**
 * Methods
 */

- (GDBusServer*)castedGObject;

/**
 * Gets a
 * [D-Bus address](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses)
 * string that can be used by clients to connect to @server.
 * 
 * This is valid and non-empty if initializing the #GDBusServer succeeded.
 *
 * @return A D-Bus address string. Do not free, the string is owned
 * by @server.
 */
- (OFString*)clientAddress;

/**
 * Gets the flags for @server.
 *
 * @return A set of flags from the #GDBusServerFlags enumeration.
 */
- (GDBusServerFlags)flags;

/**
 * Gets the GUID for @server, as provided to g_dbus_server_new_sync().
 *
 * @return A D-Bus GUID. Do not free this string, it is owned by @server.
 */
- (OFString*)guid;

/**
 * Gets whether @server is active.
 *
 * @return %TRUE if server is active, %FALSE otherwise.
 */
- (bool)isActive;

/**
 * Starts @server.
 *
 */
- (void)start;

/**
 * Stops @server.
 *
 */
- (void)stop;

@end