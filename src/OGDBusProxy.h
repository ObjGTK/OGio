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

@class OGCancellable;
@class OGDBusConnection;
@class OGUnixFDList;

/**
 * `GDBusProxy` is a base class used for proxies to access a D-Bus
 * interface on a remote object. A `GDBusProxy` can be constructed for
 * both well-known and unique names.
 * 
 * By default, `GDBusProxy` will cache all properties (and listen to
 * changes) of the remote object, and proxy all signals that get
 * emitted. This behaviour can be changed by passing suitable
 * [flags@Gio.DBusProxyFlags] when the proxy is created. If the proxy is for a
 * well-known name, the property cache is flushed when the name owner
 * vanishes and reloaded when a name owner appears.
 * 
 * The unique name owner of the proxy’s name is tracked and can be read from
 * [property@Gio.DBusProxy:g-name-owner]. Connect to the
 * [signal@GObject.Object::notify] signal to get notified of changes.
 * Additionally, only signals and property changes emitted from the current name
 * owner are considered and calls are always sent to the current name owner.
 * This avoids a number of race conditions when the name is lost by one owner
 * and claimed by another. However, if no name owner currently exists,
 * then calls will be sent to the well-known name which may result in
 * the message bus launching an owner (unless
 * `G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START` is set).
 * 
 * If the proxy is for a stateless D-Bus service, where the name owner may
 * be started and stopped between calls, the
 * [property@Gio.DBusProxy:g-name-owner] tracking of `GDBusProxy` will cause the
 * proxy to drop signal and property changes from the service after it has
 * restarted for the first time. When interacting with a stateless D-Bus
 * service, do not use `GDBusProxy` — use direct D-Bus method calls and signal
 * connections.
 * 
 * The generic [signal@Gio.DBusProxy::g-properties-changed] and
 * [signal@Gio.DBusProxy::g-signal] signals are not very convenient to work
 * with. Therefore, the recommended way of working with proxies is to subclass
 * `GDBusProxy`, and have more natural properties and signals in your derived
 * class. This [example](migrating-gdbus.html#using-gdbus-codegen) shows how
 * this can easily be done using the [`gdbus-codegen`](gdbus-codegen.html) tool.
 * 
 * A `GDBusProxy` instance can be used from multiple threads but note
 * that all signals (e.g. [signal@Gio.DBusProxy::g-signal],
 * [signal@Gio.DBusProxy::g-properties-changed] and
 * [signal@GObject.Object::notify]) are emitted in the thread-default main
 * context (see [method@GLib.MainContext.push_thread_default]) of the thread
 * where the instance was constructed.
 * 
 * An example using a proxy for a well-known name can be found in
 * [`gdbus-example-watch-proxy.c`](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-watch-proxy.c).
 *
 */
@interface OGDBusProxy : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Creates a proxy for accessing @interface_name on the remote object
 * at @object_path owned by @name at @connection and asynchronously
 * loads D-Bus properties unless the
 * %G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES flag is used. Connect to
 * the #GDBusProxy::g-properties-changed signal to get notified about
 * property changes.
 * 
 * If the %G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS flag is not set, also sets up
 * match rules for signals. Connect to the #GDBusProxy::g-signal signal
 * to handle signals from the remote object.
 * 
 * If both %G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES and
 * %G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS are set, this constructor is
 * guaranteed to complete immediately without blocking.
 * 
 * If @name is a well-known name and the
 * %G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START and %G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START_AT_CONSTRUCTION
 * flags aren't set and no name owner currently exists, the message bus
 * will be requested to launch a name owner for the name.
 * 
 * This is a failable asynchronous constructor - when the proxy is
 * ready, @callback will be invoked and you can use
 * g_dbus_proxy_new_finish() to get the result.
 * 
 * See g_dbus_proxy_new_sync() and for a synchronous version of this constructor.
 * 
 * #GDBusProxy is used in this [example][gdbus-wellknown-proxy].
 *
 * @param connection A #GDBusConnection.
 * @param flags Flags used when constructing the proxy.
 * @param info A #GDBusInterfaceInfo specifying the minimal interface that @proxy conforms to or %NULL.
 * @param name A bus name (well-known or unique) or %NULL if @connection is not a message bus connection.
 * @param objectPath An object path.
 * @param interfaceName A D-Bus interface name.
 * @param cancellable A #GCancellable or %NULL.
 * @param callback Callback function to invoke when the proxy is ready.
 * @param userData User data to pass to @callback.
 */
