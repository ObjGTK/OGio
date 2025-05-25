/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketConnection.h"

/**
 * This is the subclass of [class@Gio.SocketConnection] that is created
 * for TCP/IP sockets.
 *
 */
@interface OGTcpConnection : OGSocketConnection
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Methods
 */

- (GTcpConnection*)castedGObject;

/**
 * Checks if graceful disconnects are used. See
 * g_tcp_connection_set_graceful_disconnect().
 *
 * @return %TRUE if graceful disconnect is used on close, %FALSE otherwise
 */
- (bool)gracefulDisconnect;

/**
 * This enables graceful disconnects on close. A graceful disconnect
 * means that we signal the receiving end that the connection is terminated
 * and wait for it to close the connection before closing the connection.
 * 
 * A graceful disconnect means that we can be sure that we successfully sent
 * all the outstanding data to the other end, or get an error reported.
 * However, it also means we have to wait for all the data to reach the
 * other side and for it to acknowledge this by closing the socket, which may
 * take a while. For this reason it is disabled by default.
 *
 * @param gracefulDisconnect Whether to do graceful disconnects or not
 */
- (void)setGracefulDisconnect:(bool)gracefulDisconnect;

@end