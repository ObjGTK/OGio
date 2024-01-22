/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixfdmessage.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

@class OGSocketAddress;
@class OGSocket;
@class OGSocketConnection;
@class OGCancellable;

/**
 * A #GSocketListener is an object that keeps track of a set
 * of server sockets and helps you accept sockets from any of the
 * socket, either sync or async.
 * 
 * Add addresses and ports to listen on using g_socket_listener_add_address()
 * and g_socket_listener_add_inet_port(). These will be listened on until
 * g_socket_listener_close() is called. Dropping your final reference to the
 * #GSocketListener will not cause g_socket_listener_close() to be called
 * implicitly, as some references to the #GSocketListener may be held
 * internally.
 * 
 * If you want to implement a network server, also look at #GSocketService
 * and #GThreadedSocketService which are subclasses of #GSocketListener
 * that make this even easier.
 *
 */
@interface OGSocketListener : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init;

/**
 * Methods
 */

- (GSocketListener*)castedGObject;

/**
 * Blocks waiting for a client to connect to any of the sockets added
 * to the listener. Returns a #GSocketConnection for the socket that was
 * accepted.
 * 
 * If @source_object is not %NULL it will be filled out with the source
 * object specified when the corresponding socket or address was added
 * to the listener.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param sourceObject location where #GObject pointer will be stored, or %NULL
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)acceptWithSourceObject:(GObject**)sourceObject cancellable:(OGCancellable*)cancellable;

/**
 * This is the asynchronous version of g_socket_listener_accept().
 * 
 * When the operation is finished @callback will be
 * called. You can then call g_socket_listener_accept_finish()
 * to get the result of the operation.
 *
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback
 * @param userData user data for the callback
 */
- (void)acceptAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an async accept operation. See g_socket_listener_accept_async()
 *
 * @param result a #GAsyncResult.
 * @param sourceObject Optional #GObject identifying this source
 * @return a #GSocketConnection on success, %NULL on error.
 */
- (OGSocketConnection*)acceptFinishWithResult:(GAsyncResult*)result sourceObject:(GObject**)sourceObject;

/**
 * Blocks waiting for a client to connect to any of the sockets added
 * to the listener. Returns the #GSocket that was accepted.
 * 
 * If you want to accept the high-level #GSocketConnection, not a #GSocket,
 * which is often the case, then you should use g_socket_listener_accept()
 * instead.
 * 
 * If @source_object is not %NULL it will be filled out with the source
 * object specified when the corresponding socket or address was added
 * to the listener.
 * 
 * If @cancellable is not %NULL, then the operation can be cancelled by
 * triggering the cancellable object from another thread. If the operation
 * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
 *
 * @param sourceObject location where #GObject pointer will be stored, or %NULL.
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a #GSocket on success, %NULL on error.
 */
- (OGSocket*)acceptSocketWithSourceObject:(GObject**)sourceObject cancellable:(OGCancellable*)cancellable;

/**
 * This is the asynchronous version of g_socket_listener_accept_socket().
 * 
 * When the operation is finished @callback will be
 * called. You can then call g_socket_listener_accept_socket_finish()
 * to get the result of the operation.
 *
 * @param cancellable a #GCancellable, or %NULL
 * @param callback a #GAsyncReadyCallback
 * @param userData user data for the callback
 */
- (void)acceptSocketAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an async accept operation. See g_socket_listener_accept_socket_async()
 *
 * @param result a #GAsyncResult.
 * @param sourceObject Optional #GObject identifying this source
 * @return a #GSocket on success, %NULL on error.
 */
- (OGSocket*)acceptSocketFinishWithResult:(GAsyncResult*)result sourceObject:(GObject**)sourceObject;

