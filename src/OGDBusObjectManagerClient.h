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
@class OGCancellable;

/**
 * `GDBusObjectManagerClient` is used to create, monitor and delete object
 * proxies for remote objects exported by a [class@Gio.DBusObjectManagerServer]
 * (or any code implementing the
 * [org.freedesktop.DBus.ObjectManager](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface).
 * 
 * Once an instance of this type has been created, you can connect to
 * the [signal@Gio.DBusObjectManager::object-added] and
 * [signal@Gio.DBusObjectManager::object-removed signals] and inspect the
 * [class@Gio.DBusObjectProxy] objects returned by
 * [method@Gio.DBusObjectManager.get_objects].
 * 
 * If the name for a `GDBusObjectManagerClient` is not owned by anyone at
 * object construction time, the default behavior is to request the
 * message bus to launch an owner for the name. This behavior can be
 * disabled using the `G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_DO_NOT_AUTO_START`
 * flag. It’s also worth noting that this only works if the name of
 * interest is activatable in the first place. E.g. in some cases it
 * is not possible to launch an owner for the requested name. In this
 * case, `GDBusObjectManagerClient` object construction still succeeds but
 * there will be no object proxies
 * (e.g. [method@Gio.DBusObjectManager.get_objects] returns the empty list) and
 * the [property@Gio.DBusObjectManagerClient:name-owner] property is `NULL`.
 * 
 * The owner of the requested name can come and go (for example
 * consider a system service being restarted) – `GDBusObjectManagerClient`
 * handles this case too; simply connect to the [signal@GObject.Object::notify]
 * signal to watch for changes on the
 * [property@Gio.DBusObjectManagerClient:name-owner] property. When the name
 * owner vanishes, the behavior is that
 * [property@Gio.DBusObjectManagerClient:name-owner] is set to `NULL` (this
 * includes emission of the [signal@GObject.Object::notify] signal) and then
 * [signal@Gio.DBusObjectManager::object-removed] signals are synthesized
 * for all currently existing object proxies. Since
 * [property@Gio.DBusObjectManagerClient:name-owner] is `NULL` when this
 * happens, you can use this information to disambiguate a synthesized signal
 * from a genuine signal caused by object removal on the remote
 * [iface@Gio.DBusObjectManager]. Similarly, when a new name owner appears,
 * [signal@Gio.DBusObjectManager::object-added] signals are synthesized
 * while [property@Gio.DBusObjectManagerClient:name-owner] is still `NULL`. Only
 * when all object proxies have been added, the
 * [property@Gio.DBusObjectManagerClient:name-owner] is set to the new name
 * owner (this includes emission of the [signal@GObject.Object::notify] signal).
 * Furthermore, you are guaranteed that
 * [property@Gio.DBusObjectManagerClient:name-owner] will alternate between a
 * name owner (e.g. `:1.42`) and `NULL` even in the case where
 * the name of interest is atomically replaced
 * 
 * Ultimately, `GDBusObjectManagerClient` is used to obtain
 * [class@Gio.DBusProxy] instances. All signals (including the
 * `org.freedesktop.DBus.Properties::PropertiesChanged` signal)
 * delivered to [class@Gio.DBusProxy] instances are guaranteed to originate
 * from the name owner. This guarantee along with the behavior
 * described above, means that certain race conditions including the
 * “half the proxy is from the old owner and the other half is from
 * the new owner” problem cannot happen.
 * 
 * To avoid having the application connect to signals on the returned
 * [class@Gio.DBusObjectProxy] and [class@Gio.DBusProxy] objects, the
 * [signal@Gio.DBusObject::interface-added],
 * [signal@Gio.DBusObject::interface-removed],
 * [signal@Gio.DBusProxy::g-properties-changed] and
 * [signal@Gio.DBusProxy::g-signal] signals
 * are also emitted on the `GDBusObjectManagerClient` instance managing these
 * objects. The signals emitted are
 * [signal@Gio.DBusObjectManager::interface-added],
 * [signal@Gio.DBusObjectManager::interface-removed],
 * [signal@Gio.DBusObjectManagerClient::interface-proxy-properties-changed] and
 * [signal@Gio.DBusObjectManagerClient::interface-proxy-signal].
 * 
 * Note that all callbacks and signals are emitted in the
 * thread-default main context (see
 * [method@GLib.MainContext.push_thread_default]) that the
 * `GDBusObjectManagerClient` object was constructed in. Additionally, the
 * [class@Gio.DBusObjectProxy] and [class@Gio.DBusProxy] objects
 * originating from the `GDBusObjectManagerClient` object will be created in
 * the same context and, consequently, will deliver signals in the
 * same main loop.
 *
 */