+ (void)newWithConnection:(OGDBusConnection*)connection flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Like g_dbus_proxy_new() but takes a #GBusType instead of a #GDBusConnection.
 * 
 * #GDBusProxy is used in this [example][gdbus-wellknown-proxy].
 *
 * @param busType A #GBusType.
 * @param flags Flags used when constructing the proxy.
 * @param info A #GDBusInterfaceInfo specifying the minimal interface that @proxy conforms to or %NULL.
 * @param name A bus name (well-known or unique).
 * @param objectPath An object path.
 * @param interfaceName A D-Bus interface name.
 * @param cancellable A #GCancellable or %NULL.
 * @param callback Callback function to invoke when the proxy is ready.
 * @param userData User data to pass to @callback.
 */
+ (void)newForBusWithBusType:(GBusType)busType flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Constructors
 */
- (instancetype)initWithResFinish:(GAsyncResult*)res;
- (instancetype)initWithResForBusFinish:(GAsyncResult*)res;
- (instancetype)initForBusSyncWithBusType:(GBusType)busType flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable;
- (instancetype)initSyncWithConnection:(OGDBusConnection*)connection flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable;

/**
 * Methods
 */

- (GDBusProxy*)castedGObject;

/**
 * Asynchronously invokes the @method_name method on @proxy.
 * 
 * If @method_name contains any dots, then @name is split into interface and
 * method name parts. This allows using @proxy for invoking methods on
 * other interfaces.
 * 
 * If the #GDBusConnection associated with @proxy is closed then
 * the operation will fail with %G_IO_ERROR_CLOSED. If
 * @cancellable is canceled, the operation will fail with
 * %G_IO_ERROR_CANCELLED. If @parameters contains a value not
 * compatible with the D-Bus protocol, the operation fails with
 * %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * If the @parameters #GVariant is floating, it is consumed. This allows
 * convenient 'inline' use of g_variant_new(), e.g.:
 * |[<!-- language="C" -->
 *  g_dbus_proxy_call (proxy,
 *                     "TwoStrings",
 *                     g_variant_new ("(ss)",
 *                                    "Thing One",
 *                                    "Thing Two"),
 *                     G_DBUS_CALL_FLAGS_NONE,
 *                     -1,
 *                     NULL,
 *                     (GAsyncReadyCallback) two_strings_done,
 *                     &data);
 * ]|
 * 
 * If @proxy has an expected interface (see
 * #GDBusProxy:g-interface-info) and @method_name is referenced by it,
 * then the return value is checked against the return type.
 * 
 * This is an asynchronous method. When the operation is finished,
 * @callback will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from.
 * You can then call g_dbus_proxy_call_finish() to get the result of
 * the operation. See g_dbus_proxy_call_sync() for the synchronous
 * version of this method.
 * 
 * If @callback is %NULL then the D-Bus method call message will be sent with
 * the %G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED flag set.
 *
 * @param methodName Name of method to invoke.
 * @param parameters A #GVariant tuple with parameters for the signal or %NULL if not passing parameters.
 * @param flags Flags from the #GDBusCallFlags enumeration.
 * @param timeoutMsec The timeout in milliseconds (with %G_MAXINT meaning
 *                "infinite") or -1 to use the proxy default timeout.
 * @param cancellable A #GCancellable or %NULL.
 * @param callback A #GAsyncReadyCallback to call when the request is satisfied or %NULL if you don't
 * care about the result of the method invocation.
 * @param userData The data to pass to @callback.
 */
- (void)callWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_proxy_call().
 *
 * @param res A #GAsyncResult obtained from the #GAsyncReadyCallback passed to g_dbus_proxy_call().
 * @return %NULL if @error is set. Otherwise a #GVariant tuple with
 * return values. Free with g_variant_unref().
 */
- (GVariant*)callFinish:(GAsyncResult*)res;