/**
 * Creates a socket of type @type and protocol @protocol, binds
 * it to @address and adds it to the set of sockets we're accepting
 * sockets from.
 * 
 * Note that adding an IPv6 address, depending on the platform,
 * may or may not result in a listener that also accepts IPv4
 * connections.  For more deterministic behavior, see
 * g_socket_listener_add_inet_port().
 * 
 * @source_object will be passed out in the various calls
 * to accept to identify this particular source, which is
 * useful if you're listening on multiple addresses and do
 * different things depending on what address is connected to.
 * 
 * If successful and @effective_address is non-%NULL then it will
 * be set to the address that the binding actually occurred at.  This
 * is helpful for determining the port number that was used for when
 * requesting a binding to port 0 (ie: "any port").  This address, if
 * requested, belongs to the caller and must be freed.
 * 
 * Call g_socket_listener_close() to stop listening on @address; this will not
 * be done automatically when you drop your final reference to @listener, as
 * references may be held internally.
 *
 * @param address a #GSocketAddress
 * @param type a #GSocketType
 * @param protocol a #GSocketProtocol
 * @param sourceObject Optional #GObject identifying this source
 * @param effectiveAddress location to store the address that was bound to, or %NULL.
 * @return %TRUE on success, %FALSE on error.
 */
- (bool)addAddressWithAddress:(OGSocketAddress*)address type:(GSocketType)type protocol:(GSocketProtocol)protocol sourceObject:(GObject*)sourceObject effectiveAddress:(GSocketAddress**)effectiveAddress;

/**
 * Listens for TCP connections on any available port number for both
 * IPv6 and IPv4 (if each is available).
 * 
 * This is useful if you need to have a socket for incoming connections
 * but don't care about the specific port number.
 * 
 * @source_object will be passed out in the various calls
 * to accept to identify this particular source, which is
 * useful if you're listening on multiple addresses and do
 * different things depending on what address is connected to.
 *
 * @param sourceObject Optional #GObject identifying this source
 * @return the port number, or 0 in case of failure.
 */
- (guint16)addAnyInetPort:(GObject*)sourceObject;

/**
 * Helper function for g_socket_listener_add_address() that
 * creates a TCP/IP socket listening on IPv4 and IPv6 (if
 * supported) on the specified port on all interfaces.
 * 
 * @source_object will be passed out in the various calls
 * to accept to identify this particular source, which is
 * useful if you're listening on multiple addresses and do
 * different things depending on what address is connected to.
 * 
 * Call g_socket_listener_close() to stop listening on @port; this will not
 * be done automatically when you drop your final reference to @listener, as
 * references may be held internally.
 *
 * @param port an IP port number (non-zero)
 * @param sourceObject Optional #GObject identifying this source
 * @return %TRUE on success, %FALSE on error.
 */
- (bool)addInetPortWithPort:(guint16)port sourceObject:(GObject*)sourceObject;

/**
 * Adds @socket to the set of sockets that we try to accept
 * new clients from. The socket must be bound to a local
 * address and listened to.
 * 
 * @source_object will be passed out in the various calls
 * to accept to identify this particular source, which is
 * useful if you're listening on multiple addresses and do
 * different things depending on what address is connected to.
 * 
 * The @socket will not be automatically closed when the @listener is finalized
 * unless the listener held the final reference to the socket. Before GLib 2.42,
 * the @socket was automatically closed on finalization of the @listener, even
 * if references to it were held elsewhere.
 *
 * @param socket a listening #GSocket
 * @param sourceObject Optional #GObject identifying this source
 * @return %TRUE on success, %FALSE on error.
 */
- (bool)addSocketWithSocket:(OGSocket*)socket sourceObject:(GObject*)sourceObject;

/**
 * Closes all the sockets in the listener.
 *
 */
- (void)close;

/**
 * Sets the listen backlog on the sockets in the listener. This must be called
 * before adding any sockets, addresses or ports to the #GSocketListener (for
 * example, by calling g_socket_listener_add_inet_port()) to be effective.
 * 
 * See g_socket_set_listen_backlog() for details
 *
 * @param listenBacklog an integer
 */
- (void)setBacklog:(int)listenBacklog;

@end