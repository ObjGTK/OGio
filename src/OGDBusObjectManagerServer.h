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

@class OGDBusConnection;
@class OGDBusObjectSkeleton;

/**
 * `GDBusObjectManagerServer` is used to export [iface@Gio.DBusObject] instances
 * using the standardized
 * [`org.freedesktop.DBus.ObjectManager`](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface. For example, remote D-Bus clients can get all objects
 * and properties in a single call. Additionally, any change in the
 * object hierarchy is broadcast using signals. This means that D-Bus
 * clients can keep caches up to date by only listening to D-Bus
 * signals.
 * 
 * The recommended path to export an object manager at is the path form of the
 * well-known name of a D-Bus service, or below. For example, if a D-Bus service
 * is available at the well-known name `net.example.ExampleService1`, the object
 * manager should typically be exported at `/net/example/ExampleService1`, or
 * below (to allow for multiple object managers in a service).
 * 
 * It is supported, but not recommended, to export an object manager at the root
 * path, `/`.
 * 
 * See [class@Gio.DBusObjectManagerClient] for the client-side code that is
 * intended to be used with `GDBusObjectManagerServer` or any D-Bus
 * object implementing the `org.freedesktop.DBus.ObjectManager` interface.
 *
 */
@interface OGDBusObjectManagerServer : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)dBusObjectManagerServerWithObjectPath:(OFString*)objectPath;

/**
 * Methods
 */

- (GDBusObjectManagerServer*)castedGObject;

/**
 * Exports @object on @manager.
 * 
 * If there is already a #GDBusObject exported at the object path,
 * then the old object is removed.
 * 
 * The object path for @object must be in the hierarchy rooted by the
 * object path for @manager.
 * 
 * Note that @manager will take a reference on @object for as long as
 * it is exported.
 *
 * @param object A #GDBusObjectSkeleton.
 */
- (void)exportWithObject:(OGDBusObjectSkeleton*)object;

/**
 * Like g_dbus_object_manager_server_export() but appends a string of
 * the form _N (with N being a natural number) to @object's object path
 * if an object with the given path already exists. As such, the
 * #GDBusObjectProxy:g-object-path property of @object may be modified.
 *
 * @param object An object.
 */
- (void)exportUniquelyWithObject:(OGDBusObjectSkeleton*)object;

/**
 * Gets the #GDBusConnection used by @manager.
 *
 * @return A #GDBusConnection object or %NULL if
 *   @manager isn't exported on a connection. The returned object should
 *   be freed with g_object_unref().
 */
- (OGDBusConnection*)connection;

/**
 * Returns whether @object is currently exported on @manager.
 *
 * @param object An object.
 * @return %TRUE if @object is exported
 */
- (bool)isExportedWithObject:(OGDBusObjectSkeleton*)object;

/**
 * Exports all objects managed by @manager on @connection. If
 * @connection is %NULL, stops exporting objects.
 *
 * @param connection A #GDBusConnection or %NULL.
 */
- (void)setConnection:(OGDBusConnection*)connection;

/**
 * If @manager has an object at @path, removes the object. Otherwise
 * does nothing.
 * 
 * Note that @object_path must be in the hierarchy rooted by the
 * object path for @manager.
 *
 * @param objectPath An object path.
 * @return %TRUE if object at @object_path was removed, %FALSE otherwise.
 */
- (bool)unexportWithObjectPath:(OFString*)objectPath;

@end