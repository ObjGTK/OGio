/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketControlMessage.h"

@class OGCredentials;

/**
 * This #GSocketControlMessage contains a #GCredentials instance.  It
 * may be sent using g_socket_send_message() and received using
 * g_socket_receive_message() over UNIX sockets (ie: sockets in the
 * %G_SOCKET_FAMILY_UNIX family).
 * 
 * For an easier way to send and receive credentials over
 * stream-oriented UNIX sockets, see
 * g_unix_connection_send_credentials() and
 * g_unix_connection_receive_credentials(). To receive credentials of
 * a foreign process connected to a socket, use
 * g_socket_get_credentials().
 * 
 * Since GLib 2.72, #GUnixCredentialMessage is available on all platforms. It
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