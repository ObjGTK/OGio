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
@class OGCredentials;
@class OGDBusAuthObserver;
@class OGDBusMessage;
@class OGIOStream;
@class OGMenuModel;
@class OGUnixFDList;

/**
 * The `GDBusConnection` type is used for D-Bus connections to remote
 * peers such as a message buses.
 * 
 * It is a low-level API that offers a lot of flexibility. For instance,
 * it lets you establish a connection over any transport that can by represented
 * as a [class@Gio.IOStream].
 * 
 * This class is rarely used directly in D-Bus clients. If you are writing
 * a D-Bus client, it is often easier to use the [func@Gio.bus_own_name],
 * [func@Gio.bus_watch_name] or [func@Gio.DBusProxy.new_for_bus] APIs.
 * 
 * As an exception to the usual GLib rule that a particular object must not
 * be used by two threads at the same time, `GDBusConnection`s methods may be
 * called from any thread. This is so that [func@Gio.bus_get] and
 * [func@Gio.bus_get_sync] can safely return the same `GDBusConnection` when
 * called from any thread.
 * 
 * Most of the ways to obtain a `GDBusConnection` automatically initialize it
 * (i.e. connect to D-Bus): for instance, [func@Gio.DBusConnection.new] and
 * [func@Gio.bus_get], and the synchronous versions of those methods, give you
 * an initialized connection. Language bindings for GIO should use
 * [func@Gio.Initable.new] or [func@Gio.AsyncInitable.new_async], which also
 * initialize the connection.
 * 
 * If you construct an uninitialized `GDBusConnection`, such as via
 * [ctor@GObject.Object.new], you must initialize it via [method@Gio.Initable.init] or
 * [method@Gio.AsyncInitable.init_async] before using its methods or properties.
 * Calling methods or accessing properties on a `GDBusConnection` that has not
 * completed initialization successfully is considered to be invalid, and leads
 * to undefined behaviour. In particular, if initialization fails with a
 * `GError`, the only valid thing you can do with that `GDBusConnection` is to
 * free it with [method@GObject.Object.unref].
 * 
 * ## An example D-Bus server
 * 
 * Here is an example for a D-Bus server:
 * [gdbus-example-server.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-server.c)
 * 
 * ## An example for exporting a subtree
 * 
 * Here is an example for exporting a subtree:
 * [gdbus-example-subtree.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-subtree.c)
 * 
 * ## An example for file descriptor passing
 * 
 * Here is an example for passing UNIX file descriptors:
 * [gdbus-unix-fd-client.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-unix-fd-client.c)
 * 
 * ## An example for exporting a GObject
 * 
 * Here is an example for exporting a #GObject:
 * [gdbus-example-export.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-export.c)
 *
 */
@interface OGDBusConnection : OGObject
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Asynchronously sets up a D-Bus connection for exchanging D-Bus messages
 * with the end represented by @stream.
 * 
 * If @stream is a #GSocketConnection, then the corresponding #GSocket
 * will be put into non-blocking mode.
 * 
 * The D-Bus connection will interact with @stream from a worker thread.
 * As a result, the caller should not interact with @stream after this
 * method has been called, except by calling g_object_unref() on it.
 * 
 * If @observer is not %NULL it may be used to control the
 * authentication process.
 * 
 * When the operation is finished, @callback will be invoked. You can
 * then call g_dbus_connection_new_finish() to get the result of the
 * operation.
 * 
 * This is an asynchronous failable constructor. See
 * g_dbus_connection_new_sync() for the synchronous
 * version.
 *
 * @param stream a #GIOStream
 * @param guid the GUID to use if authenticating as a server or %NULL
 * @param flags flags describing how to make the connection
 * @param observer a #GDBusAuthObserver or %NULL
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the request is satisfied
 * @param userData the data to pass to @callback
 */
+ (void)newWithStream:(OGIOStream*)stream guid:(OFString*)guid flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Asynchronously connects and sets up a D-Bus client connection for
 * exchanging D-Bus messages with an endpoint specified by @address
 * which must be in the
 * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 * 
 * This constructor can only be used to initiate client-side
 * connections - use g_dbus_connection_new() if you need to act as the
 * server. In particular, @flags cannot contain the
 * %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER,
 * %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS or
 * %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER flags.
 * 
 * When the operation is finished, @callback will be invoked. You can
 * then call g_dbus_connection_new_for_address_finish() to get the result of
 * the operation.
 * 
 * If @observer is not %NULL it may be used to control the
 * authentication process.
 * 
 * This is an asynchronous failable constructor. See
 * g_dbus_connection_new_for_address_sync() for the synchronous
 * version.
 *
 * @param address a D-Bus address
 * @param flags flags describing how to make the connection
 * @param observer a #GDBusAuthObserver or %NULL
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the request is satisfied
 * @param userData the data to pass to @callback
 */
+ (void)newForAddress:(OFString*)address flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Constructors
 */
+ (instancetype)dBusConnectionFinishWithRes:(GAsyncResult*)res;
+ (instancetype)dBusConnectionForAddressFinish:(GAsyncResult*)res;
+ (instancetype)dBusConnectionForAddressSync:(OFString*)address flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable;
+ (instancetype)dBusConnectionSyncWithStream:(OGIOStream*)stream guid:(OFString*)guid flags:(GDBusConnectionFlags)flags observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable;

/**
 * Methods
 */

- (GDBusConnection*)castedGObject;

