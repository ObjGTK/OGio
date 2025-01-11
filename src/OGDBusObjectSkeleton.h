/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

@class OGDBusInterfaceSkeleton;

/**
 * A `GDBusObjectSkeleton` instance is essentially a group of D-Bus
 * interfaces. The set of exported interfaces on the object may be
 * dynamic and change at runtime.
 * 
 * This type is intended to be used with [iface@Gio.DBusObjectManager].
 *
 */
@interface OGDBusObjectSkeleton : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)dBusObjectSkeleton:(OFString*)objectPath;

/**
 * Methods
 */

- (GDBusObjectSkeleton*)castedGObject;

/**
 * Adds @interface_ to @object.
 * 
 * If @object already contains a #GDBusInterfaceSkeleton with the same
 * interface name, it is removed before @interface_ is added.
 * 
 * Note that @object takes its own reference on @interface_ and holds
 * it until removed.
 *
 * @param interface A #GDBusInterfaceSkeleton.
 */
- (void)addInterface:(OGDBusInterfaceSkeleton*)interface;

/**
 * This method simply calls g_dbus_interface_skeleton_flush() on all
 * interfaces belonging to @object. See that method for when flushing
 * is useful.
 *
 */
- (void)flush;

/**
 * Removes @interface_ from @object.
 *
 * @param interface A #GDBusInterfaceSkeleton.
 */
- (void)removeInterface:(OGDBusInterfaceSkeleton*)interface;

/**
 * Removes the #GDBusInterface with @interface_name from @object.
 * 
 * If no D-Bus interface of the given interface exists, this function
 * does nothing.
 *
 * @param interfaceName A D-Bus interface name.
 */
- (void)removeInterfaceByName:(OFString*)interfaceName;

/**
 * Sets the object path for @object.
 *
 * @param objectPath A valid D-Bus object path.
 */
- (void)setObjectPath:(OFString*)objectPath;

@end