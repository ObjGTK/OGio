/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketControlMessage.h"

@class OGUnixFDList;

/**
 * This [class@Gio.SocketControlMessage] contains a [class@Gio.UnixFDList].
 * It may be sent using [method@Gio.Socket.send_message] and received using
 * [method@Gio.Socket.receive_message] over UNIX sockets (ie: sockets in the
 * `G_SOCKET_FAMILY_UNIX` family). The file descriptors are copied
 * between processes by the kernel.
 * 
 * For an easier way to send and receive file descriptors over
 * stream-oriented UNIX sockets, see [method@Gio.UnixConnection.send_fd] and
 * [method@Gio.UnixConnection.receive_fd].
 * 
 * Note that `<gio/gunixfdmessage.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 *
 */
@interface OGUnixFDMessage : OGSocketControlMessage
{

}


/**
 * Constructors
 */
- (instancetype)init;
- (instancetype)initWithFdList:(OGUnixFDList*)fdList;

/**
 * Methods
 */

- (GUnixFDMessage*)castedGObject;

/**
 * Adds a file descriptor to @message.
 * 
 * The file descriptor is duplicated using dup(). You keep your copy
 * of the descriptor and the copy contained in @message will be closed
 * when @message is finalized.
 * 
 * A possible cause of failure is exceeding the per-process or
 * system-wide file descriptor limit.
 *
 * @param fd a valid open file descriptor
 * @return %TRUE in case of success, else %FALSE (and @error is set)
 */
- (bool)appendFd:(gint)fd;

/**
 * Gets the #GUnixFDList contained in @message.  This function does not
 * return a reference to the caller, but the returned list is valid for
 * the lifetime of @message.
 *
 * @return the #GUnixFDList from @message
 */
- (OGUnixFDList*)fdList;

/**
 * Returns the array of file descriptors that is contained in this
 * object.
 * 
 * After this call, the descriptors are no longer contained in
 * @message. Further calls will return an empty list (unless more
 * descriptors have been added).
 * 
 * The return result of this function must be freed with g_free().
 * The caller is also responsible for closing all of the file
 * descriptors.
 * 
 * If @length is non-%NULL then it is set to the number of file
 * descriptors in the returned array. The returned array is also
 * terminated with -1.
 * 
 * This function never returns %NULL. In case there are no file
 * descriptors contained in @message, an empty array is returned.
 *
 * @param length pointer to the length of the returned
 *     array, or %NULL
 * @return an array of file
 *     descriptors
 */
- (gint*)stealFds:(gint*)length;

@end