/**
 * Adds a message filter. Filters are handlers that are run on all
 * incoming and outgoing messages, prior to standard dispatch. Filters
 * are run in the order that they were added.  The same handler can be
 * added as a filter more than once, in which case it will be run more
 * than once.  Filters added during a filter callback won't be run on
 * the message being processed. Filter functions are allowed to modify
 * and even drop messages.
 * 
 * Note that filters are run in a dedicated message handling thread so
 * they can't block and, generally, can't do anything but signal a
 * worker thread. Also note that filters are rarely needed - use API
 * such as g_dbus_connection_send_message_with_reply(),
 * g_dbus_connection_signal_subscribe() or g_dbus_connection_call() instead.
 * 
 * If a filter consumes an incoming message the message is not
 * dispatched anywhere else - not even the standard dispatch machinery
 * (that API such as g_dbus_connection_signal_subscribe() and
 * g_dbus_connection_send_message_with_reply() relies on) will see the
 * message. Similarly, if a filter consumes an outgoing message, the
 * message will not be sent to the other peer.
 * 
 * If @user_data_free_func is non-%NULL, it will be called (in the
 * thread-default main context of the thread you are calling this
 * method from) at some point after @user_data is no longer
 * needed. (It is not guaranteed to be called synchronously when the
 * filter is removed, and may be called after @connection has been
 * destroyed.)
 *
 * @param filterFunction a filter function
 * @param userData user data to pass to @filter_function
 * @param userDataFreeFunc function to free @user_data with when filter
 *     is removed or %NULL
 * @return a filter identifier that can be used with
 *     g_dbus_connection_remove_filter()
 */
- (guint)addFilterWithFilterFunction:(GDBusMessageFilterFunction)filterFunction userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc;

/**
 * Asynchronously invokes the @method_name method on the
 * @interface_name D-Bus interface on the remote object at
 * @object_path owned by @bus_name.
 * 
 * If @connection is closed then the operation will fail with
 * %G_IO_ERROR_CLOSED. If @cancellable is canceled, the operation will
 * fail with %G_IO_ERROR_CANCELLED. If @parameters contains a value
 * not compatible with the D-Bus protocol, the operation fails with
 * %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * If @reply_type is non-%NULL then the reply will be checked for having this type and an
 * error will be raised if it does not match.  Said another way, if you give a @reply_type
 * then any non-%NULL return value will be of this type. Unless it’s
 * %G_VARIANT_TYPE_UNIT, the @reply_type will be a tuple containing one or more
 * values.
 * 
 * If the @parameters #GVariant is floating, it is consumed. This allows
 * convenient 'inline' use of g_variant_new(), e.g.:
 * |[<!-- language="C" -->
 *  g_dbus_connection_call (connection,
 *                          "org.freedesktop.StringThings",
 *                          "/org/freedesktop/StringThings",
 *                          "org.freedesktop.StringThings",
 *                          "TwoStrings",
 *                          g_variant_new ("(ss)",
 *                                         "Thing One",
 *                                         "Thing Two"),
 *                          NULL,
 *                          G_DBUS_CALL_FLAGS_NONE,
 *                          -1,
 *                          NULL,
 *                          (GAsyncReadyCallback) two_strings_done,
 *                          NULL);
 * ]|
 * 
 * This is an asynchronous method. When the operation is finished,
 * @callback will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from. You can then call
 * g_dbus_connection_call_finish() to get the result of the operation.
 * See g_dbus_connection_call_sync() for the synchronous version of this
 * function.
 * 
 * If @callback is %NULL then the D-Bus method call message will be sent with
 * the %G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED flag set.
 *
 * @param busName a unique or well-known bus name or %NULL if
 *     @connection is not a message bus connection
 * @param objectPath path of remote object
 * @param interfaceName D-Bus interface to invoke method on
 * @param methodName the name of the method to invoke
 * @param parameters a #GVariant tuple with parameters for the method
 *     or %NULL if not passing parameters
 * @param replyType the expected type of the reply (which will be a
 *     tuple), or %NULL
 * @param flags flags from the #GDBusCallFlags enumeration
 * @param timeoutMsec the timeout in milliseconds, -1 to use the default
 *     timeout or %G_MAXINT for no timeout
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the request
 *     is satisfied or %NULL if you don't care about the result of the
 *     method invocation
 * @param userData the data to pass to @callback
 */
- (void)callWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_connection_call().
 *
 * @param res a #GAsyncResult obtained from the #GAsyncReadyCallback passed to g_dbus_connection_call()
 * @return %NULL if @error is set. Otherwise a non-floating
 *     #GVariant tuple with return values. Free with g_variant_unref().
 */
- (GVariant*)callFinishWithRes:(GAsyncResult*)res;