@interface OGDBusObjectManagerClient : OGObject
{

}

/**
 * Functions
 */

/**
 * Asynchronously creates a new #GDBusObjectManagerClient object.
 * 
 * This is an asynchronous failable constructor. When the result is
 * ready, @callback will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from. You can
 * then call g_dbus_object_manager_client_new_finish() to get the result. See
 * g_dbus_object_manager_client_new_sync() for the synchronous version.
 *
 * @param connection A #GDBusConnection.
 * @param flags Zero or more flags from the #GDBusObjectManagerClientFlags enumeration.
 * @param name The owner of the control object (unique or well-known name).
 * @param objectPath The object path of the control object.
 * @param getProxyTypeFunc A #GDBusProxyTypeFunc function or %NULL to always construct #GDBusProxy proxies.
 * @param getProxyTypeUserData User data to pass to @get_proxy_type_func.
 * @param getProxyTypeDestroyNotify Free function for @get_proxy_type_user_data or %NULL.
 * @param cancellable A #GCancellable or %NULL
 * @param callback A #GAsyncReadyCallback to call when the request is satisfied.
 * @param userData The data to pass to @callback.
 */
+ (void)newWithConnection:(OGDBusConnection*)connection flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Like g_dbus_object_manager_client_new() but takes a #GBusType instead of a
 * #GDBusConnection.
 * 
 * This is an asynchronous failable constructor. When the result is
 * ready, @callback will be invoked in the
 * [thread-default main loop][g-main-context-push-thread-default]
 * of the thread you are calling this method from. You can
 * then call g_dbus_object_manager_client_new_for_bus_finish() to get the result. See
 * g_dbus_object_manager_client_new_for_bus_sync() for the synchronous version.
 *
 * @param busType A #GBusType.
 * @param flags Zero or more flags from the #GDBusObjectManagerClientFlags enumeration.
 * @param name The owner of the control object (unique or well-known name).
 * @param objectPath The object path of the control object.
 * @param getProxyTypeFunc A #GDBusProxyTypeFunc function or %NULL to always construct #GDBusProxy proxies.
 * @param getProxyTypeUserData User data to pass to @get_proxy_type_func.
 * @param getProxyTypeDestroyNotify Free function for @get_proxy_type_user_data or %NULL.
 * @param cancellable A #GCancellable or %NULL
 * @param callback A #GAsyncReadyCallback to call when the request is satisfied.
 * @param userData The data to pass to @callback.
 */
+ (void)newForBusWithBusType:(GBusType)busType flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Constructors
 */
- (instancetype)initFinish:(GAsyncResult*)res;
- (instancetype)initForBusFinish:(GAsyncResult*)res;
- (instancetype)initForBusSyncWithBusType:(GBusType)busType flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable;
- (instancetype)initSyncWithConnection:(OGDBusConnection*)connection flags:(GDBusObjectManagerClientFlags)flags name:(OFString*)name objectPath:(OFString*)objectPath getProxyTypeFunc:(GDBusProxyTypeFunc)getProxyTypeFunc getProxyTypeUserData:(gpointer)getProxyTypeUserData getProxyTypeDestroyNotify:(GDestroyNotify)getProxyTypeDestroyNotify cancellable:(OGCancellable*)cancellable;

/**
 * Methods
 */

- (GDBusObjectManagerClient*)castedGObject;

/**
 * Gets the #GDBusConnection used by @manager.
 *
 * @return A #GDBusConnection object. Do not free,
 *   the object belongs to @manager.
 */
- (OGDBusConnection*)connection;

/**
 * Gets the flags that @manager was constructed with.
 *
 * @return Zero of more flags from the #GDBusObjectManagerClientFlags
 * enumeration.
 */
- (GDBusObjectManagerClientFlags)flags;

/**
 * Gets the name that @manager is for, or %NULL if not a message bus
 * connection.
 *
 * @return A unique or well-known name. Do not free, the string
 * belongs to @manager.
 */
- (OFString*)name;

/**
 * The unique name that owns the name that @manager is for or %NULL if
 * no-one currently owns that name. You can connect to the
 * #GObject::notify signal to track changes to the
 * #GDBusObjectManagerClient:name-owner property.
 *
 * @return The name owner or %NULL if no name owner
 * exists. Free with g_free().
 */
- (OFString*)nameOwner;

@end