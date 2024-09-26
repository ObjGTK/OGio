/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketConnection.h"

@class OGCancellable;
@class OGCredentials;

/**
 * This is the subclass of [class@Gio.SocketConnection] that is created
 * for UNIX domain sockets.
 * 
 * It contains functions to do some of the UNIX socket specific
 * functionality like passing file descriptors.
 * 
 * Since GLib 2.72, `GUnixConnection` is available on all platforms. It requires
 * underlying system support (such as Windows 10 with `AF_UNIX`) at run time.
 * 
 * Before GLib 2.72, `<gio/gunixconnection.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it. This is no longer necessary since GLib 2.72.
 *
 */
@interface OGUnixConnection : OGSocketConnection
{

}


/**
 * Methods
 */

- (GUnixConnection*)castedGObject;

/**
 * Receives credentials from the sending end of the connection.  The
 * sending end has to call g_unix_connection_send_credentials() (or
 * similar) for this to work.
 * 
 * As well as reading the credentials this also reads (and discards) a
 * single byte from the stream, as this is required for credentials
 * passing to work on some implementations.
 * 
 * This method can be expected to be available on the following platforms:
 * 
 * - Linux since GLib 2.26
 * - FreeBSD since GLib 2.26
 * - GNU/kFreeBSD since GLib 2.36
 * - Solaris, Illumos and OpenSolaris since GLib 2.40
 * - GNU/Hurd since GLib 2.40
 * 
 * Other ways to exchange credentials with a foreign peer includes the
 * #GUnixCredentialsMessage type and g_socket_get_credentials() function.
 *
 * @param cancellable A #GCancellable or %NULL.
 * @return Received credentials on success (free with
 * g_object_unref()), %NULL if @error is set.
 */
- (OGCredentials*)receiveCredentials:(OGCancellable*)cancellable;

/**
 * Asynchronously receive credentials.
 * 
 * For more details, see g_unix_connection_receive_credentials() which is
 * the synchronous version of this call.
 * 
 * When the operation is finished, @callback will be called. You can then call
 * g_unix_connection_receive_credentials_finish() to get the result of the operation.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)receiveCredentialsAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous receive credentials operation started with
 * g_unix_connection_receive_credentials_async().
 *
 * @param result a #GAsyncResult.
 * @return a #GCredentials, or %NULL on error.
 *     Free the returned object with g_object_unref().
 */
- (OGCredentials*)receiveCredentialsFinish:(GAsyncResult*)result;

/**
 * Receives a file descriptor from the sending end of the connection.
 * The sending end has to call g_unix_connection_send_fd() for this
 * to work.
 * 
 * As well as reading the fd this also reads a single byte from the
 * stream, as this is required for fd passing to work on some
 * implementations.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore
 * @return a file descriptor on success, -1 on error.
 */
- (gint)receiveFd:(OGCancellable*)cancellable;

/**
 * Passes the credentials of the current user the receiving side
 * of the connection. The receiving end has to call
 * g_unix_connection_receive_credentials() (or similar) to accept the
 * credentials.
 * 
 * As well as sending the credentials this also writes a single NUL
 * byte to the stream, as this is required for credentials passing to
 * work on some implementations.
 * 
 * This method can be expected to be available on the following platforms:
 * 
 * - Linux since GLib 2.26
 * - FreeBSD since GLib 2.26
 * - GNU/kFreeBSD since GLib 2.36
 * - Solaris, Illumos and OpenSolaris since GLib 2.40
 * - GNU/Hurd since GLib 2.40
 * 
 * Other ways to exchange credentials with a foreign peer includes the
 * #GUnixCredentialsMessage type and g_socket_get_credentials() function.
 *
 * @param cancellable A #GCancellable or %NULL.
 * @return %TRUE on success, %FALSE if @error is set.
 */
- (bool)sendCredentials:(OGCancellable*)cancellable;

/**
 * Asynchronously send credentials.
 * 
 * For more details, see g_unix_connection_send_credentials() which is
 * the synchronous version of this call.
 * 
 * When the operation is finished, @callback will be called. You can then call
 * g_unix_connection_send_credentials_finish() to get the result of the operation.
 *
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @param callback a #GAsyncReadyCallback
 *   to call when the request is satisfied
 * @param userData the data to pass to callback function
 */
- (void)sendCredentialsAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Finishes an asynchronous send credentials operation started with
 * g_unix_connection_send_credentials_async().
 *
 * @param result a #GAsyncResult.
 * @return %TRUE if the operation was successful, otherwise %FALSE.
 */
- (bool)sendCredentialsFinish:(GAsyncResult*)result;

/**
 * Passes a file descriptor to the receiving side of the
 * connection. The receiving end has to call g_unix_connection_receive_fd()
 * to accept the file descriptor.
 * 
 * As well as sending the fd this also writes a single byte to the
 * stream, as this is required for fd passing to work on some
 * implementations.
 *
 * @param fd a file descriptor
 * @param cancellable optional #GCancellable object, %NULL to ignore.
 * @return a %TRUE on success, %NULL on error.
 */
- (bool)sendFdWithFd:(gint)fd cancellable:(OGCancellable*)cancellable;

@end