/**
 * Synchronously invokes the @method_name method on the
 * @interface_name D-Bus interface on the remote object at
 * @object_path owned by @bus_name.
 * 
 * If @connection is closed then the operation will fail with
 * %G_IO_ERROR_CLOSED. If @cancellable is canceled, the
 * operation will fail with %G_IO_ERROR_CANCELLED. If @parameters
 * contains a value not compatible with the D-Bus protocol, the operation
 * fails with %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * If @reply_type is non-%NULL then the reply will be checked for having
 * this type and an error will be raised if it does not match.  Said
 * another way, if you give a @reply_type then any non-%NULL return
 * value will be of this type.
 * 
 * If the @parameters #GVariant is floating, it is consumed.
 * This allows convenient 'inline' use of g_variant_new(), e.g.:
 * |[<!-- language="C" -->
 *  g_dbus_connection_call_sync (connection,
 *                               "org.freedesktop.StringThings",
 *                               "/org/freedesktop/StringThings",
 *                               "org.freedesktop.StringThings",
 *                               "TwoStrings",
 *                               g_variant_new ("(ss)",
 *                                              "Thing One",
 *                                              "Thing Two"),
 *                               NULL,
 *                               G_DBUS_CALL_FLAGS_NONE,
 *                               -1,
 *                               NULL,
 *                               &error);
 * ]|
 * 
 * The calling thread is blocked until a reply is received. See
 * g_dbus_connection_call() for the asynchronous version of
 * this method.
 *
 * @param busName a unique or well-known bus name or %NULL if
 *     @connection is not a message bus connection
 * @param objectPath path of remote object
 * @param interfaceName D-Bus interface to invoke method on
 * @param methodName the name of the method to invoke
 * @param parameters a #GVariant tuple with parameters for the method
 *     or %NULL if not passing parameters
 * @param replyType the expected type of the reply, or %NULL
 * @param flags flags from the #GDBusCallFlags enumeration
 * @param timeoutMsec the timeout in milliseconds, -1 to use the default
 *     timeout or %G_MAXINT for no timeout
 * @param cancellable a #GCancellable or %NULL
 * @return %NULL if @error is set. Otherwise a non-floating
 *     #GVariant tuple with return values. Free with g_variant_unref().
 */
- (GVariant*)callSyncWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable;

/**
 * Like g_dbus_connection_call() but also takes a #GUnixFDList object.
 * 
 * The file descriptors normally correspond to %G_VARIANT_TYPE_HANDLE
 * values in the body of the message. For example, if a message contains
 * two file descriptors, @fd_list would have length 2, and
 * `g_variant_new_handle (0)` and `g_variant_new_handle (1)` would appear
 * somewhere in the body of the message (not necessarily in that order!)
 * to represent the file descriptors at indexes 0 and 1 respectively.
 * 
 * When designing D-Bus APIs that are intended to be interoperable,
 * please note that non-GDBus implementations of D-Bus can usually only
 * access file descriptors if they are referenced in this way by a
 * value of type %G_VARIANT_TYPE_HANDLE in the body of the message.
 * 
 * This method is only available on UNIX.
 *
 * @param busName a unique or well-known bus name or %NULL if
 *     @connection is not a message bus connection
 * @param objectPath path of remote object
 * @param interfaceName D-Bus interface to invoke method on
 * @param methodName the name of the method to invoke
 * @param parameters a #GVariant tuple with parameters for the method
 *     or %NULL if not passing parameters
 * @param replyType the expected type of the reply, or %NULL
 * @param flags flags from the #GDBusCallFlags enumeration
 * @param timeoutMsec the timeout in milliseconds, -1 to use the default
 *     timeout or %G_MAXINT for no timeout
 * @param fdList a #GUnixFDList or %NULL
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the request is
 *     satisfied or %NULL if you don't * care about the result of the
 *     method invocation
 * @param userData The data to pass to @callback.
 */
- (void)callWithUnixFdListWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_connection_call_with_unix_fd_list().
 * 
 * The file descriptors normally correspond to %G_VARIANT_TYPE_HANDLE
 * values in the body of the message. For example,
 * if g_variant_get_handle() returns 5, that is intended to be a reference
 * to the file descriptor that can be accessed by
 * `g_unix_fd_list_get (*out_fd_list, 5, ...)`.
 * 
 * When designing D-Bus APIs that are intended to be interoperable,
 * please note that non-GDBus implementations of D-Bus can usually only
 * access file descriptors if they are referenced in this way by a
 * value of type %G_VARIANT_TYPE_HANDLE in the body of the message.
 *
 * @param outFdList return location for a #GUnixFDList or %NULL
 * @param res a #GAsyncResult obtained from the #GAsyncReadyCallback passed to
 *     g_dbus_connection_call_with_unix_fd_list()
 * @return %NULL if @error is set. Otherwise a non-floating
 *     #GVariant tuple with return values. Free with g_variant_unref().
 */
- (GVariant*)callWithUnixFdListFinishWithOutFdList:(GUnixFDList**)outFdList res:(GAsyncResult*)res;

/**
 * Like g_dbus_connection_call_sync() but also takes and returns #GUnixFDList objects.
 * See g_dbus_connection_call_with_unix_fd_list() and
 * g_dbus_connection_call_with_unix_fd_list_finish() for more details.
 * 
 * This method is only available on UNIX.
 *
 * @param busName a unique or well-known bus name or %NULL
 *     if @connection is not a message bus connection
 * @param objectPath path of remote object
 * @param interfaceName D-Bus interface to invoke method on
 * @param methodName the name of the method to invoke
 * @param parameters a #GVariant tuple with parameters for
 *     the method or %NULL if not passing parameters
 * @param replyType the expected type of the reply, or %NULL
 * @param flags flags from the #GDBusCallFlags enumeration
 * @param timeoutMsec the timeout in milliseconds, -1 to use the default
 *     timeout or %G_MAXINT for no timeout
 * @param fdList a #GUnixFDList or %NULL
 * @param outFdList return location for a #GUnixFDList or %NULL
 * @param cancellable a #GCancellable or %NULL
 * @return %NULL if @error is set. Otherwise a non-floating
 *     #GVariant tuple with return values. Free with g_variant_unref().
 */
