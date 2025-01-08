/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketControlMessage.h"

@class OGCredentials;

/**
 * This [class@Gio.SocketControlMessage] contains a [class@Gio.Credentials]
 * instance.  It may be sent using [method@Gio.Socket.send_message] and received
 * using [method@Gio.Socket.receive_message] over UNIX sockets (ie: sockets in
 * the `G_SOCKET_FAMILY_UNIX` family).
 * 
 * For an easier way to send and receive credentials over
 * stream-oriented UNIX sockets, see
 * [method@Gio.UnixConnection.send_credentials] and
 * [method@Gio.UnixConnection.receive_credentials]. To receive credentials of
 * a foreign process connected to a socket, use
 * [method@Gio.Socket.get_credentials].
 * 
 * Since GLib 2.72, `GUnixCredentialMessage` is available on all platforms. It
 * requires underlying system support (such as Windows 10 with `AF_UNIX`) at run
 * time.
 * 
 * Before GLib 2.72, `<gio/gunixcredentialsmessage.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 *
 */
@interface OGUnixCredentialsMessage : OGSocketControlMessage
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Checks if passing #GCredentials on a #GSocket is supported on this platform.
 *
 * @return %TRUE if supported, %FALSE otherwise
 */
+ (bool)isSupported;

/**
 * Constructors
 */
- (instancetype)init;
- (instancetype)initWithCredentials:(OGCredentials*)credentials;

/**
 * Methods
 */

- (GUnixCredentialsMessage*)castedGObject;

/**
 * Gets the credentials stored in @message.
 *
 * @return A #GCredentials instance. Do not free, it is owned by @message.
 */
- (OGCredentials*)credentials;

@end