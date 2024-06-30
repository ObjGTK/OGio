/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTcpConnection.h"

@class OGSocket;
@class OGIOStream;
@class OGSocketConnection;

/**
 * A #GTcpWrapperConnection can be used to wrap a #GIOStream that is
 * based on a #GSocket, but which is not actually a
 * #GSocketConnection. This is used by #GSocketClient so that it can
 * always return a #GSocketConnection, even when the connection it has
 * actually created is not directly a #GSocketConnection.
 *
 */
@interface OGTcpWrapperConnection : OGTcpConnection
{

}


/**
 * Constructors
 */
- (instancetype)initWithBaseIoStream:(OGIOStream*)baseIoStream socket:(OGSocket*)socket;

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