- (GVariant*)callWithUnixFdListSyncWithBusName:(OFString*)busName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName methodName:(OFString*)methodName parameters:(GVariant*)parameters replyType:(const GVariantType*)replyType flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList outFdList:(GUnixFDList**)outFdList cancellable:(OGCancellable*)cancellable;

/**
 * Closes @connection. Note that this never causes the process to
 * exit (this might only happen if the other end of a shared message
 * bus connection disconnects, see #GDBusConnection:exit-on-close).
 * 
 * Once the connection is closed, operations such as sending a message
 * will return with the error %G_IO_ERROR_CLOSED. Closing a connection
 * will not automatically flush the connection so queued messages may
 * be lost. Use g_dbus_connection_flush() if you need such guarantees.
 * 
 * If @connection is already closed, this method fails with
 * %G_IO_ERROR_CLOSED.
 * 
 * When @connection has been closed, the #GDBusConnection::closed
 * signal is emitted in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread that @connection was constructed in.
 * 
 * This is an asynchronous method. When the operation is finished,
 * @callback will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from. You can
 * then call g_dbus_connection_close_finish() to get the result of the
 * operation. See g_dbus_connection_close_sync() for the synchronous
 * version.
 *
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the request is
 *     satisfied or %NULL if you don't care about the result
 * @param userData The data to pass to @callback
 */
- (void)closeWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_connection_close().
 *
 * @param res a #GAsyncResult obtained from the #GAsyncReadyCallback passed
 *     to g_dbus_connection_close()
 * @return %TRUE if the operation succeeded, %FALSE if @error is set
 */
- (bool)closeFinishWithRes:(GAsyncResult*)res;

/**
 * Synchronously closes @connection. The calling thread is blocked
 * until this is done. See g_dbus_connection_close() for the
 * asynchronous version of this method and more details about what it
 * does.
 *
 * @param cancellable a #GCancellable or %NULL
 * @return %TRUE if the operation succeeded, %FALSE if @error is set
 */
- (bool)closeSyncWithCancellable:(OGCancellable*)cancellable;

/**
 * Emits a signal.
 * 
 * If the parameters GVariant is floating, it is consumed.
 * 
 * This can only fail if @parameters is not compatible with the D-Bus protocol
 * (%G_IO_ERROR_INVALID_ARGUMENT), or if @connection has been closed
 * (%G_IO_ERROR_CLOSED).
 *
 * @param destinationBusName the unique bus name for the destination
 *     for the signal or %NULL to emit to all listeners
 * @param objectPath path of remote object
 * @param interfaceName D-Bus interface to emit a signal on
 * @param signalName the name of the signal to emit
 * @param parameters a #GVariant tuple with parameters for the signal
 *              or %NULL if not passing parameters
 * @return %TRUE unless @error is set
 */
- (bool)emitSignalWithDestinationBusName:(OFString*)destinationBusName objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName signalName:(OFString*)signalName parameters:(GVariant*)parameters;

/**
 * Exports @action_group on @connection at @object_path.
 * 
 * The implemented D-Bus API should be considered private.  It is
 * subject to change in the future.
 * 
 * A given object path can only have one action group exported on it.
 * If this constraint is violated, the export will fail and 0 will be
 * returned (with @error set accordingly).
 * 
 * You can unexport the action group using
 * g_dbus_connection_unexport_action_group() with the return value of
 * this function.
 * 
 * The thread default main context is taken at the time of this call.
 * All incoming action activations and state change requests are
 * reported from this context.  Any changes on the action group that
 * cause it to emit signals must also come from this same context.
 * Since incoming action activations and state change requests are
 * rather likely to cause changes on the action group, this effectively
 * limits a given action group to being exported from only one main
 * context.
 *
 * @param objectPath a D-Bus object path
 * @param actionGroup a #GActionGroup
 * @return the ID of the export (never zero), or 0 in case of failure
 */
- (guint)exportActionGroupWithObjectPath:(OFString*)objectPath actionGroup:(GActionGroup*)actionGroup;

/**
 * Exports @menu on @connection at @object_path.
 * 
 * The implemented D-Bus API should be considered private.
 * It is subject to change in the future.
 * 
 * An object path can only have one menu model exported on it. If this
 * constraint is violated, the export will fail and 0 will be
 * returned (with @error set accordingly).
 * 
 * Exporting menus with sections containing more than
 * %G_MENU_EXPORTER_MAX_SECTION_SIZE items is not supported and results in
 * undefined behavior.
 * 
 * You can unexport the menu model using
 * g_dbus_connection_unexport_menu_model() with the return value of
 * this function.
 *
 * @param objectPath a D-Bus object path
 * @param menu a #GMenuModel
 * @return the ID of the export (never zero), or 0 in case of failure
 */
- (guint)exportMenuModelWithObjectPath:(OFString*)objectPath menu:(OGMenuModel*)menu;

/**
 * Asynchronously flushes @connection, that is, writes all queued
 * outgoing message to the transport and then flushes the transport
 * (using g_output_stream_flush_async()). This is useful in programs
 * that wants to emit a D-Bus signal and then exit immediately. Without
 * flushing the connection, there is no guaranteed that the message has
 * been sent to the networking buffers in the OS kernel.
 * 
 * This is an asynchronous method. When the operation is finished,
 * @callback will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from. You can
 * then call g_dbus_connection_flush_finish() to get the result of the
 * operation. See g_dbus_connection_flush_sync() for the synchronous
 * version.
 *
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the
 *     request is satisfied or %NULL if you don't care about the result
 * @param userData The data to pass to @callback
 */