/**
 * Synchronously invokes the @method_name method on @proxy.
 * 
 * If @method_name contains any dots, then @name is split into interface and
 * method name parts. This allows using @proxy for invoking methods on
 * other interfaces.
 * 
 * If the #GDBusConnection associated with @proxy is disconnected then
 * the operation will fail with %G_IO_ERROR_CLOSED. If
 * @cancellable is canceled, the operation will fail with
 * %G_IO_ERROR_CANCELLED. If @parameters contains a value not
 * compatible with the D-Bus protocol, the operation fails with
 * %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * If the @parameters #GVariant is floating, it is consumed. This allows
 * convenient 'inline' use of g_variant_new(), e.g.:
 * |[<!-- language="C" -->
 *  g_dbus_proxy_call_sync (proxy,
 *                          "TwoStrings",
 *                          g_variant_new ("(ss)",
 *                                         "Thing One",
 *                                         "Thing Two"),
 *                          G_DBUS_CALL_FLAGS_NONE,
 *                          -1,
 *                          NULL,
 *                          &error);
 * ]|
 * 
 * The calling thread is blocked until a reply is received. See
 * g_dbus_proxy_call() for the asynchronous version of this
 * method.
 * 
 * If @proxy has an expected interface (see
 * #GDBusProxy:g-interface-info) and @method_name is referenced by it,
 * then the return value is checked against the return type.
 *
 * @param methodName Name of method to invoke.
 * @param parameters A #GVariant tuple with parameters for the signal
 *              or %NULL if not passing parameters.
 * @param flags Flags from the #GDBusCallFlags enumeration.
 * @param timeoutMsec The timeout in milliseconds (with %G_MAXINT meaning
 *                "infinite") or -1 to use the proxy default timeout.
 * @param cancellable A #GCancellable or %NULL.
 * @return %NULL if @error is set. Otherwise a #GVariant tuple with
 * return values. Free with g_variant_unref().
 */
- (GVariant*)callSyncWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable;

/**
 * Like g_dbus_proxy_call() but also takes a #GUnixFDList object.
 * 
 * This method is only available on UNIX.
 *
 * @param methodName Name of method to invoke.
 * @param parameters A #GVariant tuple with parameters for the signal or %NULL if not passing parameters.
 * @param flags Flags from the #GDBusCallFlags enumeration.
 * @param timeoutMsec The timeout in milliseconds (with %G_MAXINT meaning
 *                "infinite") or -1 to use the proxy default timeout.
 * @param fdList A #GUnixFDList or %NULL.
 * @param cancellable A #GCancellable or %NULL.
 * @param callback A #GAsyncReadyCallback to call when the request is satisfied or %NULL if you don't
 * care about the result of the method invocation.
 * @param userData The data to pass to @callback.
 */
- (void)callWithUnixFdListWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_proxy_call_with_unix_fd_list().
 *
 * @param outFdList Return location for a #GUnixFDList or %NULL.
 * @param res A #GAsyncResult obtained from the #GAsyncReadyCallback passed to g_dbus_proxy_call_with_unix_fd_list().
 * @return %NULL if @error is set. Otherwise a #GVariant tuple with
 * return values. Free with g_variant_unref().
 */
- (GVariant*)callWithUnixFdListFinishWithOutFdList:(GUnixFDList**)outFdList res:(GAsyncResult*)res;

/**
 * Like g_dbus_proxy_call_sync() but also takes and returns #GUnixFDList objects.
 * 
 * This method is only available on UNIX.
 *
 * @param methodName Name of method to invoke.
 * @param parameters A #GVariant tuple with parameters for the signal
 *              or %NULL if not passing parameters.
 * @param flags Flags from the #GDBusCallFlags enumeration.
 * @param timeoutMsec The timeout in milliseconds (with %G_MAXINT meaning
 *                "infinite") or -1 to use the proxy default timeout.
 * @param fdList A #GUnixFDList or %NULL.
 * @param outFdList Return location for a #GUnixFDList or %NULL.
 * @param cancellable A #GCancellable or %NULL.
 * @return %NULL if @error is set. Otherwise a #GVariant tuple with
 * return values. Free with g_variant_unref().
 */
- (GVariant*)callWithUnixFdListSyncWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList outFdList:(GUnixFDList**)outFdList cancellable:(OGCancellable*)cancellable;

/**
 * Looks up the value for a property from the cache. This call does no
 * blocking IO.
 * 
 * If @proxy has an expected interface (see
 * #GDBusProxy:g-interface-info) and @property_name is referenced by
 * it, then @value is checked against the type of the property.
 *
 * @param propertyName Property name.
 * @return A reference to the #GVariant instance
 *    that holds the value for @property_name or %NULL if the value is not in
 *    the cache. The returned reference must be freed with g_variant_unref().
 */
- (GVariant*)cachedProperty:(OFString*)propertyName;

/**
 * Gets the names of all cached properties on @proxy.
 *
 * @return A
 *          %NULL-terminated array of strings or %NULL if
 *          @proxy has no cached properties. Free the returned array with
 *          g_strfreev().
 */
