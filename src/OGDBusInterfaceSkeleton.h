/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

@class OGDBusConnection;

/**
 * Abstract base class for D-Bus interfaces on the service side.
 *
 */
@interface OGDBusInterfaceSkeleton : OGObject
{

}


/**
 * Methods
 */

- (GDBusInterfaceSkeleton*)castedGObject;

/**
 * Exports @interface_ at @object_path on @connection.
 * 
 * This can be called multiple times to export the same @interface_
 * onto multiple connections however the @object_path provided must be
 * the same for all connections.
 * 
 * Use g_dbus_interface_skeleton_unexport() to unexport the object.
 *
 * @param connection A #GDBusConnection to export @interface_ on.
 * @param objectPath The path to export the interface at.
 * @return %TRUE if the interface was exported on @connection, otherwise %FALSE with
 * @error set.
 */
- (bool)exportWithConnection:(OGDBusConnection*)connection objectPath:(OFString*)objectPath;

/**
 * If @interface_ has outstanding changes, request for these changes to be
 * emitted immediately.
 * 
 * For example, an exported D-Bus interface may queue up property
 * changes and emit the
 * `org.freedesktop.DBus.Properties.PropertiesChanged`
 * signal later (e.g. in an idle handler). This technique is useful
 * for collapsing multiple property changes into one.
 *
 */
- (void)flush;

/**
 * Gets the first connection that @interface_ is exported on, if any.
 *
 * @return A #GDBusConnection or %NULL if @interface_ is
 * not exported anywhere. Do not free, the object belongs to @interface_.
 */
- (OGDBusConnection*)connection;

/**
 * Gets a list of the connections that @interface_ is exported on.
 *
 * @return A list of
 *   all the connections that @interface_ is exported on. The returned
 *   list should be freed with g_list_free() after each element has
 *   been freed with g_object_unref().
 */
- (GList*)connections;

/**
 * Gets the #GDBusInterfaceSkeletonFlags that describes what the behavior
 * of @interface_
 *
 * @return One or more flags from the #GDBusInterfaceSkeletonFlags enumeration.
 */
- (GDBusInterfaceSkeletonFlags)flags;

/**
 * Gets D-Bus introspection information for the D-Bus interface
 * implemented by @interface_.
 *
 * @return A #GDBusInterfaceInfo (never %NULL). Do not free.
 */
- (GDBusInterfaceInfo*)info;

/**
 * Gets the object path that @interface_ is exported on, if any.
 *
 * @return A string owned by @interface_ or %NULL if @interface_ is not exported
 * anywhere. Do not free, the string belongs to @interface_.
 */
- (OFString*)objectPath;

/**
 * Gets all D-Bus properties for @interface_.
 *
 * @return A #GVariant of type
 * ['a{sv}'][G-VARIANT-TYPE-VARDICT:CAPS].
 * Free with g_variant_unref().
 */
- (GVariant*)properties;

/**
 * Gets the interface vtable for the D-Bus interface implemented by
 * @interface_. The returned function pointers should expect @interface_
 * itself to be passed as @user_data.
 *
 * @return the vtable of the D-Bus interface implemented by the skeleton
 */
- (GDBusInterfaceVTable*)vtable;

/**
 * Checks if @interface_ is exported on @connection.
 *
 * @param connection A #GDBusConnection.
 * @return %TRUE if @interface_ is exported on @connection, %FALSE otherwise.
 */
- (bool)hasConnection:(OGDBusConnection*)connection;

/**
 * Sets flags describing what the behavior of @skeleton should be.
 *
 * @param flags Flags from the #GDBusInterfaceSkeletonFlags enumeration.
 */
- (void)setFlags:(GDBusInterfaceSkeletonFlags)flags;

/**
 * Stops exporting @interface_ on all connections it is exported on.
 * 
 * To unexport @interface_ from only a single connection, use
 * g_dbus_interface_skeleton_unexport_from_connection()
 *
 */
- (void)unexport;

/**
 * Stops exporting @interface_ on @connection.
 * 
 * To stop exporting on all connections the interface is exported on,
 * use g_dbus_interface_skeleton_unexport().
 *
 * @param connection A #GDBusConnection.
 */
- (void)unexportFromConnection:(OGDBusConnection*)connection;

@end