- (void)flushWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_connection_flush().
 *
 * @param res a #GAsyncResult obtained from the #GAsyncReadyCallback passed
 *     to g_dbus_connection_flush()
 * @return %TRUE if the operation succeeded, %FALSE if @error is set
 */
- (bool)flushFinishWithRes:(GAsyncResult*)res;

/**
 * Synchronously flushes @connection. The calling thread is blocked
 * until this is done. See g_dbus_connection_flush() for the
 * asynchronous version of this method and more details about what it
 * does.
 *
 * @param cancellable a #GCancellable or %NULL
 * @return %TRUE if the operation succeeded, %FALSE if @error is set
 */
- (bool)flushSyncWithCancellable:(OGCancellable*)cancellable;

/**
 * Gets the capabilities negotiated with the remote peer
 *
 * @return zero or more flags from the #GDBusCapabilityFlags enumeration
 */
- (GDBusCapabilityFlags)capabilities;

/**
 * Gets whether the process is terminated when @connection is
 * closed by the remote peer. See
 * #GDBusConnection:exit-on-close for more details.
 *
 * @return whether the process is terminated when @connection is
 *     closed by the remote peer
 */
- (bool)exitOnClose;

/**
 * Gets the flags used to construct this connection
 *
 * @return zero or more flags from the #GDBusConnectionFlags enumeration
 */
- (GDBusConnectionFlags)flags;

/**
 * The GUID of the peer performing the role of server when
 * authenticating. See #GDBusConnection:guid for more details.
 *
 * @return The GUID. Do not free this string, it is owned by
 *     @connection.
 */
- (OFString*)guid;

/**
 * Retrieves the last serial number assigned to a #GDBusMessage on
 * the current thread. This includes messages sent via both low-level
 * API such as g_dbus_connection_send_message() as well as
 * high-level API such as g_dbus_connection_emit_signal(),
 * g_dbus_connection_call() or g_dbus_proxy_call().
 *
 * @return the last used serial or zero when no message has been sent
 *     within the current thread
 */
- (guint32)lastSerial;

/**
 * Gets the credentials of the authenticated peer. This will always
 * return %NULL unless @connection acted as a server
 * (e.g. %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER was passed)
 * when set up and the client passed credentials as part of the
 * authentication process.
 * 
 * In a message bus setup, the message bus is always the server and
 * each application is a client. So this method will always return
 * %NULL for message bus clients.
 *
 * @return a #GCredentials or %NULL if not
 *     available. Do not free this object, it is owned by @connection.
 */
- (OGCredentials*)peerCredentials;

/**
 * Gets the underlying stream used for IO.
 * 
 * While the #GDBusConnection is active, it will interact with this
 * stream from a worker thread, so it is not safe to interact with
 * the stream directly.
 *
 * @return the stream used for IO
 */
- (OGIOStream*)stream;

/**
 * Gets the unique name of @connection as assigned by the message
 * bus. This can also be used to figure out if @connection is a
 * message bus connection.
 *
 * @return the unique name or %NULL if @connection is not a message
 *     bus connection. Do not free this string, it is owned by
 *     @connection.
 */
- (OFString*)uniqueName;

/**
 * Gets whether @connection is closed.
 *
 * @return %TRUE if the connection is closed, %FALSE otherwise
 */
- (bool)isClosed;

/**
 * Registers callbacks for exported objects at @object_path with the
 * D-Bus interface that is described in @interface_info.
 * 
 * Calls to functions in @vtable (and @user_data_free_func) will happen
 * in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from.
 * 
 * Note that all #GVariant values passed to functions in @vtable will match
 * the signature given in @interface_info - if a remote caller passes
 * incorrect values, the `org.freedesktop.DBus.Error.InvalidArgs`
 * is returned to the remote caller.
 * 
 * Additionally, if the remote caller attempts to invoke methods or
 * access properties not mentioned in @interface_info the
 * `org.freedesktop.DBus.Error.UnknownMethod` resp.
 * `org.freedesktop.DBus.Error.InvalidArgs` errors
 * are returned to the caller.
 * 
 * It is considered a programming error if the
 * #GDBusInterfaceGetPropertyFunc function in @vtable returns a
 * #GVariant of incorrect type.
 * 
 * If an existing callback is already registered at @object_path and
 * @interface_name, then @error is set to %G_IO_ERROR_EXISTS.
 * 
 * GDBus automatically implements the standard D-Bus interfaces
 * org.freedesktop.DBus.Properties, org.freedesktop.DBus.Introspectable
 * and org.freedesktop.Peer, so you don't have to implement those for the
 * objects you export. You can implement org.freedesktop.DBus.Properties
 * yourself, e.g. to handle getting and setting of properties asynchronously.
 * 
 * Note that the reference count on @interface_info will be
 * incremented by 1 (unless allocated statically, e.g. if the
 * reference count is -1, see g_dbus_interface_info_ref()) for as long
 * as the object is exported. Also note that @vtable will be copied.
 * 
 * See this [server][gdbus-server] for an example of how to use this method.
 *
 * @param objectPath the object path to register at
 * @param interfaceInfo introspection data for the interface
 * @param vtable a #GDBusInterfaceVTable to call into or %NULL
 * @param userData data to pass to functions in @vtable
 * @param userDataFreeFunc function to call when the object path is unregistered
 * @return 0 if @error is set, otherwise a registration id (never 0)
 *     that can be used with g_dbus_connection_unregister_object()
 */
