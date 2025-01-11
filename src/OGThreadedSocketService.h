/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketService.h"

/**
 * A `GThreadedSocketService` is a simple subclass of [class@Gio.SocketService]
 * that handles incoming connections by creating a worker thread and
 * dispatching the connection to it by emitting the
 * [signal@Gio.ThreadedSocketService::run signal] in the new thread.
 * 
 * The signal handler may perform blocking I/O and need not return
 * until the connection is closed.
 * 
 * The service is implemented using a thread pool, so there is a
 * limited amount of threads available to serve incoming requests.
 * The service automatically stops the [class@Gio.SocketService] from accepting
 * new connections when all threads are busy.
 * 
 * As with [class@Gio.SocketService], you may connect to
 * [signal@Gio.ThreadedSocketService::run], or subclass and override the default
 * handler.
 *
 */
@interface OGThreadedSocketService : OGSocketService
{

}


/**
 * Constructors
 */
+ (instancetype)threadedSocketService:(int)maxThreads;

/**
 * Methods
 */

- (GThreadedSocketService*)castedGObject;

@end