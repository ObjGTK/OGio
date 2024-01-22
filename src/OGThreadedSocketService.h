/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketService.h"

/**
 * A #GThreadedSocketService is a simple subclass of #GSocketService
 * that handles incoming connections by creating a worker thread and
 * dispatching the connection to it by emitting the
 * #GThreadedSocketService::run signal in the new thread.
 * 
 * The signal handler may perform blocking IO and need not return
 * until the connection is closed.
 * 
 * The service is implemented using a thread pool, so there is a
 * limited amount of threads available to serve incoming requests.
 * The service automatically stops the #GSocketService from accepting
 * new connections when all threads are busy.
 * 
 * As with #GSocketService, you may connect to #GThreadedSocketService::run,
 * or subclass and override the default handler.
 *
 */
@interface OGThreadedSocketService : OGSocketService
{

}


/**
 * Constructors
 */
- (instancetype)init:(int)maxThreads;

/**
 * Methods
 */

- (GThreadedSocketService*)castedGObject;

@end