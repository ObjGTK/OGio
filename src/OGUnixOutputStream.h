/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGOutputStream.h"

/**
 * `GUnixOutputStream` implements [class@Gio.OutputStream] for writing to a UNIX
 * file descriptor, including asynchronous operations. (If the file
 * descriptor refers to a socket or pipe, this will use `poll()` to do
 * asynchronous I/O. If it refers to a regular file, it will fall back
 * to doing asynchronous I/O in another thread.)
 * 
 * Note that `<gio/gunixoutputstream.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config file
 * file or the `GioUnix-2.0` GIR namespace when using it.
 *
 */
@interface OGUnixOutputStream : OGOutputStream
{

}


/**
 * Constructors
 */
- (instancetype)initWithFd:(gint)fd closeFd:(bool)closeFd;

/**
 * Methods
 */

- (GUnixOutputStream*)castedGObject;

/**
 * Returns whether the file descriptor of @stream will be
 * closed when the stream is closed.
 *
 * @return %TRUE if the file descriptor is closed when done
 */
- (bool)closeFd;

/**
 * Return the UNIX file descriptor that the stream writes to.
 *
 * @return The file descriptor of @stream
 */
- (gint)fd;

/**
 * Sets whether the file descriptor of @stream shall be closed
 * when the stream is closed.
 *
 * @param closeFd %TRUE to close the file descriptor when done
 */
- (void)setCloseFd:(bool)closeFd;

@end