- (guint)registerObjectWithObjectPath:(OFString*)objectPath interfaceInfo:(GDBusInterfaceInfo*)interfaceInfo vtable:(const GDBusInterfaceVTable*)vtable userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc;

/**
 * Version of g_dbus_connection_register_object() using closures instead of a
 * #GDBusInterfaceVTable for easier binding in other languages.
 *
 * @param objectPath The object path to register at.
 * @param interfaceInfo Introspection data for the interface.
 * @param methodCallClosure #GClosure for handling incoming method calls.
 * @param getPropertyClosure #GClosure for getting a property.
 * @param setPropertyClosure #GClosure for setting a property.
 * @return 0 if @error is set, otherwise a registration ID (never 0)
 * that can be used with g_dbus_connection_unregister_object() .
 */
- (guint)registerObjectWithClosuresWithObjectPath:(OFString*)objectPath interfaceInfo:(GDBusInterfaceInfo*)interfaceInfo methodCallClosure:(GClosure*)methodCallClosure getPropertyClosure:(GClosure*)getPropertyClosure setPropertyClosure:(GClosure*)setPropertyClosure;

/**
 * Registers a whole subtree of dynamic objects.
 * 
 * The @enumerate and @introspection functions in @vtable are used to
 * convey, to remote callers, what nodes exist in the subtree rooted
 * by @object_path.
 * 
 * When handling remote calls into any node in the subtree, first the
 * @enumerate function is used to check if the node exists. If the node exists
 * or the %G_DBUS_SUBTREE_FLAGS_DISPATCH_TO_UNENUMERATED_NODES flag is set
 * the @introspection function is used to check if the node supports the
 * requested method. If so, the @dispatch function is used to determine
 * where to dispatch the call. The collected #GDBusInterfaceVTable and
 * #gpointer will be used to call into the interface vtable for processing
 * the request.
 * 
 * All calls into user-provided code will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from.
 * 
 * If an existing subtree is already registered at @object_path or
 * then @error is set to %G_IO_ERROR_EXISTS.
 * 
 * Note that it is valid to register regular objects (using
 * g_dbus_connection_register_object()) in a subtree registered with
 * g_dbus_connection_register_subtree() - if so, the subtree handler
 * is tried as the last resort. One way to think about a subtree
 * handler is to consider it a fallback handler for object paths not
 * registered via g_dbus_connection_register_object() or other bindings.
 * 
 * Note that @vtable will be copied so you cannot change it after
 * registration.
 * 
 * See this [server][gdbus-subtree-server] for an example of how to use
 * this method.
 *
 * @param objectPath the object path to register the subtree at
 * @param vtable a #GDBusSubtreeVTable to enumerate, introspect and
 *     dispatch nodes in the subtree
 * @param flags flags used to fine tune the behavior of the subtree
 * @param userData data to pass to functions in @vtable
 * @param userDataFreeFunc function to call when the subtree is unregistered
 * @return 0 if @error is set, otherwise a subtree registration ID (never 0)
 * that can be used with g_dbus_connection_unregister_subtree()
 */
- (guint)registerSubtreeWithObjectPath:(OFString*)objectPath vtable:(const GDBusSubtreeVTable*)vtable flags:(GDBusSubtreeFlags)flags userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc;

/**
 * Removes a filter.
 * 
 * Note that since filters run in a different thread, there is a race
 * condition where it is possible that the filter will be running even
 * after calling g_dbus_connection_remove_filter(), so you cannot just
 * free data that the filter might be using. Instead, you should pass
 * a #GDestroyNotify to g_dbus_connection_add_filter(), which will be
 * called when it is guaranteed that the data is no longer needed.
 *
 * @param filterId an identifier obtained from g_dbus_connection_add_filter()
 */
- (void)removeFilterWithFilterId:(guint)filterId;

/**
 * Asynchronously sends @message to the peer represented by @connection.
 * 
 * Unless @flags contain the
 * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag, the serial number
 * will be assigned by @connection and set on @message via
 * g_dbus_message_set_serial(). If @out_serial is not %NULL, then the
 * serial number used will be written to this location prior to
 * submitting the message to the underlying transport. While it has a `volatile`
 * qualifier, this is a historical artifact and the argument passed to it should
 * not be `volatile`.
 * 
 * If @connection is closed then the operation will fail with
 * %G_IO_ERROR_CLOSED. If @message is not well-formed,
 * the operation fails with %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
 * for an example of how to use this low-level API to send and receive
 * UNIX file descriptors.
 * 
 * Note that @message must be unlocked, unless @flags contain the
 * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag.
 *
 * @param message a #GDBusMessage
 * @param flags flags affecting how the message is sent
 * @param outSerial return location for serial number assigned
 *     to @message when sending it or %NULL
 * @return %TRUE if the message was well-formed and queued for
 *     transmission, %FALSE if @error is set
 */
- (bool)sendMessage:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags outSerial:(volatile guint32*)outSerial;

