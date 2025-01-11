/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTcpConnection.h"

@class OGIOStream;
@class OGSocket;
@class OGSocketConnection;

/**
 * A `GTcpWrapperConnection` can be used to wrap a [class@Gio.IOStream] that is
 * based on a [class@Gio.Socket], but which is not actually a
 * [class@Gio.SocketConnection]. This is used by [class@Gio.SocketClient] so
 * that it can always return a [class@Gio.SocketConnection], even when the
 * connection it has actually created is not directly a
 * [class@Gio.SocketConnection].
 *
 */
@interface OGTcpWrapperConnection : OGTcpConnection
{

}


/**
 * Constructors
 */
+ (instancetype)tcpWrapperConnectionWithBaseIoStream:(OGIOStream*)baseIoStream socket:(OGSocket*)socket;

/**
 * Methods
 */

- (GTcpWrapperConnection*)castedGObject;

/**
 * Gets @conn's base #GIOStream
 *
 * @return @conn's base #GIOStream
 */
- (OGIOStream*)baseIoStream;

@end