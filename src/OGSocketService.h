/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketListener.h"

/**
 * A `GSocketService` is an object that represents a service that
 * is provided to the network or over local sockets.  When a new
 * connection is made to the service the [signal@Gio.SocketService::incoming]
 * signal is emitted.
 * 
 * A `GSocketService` is a subclass of [class@Gio.SocketListener] and you need
 * to add the addresses you want to accept connections on with the
 * [class@Gio.SocketListener] APIs.
 * 
 * There are two options for implementing a network service based on
 * `GSocketService`. The first is to create the service using
 * [ctor@Gio.SocketService.new] and to connect to the
 * [signal@Gio.SocketService::incoming] signal. The second is to subclass
 * `GSocketService` and override the default signal handler implementation.
 * 
 * In either case, the handler must immediately return, or else it
 * will block additional incoming connections from being serviced.
 * If you are interested in writing connection handlers that contain
 * blocking code then see [class@Gio.ThreadedSocketService].
 * 
 * The socket service runs on the main loop of the
 * thread-default context (see
 * [method@GLib.MainContext.push_thread_default]) of the thread it is
 * created in, and is not threadsafe in general. However, the calls to start and
 * stop the service are thread-safe so these can be used from threads that
 * handle incoming clients.
 *
 */
@interface OGSocketService : OGSocketListener
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
+ (instancetype)socketService;

/**
 * Methods
 */

- (GSocketService*)castedGObject;

/**
 * Check whether the service is active or not. An active
 * service will accept new clients that connect, while
 * a non-active service will let connecting clients queue
 * up until the service is started.
 *
 * @return %TRUE if the service is active, %FALSE otherwise
 */
- (bool)isActive;

/**
 * Restarts the service, i.e. start accepting connections
 * from the added sockets when the mainloop runs. This only needs
 * to be called after the service has been stopped from
 * g_socket_service_stop().
 * 
 * This call is thread-safe, so it may be called from a thread
 * handling an incoming client request.
 *
 */
- (void)start;

/**
 * Stops the service, i.e. stops accepting connections
 * from the added sockets when the mainloop runs.
 * 
 * This call is thread-safe, so it may be called from a thread
 * handling an incoming client request.
 * 
 * Note that this only stops accepting new connections; it does not
 * close the listening sockets, and you can call
 * g_socket_service_start() again later to begin listening again. To
 * close the listening sockets, call g_socket_listener_close(). (This
 * will happen automatically when the #GSocketService is finalized.)
 * 
 * This must be called before calling g_socket_listener_close() as
 * the socket service will start accepting connections immediately
 * when a new socket is added.
 *
 */
- (void)stop;

@end