/**
 * Asynchronously sends @message to the peer represented by @connection.
 * 
 * Unless @flags contain the
 * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag, the serial number
 * will be assigned by @connection and set on @message via
 * g_dbus_message_set_serial(). If @out_serial is not %NULL, then the
 * serial number used will be written to this location prior to
 * submitting the message to the underlying transport. While it has a `volatile`
 * qualifier, this is a historical artifact and the argument passed to it should
 * not be `volatile`.
 * 
 * If @connection is closed then the operation will fail with
 * %G_IO_ERROR_CLOSED. If @cancellable is canceled, the operation will
 * fail with %G_IO_ERROR_CANCELLED. If @message is not well-formed,
 * the operation fails with %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * This is an asynchronous method. When the operation is finished, @callback
 * will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from. You can then call
 * g_dbus_connection_send_message_with_reply_finish() to get the result of the operation.
 * See g_dbus_connection_send_message_with_reply_sync() for the synchronous version.
 * 
 * Note that @message must be unlocked, unless @flags contain the
 * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag.
 * 
 * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
 * for an example of how to use this low-level API to send and receive
 * UNIX file descriptors.
 *
 * @param message a #GDBusMessage
 * @param flags flags affecting how the message is sent
 * @param timeoutMsec the timeout in milliseconds, -1 to use the default
 *     timeout or %G_MAXINT for no timeout
 * @param outSerial return location for serial number assigned
 *     to @message when sending it or %NULL
 * @param cancellable a #GCancellable or %NULL
 * @param callback a #GAsyncReadyCallback to call when the request
 *     is satisfied or %NULL if you don't care about the result
 * @param userData The data to pass to @callback
 */
- (void)sendMessageWithReply:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags timeoutMsec:(gint)timeoutMsec outSerial:(volatile guint32*)outSerial cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an operation started with g_dbus_connection_send_message_with_reply().
 * 
 * Note that @error is only set if a local in-process error
 * occurred. That is to say that the returned #GDBusMessage object may
 * be of type %G_DBUS_MESSAGE_TYPE_ERROR. Use
 * g_dbus_message_to_gerror() to transcode this to a #GError.
 * 
 * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
 * for an example of how to use this low-level API to send and receive
 * UNIX file descriptors.
 *
 * @param res a #GAsyncResult obtained from the #GAsyncReadyCallback passed to
 *     g_dbus_connection_send_message_with_reply()
 * @return a locked #GDBusMessage or %NULL if @error is set
 */
- (OGDBusMessage*)sendMessageWithReplyFinishWithRes:(GAsyncResult*)res;

/**
 * Synchronously sends @message to the peer represented by @connection
 * and blocks the calling thread until a reply is received or the
 * timeout is reached. See g_dbus_connection_send_message_with_reply()
 * for the asynchronous version of this method.
 * 
 * Unless @flags contain the
 * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag, the serial number
 * will be assigned by @connection and set on @message via
 * g_dbus_message_set_serial(). If @out_serial is not %NULL, then the
 * serial number used will be written to this location prior to
 * submitting the message to the underlying transport. While it has a `volatile`
 * qualifier, this is a historical artifact and the argument passed to it should
 * not be `volatile`.
 * 
 * If @connection is closed then the operation will fail with
 * %G_IO_ERROR_CLOSED. If @cancellable is canceled, the operation will
 * fail with %G_IO_ERROR_CANCELLED. If @message is not well-formed,
 * the operation fails with %G_IO_ERROR_INVALID_ARGUMENT.
 * 
 * Note that @error is only set if a local in-process error
 * occurred. That is to say that the returned #GDBusMessage object may
 * be of type %G_DBUS_MESSAGE_TYPE_ERROR. Use
 * g_dbus_message_to_gerror() to transcode this to a #GError.
 * 
 * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
 * for an example of how to use this low-level API to send and receive
 * UNIX file descriptors.
 * 
 * Note that @message must be unlocked, unless @flags contain the
 * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag.
 *
 * @param message a #GDBusMessage
 * @param flags flags affecting how the message is sent.
 * @param timeoutMsec the timeout in milliseconds, -1 to use the default
 *     timeout or %G_MAXINT for no timeout
 * @param outSerial return location for serial number
 *     assigned to @message when sending it or %NULL
 * @param cancellable a #GCancellable or %NULL
 * @return a locked #GDBusMessage that is the reply
 *     to @message or %NULL if @error is set
 */
- (OGDBusMessage*)sendMessageWithReplySync:(OGDBusMessage*)message flags:(GDBusSendMessageFlags)flags timeoutMsec:(gint)timeoutMsec outSerial:(volatile guint32*)outSerial cancellable:(OGCancellable*)cancellable;

/**
 * Sets whether the process should be terminated when @connection is
 * closed by the remote peer. See #GDBusConnection:exit-on-close for
 * more details.
 * 
 * Note that this function should be used with care. Most modern UNIX
 * desktops tie the notion of a user session with the session bus, and expect
 * all of a user's applications to quit when their bus connection goes away.
 * If you are setting @exit_on_close to %FALSE for the shared session
 * bus connection, you should make sure that your application exits
 * when the user session ends.
 *
 * @param exitOnClose whether the process should be terminated
 *     when @connection is closed by the remote peer
 */
- (void)setExitOnClose:(bool)exitOnClose;