- (gchar**)cachedPropertyNames;

/**
 * Gets the connection @proxy is for.
 *
 * @return A #GDBusConnection owned by @proxy. Do not free.
 */
- (OGDBusConnection*)connection;

/**
 * Gets the timeout to use if -1 (specifying default timeout) is
 * passed as @timeout_msec in the g_dbus_proxy_call() and
 * g_dbus_proxy_call_sync() functions.
 * 
 * See the #GDBusProxy:g-default-timeout property for more details.
 *
 * @return Timeout to use for @proxy.
 */
- (gint)defaultTimeout;

/**
 * Gets the flags that @proxy was constructed with.
 *
 * @return Flags from the #GDBusProxyFlags enumeration.
 */
- (GDBusProxyFlags)flags;

/**
 * Returns the #GDBusInterfaceInfo, if any, specifying the interface
 * that @proxy conforms to. See the #GDBusProxy:g-interface-info
 * property for more details.
 *
 * @return A #GDBusInterfaceInfo or %NULL.
 *    Do not unref the returned object, it is owned by @proxy.
 */
- (GDBusInterfaceInfo*)interfaceInfo;

/**
 * Gets the D-Bus interface name @proxy is for.
 *
 * @return A string owned by @proxy. Do not free.
 */
- (OFString*)interfaceName;

/**
 * Gets the name that @proxy was constructed for.
 * 
 * When connected to a message bus, this will usually be non-%NULL.
 * However, it may be %NULL for a proxy that communicates using a peer-to-peer
 * pattern.
 *
 * @return A string owned by @proxy. Do not free.
 */
- (OFString*)name;

/**
 * The unique name that owns the name that @proxy is for or %NULL if
 * no-one currently owns that name. You may connect to the
 * #GObject::notify signal to track changes to the
 * #GDBusProxy:g-name-owner property.
 *
 * @return The name owner or %NULL if no name
 *    owner exists. Free with g_free().
 */
- (OFString*)nameOwner;

/**
 * Gets the object path @proxy is for.
 *
 * @return A string owned by @proxy. Do not free.
 */
- (OFString*)objectPath;

/**
 * If @value is not %NULL, sets the cached value for the property with
 * name @property_name to the value in @value.
 * 
 * If @value is %NULL, then the cached value is removed from the
 * property cache.
 * 
 * If @proxy has an expected interface (see
 * #GDBusProxy:g-interface-info) and @property_name is referenced by
 * it, then @value is checked against the type of the property.
 * 
 * If the @value #GVariant is floating, it is consumed. This allows
 * convenient 'inline' use of g_variant_new(), e.g.
 * |[<!-- language="C" -->
 *  g_dbus_proxy_set_cached_property (proxy,
 *                                    "SomeProperty",
 *                                    g_variant_new ("(si)",
 *                                                  "A String",
 *                                                  42));
 * ]|
 * 
 * Normally you will not need to use this method since @proxy
 * is tracking changes using the
 * `org.freedesktop.DBus.Properties.PropertiesChanged`
 * D-Bus signal. However, for performance reasons an object may
 * decide to not use this signal for some properties and instead
 * use a proprietary out-of-band mechanism to transmit changes.
 * 
 * As a concrete example, consider an object with a property
 * `ChatroomParticipants` which is an array of strings. Instead of
 * transmitting the same (long) array every time the property changes,
 * it is more efficient to only transmit the delta using e.g. signals
 * `ChatroomParticipantJoined(String name)` and
 * `ChatroomParticipantParted(String name)`.
 *
 * @param propertyName Property name.
 * @param value Value for the property or %NULL to remove it from the cache.
 */
- (void)setCachedPropertyWithPropertyName:(OFString*)propertyName value:(GVariant*)value;

/**
 * Sets the timeout to use if -1 (specifying default timeout) is
 * passed as @timeout_msec in the g_dbus_proxy_call() and
 * g_dbus_proxy_call_sync() functions.
 * 
 * See the #GDBusProxy:g-default-timeout property for more details.
 *
 * @param timeoutMsec Timeout in milliseconds.
 */
- (void)setDefaultTimeout:(gint)timeoutMsec;

/**
 * Ensure that interactions with @proxy conform to the given
 * interface. See the #GDBusProxy:g-interface-info property for more
 * details.
 *
 * @param info Minimum interface this proxy conforms to
 *    or %NULL to unset.
 */
- (void)setInterfaceInfo:(GDBusInterfaceInfo*)info;

@end