/**
 * Subscribes to signals on @connection and invokes @callback whenever
 * the signal is received. Note that @callback will be invoked in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread you are calling this method from.
 * 
 * If @connection is not a message bus connection, @sender must be
 * %NULL.
 * 
 * If @sender is a well-known name note that @callback is invoked with
 * the unique name for the owner of @sender, not the well-known name
 * as one would expect. This is because the message bus rewrites the
 * name. As such, to avoid certain race conditions, users should be
 * tracking the name owner of the well-known name and use that when
 * processing the received signal.
 * 
 * If one of %G_DBUS_SIGNAL_FLAGS_MATCH_ARG0_NAMESPACE or
 * %G_DBUS_SIGNAL_FLAGS_MATCH_ARG0_PATH are given, @arg0 is
 * interpreted as part of a namespace or path.  The first argument
 * of a signal is matched against that part as specified by D-Bus.
 * 
 * If @user_data_free_func is non-%NULL, it will be called (in the
 * thread-default main context of the thread you are calling this
 * method from) at some point after @user_data is no longer
 * needed. (It is not guaranteed to be called synchronously when the
 * signal is unsubscribed from, and may be called after @connection
 * has been destroyed.)
 * 
 * As @callback is potentially invoked in a different thread from where it’s
 * emitted, it’s possible for this to happen after
 * g_dbus_connection_signal_unsubscribe() has been called in another thread.
 * Due to this, @user_data should have a strong reference which is freed with
 * @user_data_free_func, rather than pointing to data whose lifecycle is tied
 * to the signal subscription. For example, if a #GObject is used to store the
 * subscription ID from g_dbus_connection_signal_subscribe(), a strong reference
 * to that #GObject must be passed to @user_data, and g_object_unref() passed to
 * @user_data_free_func. You are responsible for breaking the resulting
 * reference count cycle by explicitly unsubscribing from the signal when
 * dropping the last external reference to the #GObject. Alternatively, a weak
 * reference may be used.
 * 
 * It is guaranteed that if you unsubscribe from a signal using
 * g_dbus_connection_signal_unsubscribe() from the same thread which made the
 * corresponding g_dbus_connection_signal_subscribe() call, @callback will not
 * be invoked after g_dbus_connection_signal_unsubscribe() returns.
 * 
 * The returned subscription identifier is an opaque value which is guaranteed
 * to never be zero.
 * 
 * This function can never fail.
 *
 * @param sender sender name to match on (unique or well-known name)
 *     or %NULL to listen from all senders
 * @param interfaceName D-Bus interface name to match on or %NULL to
 *     match on all interfaces
 * @param member D-Bus signal name to match on or %NULL to match on
 *     all signals
 * @param objectPath object path to match on or %NULL to match on
 *     all object paths
 * @param arg0 contents of first string argument to match on or %NULL
 *     to match on all kinds of arguments
 * @param flags #GDBusSignalFlags describing how arg0 is used in subscribing to the
 *     signal
 * @param callback callback to invoke when there is a signal matching the requested data
 * @param userData user data to pass to @callback
 * @param userDataFreeFunc function to free @user_data with when
 *     subscription is removed or %NULL
 * @return a subscription identifier that can be used with g_dbus_connection_signal_unsubscribe()
 */
- (guint)signalSubscribeWithSender:(OFString*)sender interfaceName:(OFString*)interfaceName member:(OFString*)member objectPath:(OFString*)objectPath arg0:(OFString*)arg0 flags:(GDBusSignalFlags)flags callback:(GDBusSignalCallback)callback userData:(gpointer)userData userDataFreeFunc:(GDestroyNotify)userDataFreeFunc;

/**
 * Unsubscribes from signals.
 * 
 * Note that there may still be D-Bus traffic to process (relating to this
 * signal subscription) in the current thread-default #GMainContext after this
 * function has returned. You should continue to iterate the #GMainContext
 * until the #GDestroyNotify function passed to
 * g_dbus_connection_signal_subscribe() is called, in order to avoid memory
 * leaks through callbacks queued on the #GMainContext after it’s stopped being
 * iterated.
 * Alternatively, any idle source with a priority lower than %G_PRIORITY_DEFAULT
 * that was scheduled after unsubscription, also indicates that all resources
 * of this subscription are released.
 *
 * @param subscriptionId a subscription id obtained from
 *     g_dbus_connection_signal_subscribe()
 */
- (void)signalUnsubscribeWithSubscriptionId:(guint)subscriptionId;

/**
 * If @connection was created with
 * %G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING, this method
 * starts processing messages. Does nothing on if @connection wasn't
 * created with this flag or if the method has already been called.
 *
 */
- (void)startMessageProcessing;

/**
 * Reverses the effect of a previous call to
 * g_dbus_connection_export_action_group().
 * 
 * It is an error to call this function with an ID that wasn't returned
 * from g_dbus_connection_export_action_group() or to call it with the
 * same ID more than once.
 *
 * @param exportId the ID from g_dbus_connection_export_action_group()
 */
- (void)unexportActionGroupWithExportId:(guint)exportId;

/**
 * Reverses the effect of a previous call to
 * g_dbus_connection_export_menu_model().
 * 
 * It is an error to call this function with an ID that wasn't returned
 * from g_dbus_connection_export_menu_model() or to call it with the
 * same ID more than once.
 *
 * @param exportId the ID from g_dbus_connection_export_menu_model()
 */
- (void)unexportMenuModelWithExportId:(guint)exportId;

/**
 * Unregisters an object.
 *
 * @param registrationId a registration id obtained from
 *     g_dbus_connection_register_object()
 * @return %TRUE if the object was unregistered, %FALSE otherwise
 */
- (bool)unregisterObjectWithRegistrationId:(guint)registrationId;

/**
 * Unregisters a subtree.
 *
 * @param registrationId a subtree registration id obtained from
 *     g_dbus_connection_register_subtree()
 * @return %TRUE if the subtree was unregistered, %FALSE otherwise
 */
- (bool)unregisterSubtreeWithRegistrationId:(guint)registrationId;

@end