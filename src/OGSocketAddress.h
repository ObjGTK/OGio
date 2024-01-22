/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixfdmessage.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

/**
 * #GSocketAddress is the equivalent of struct sockaddr in the BSD
 * sockets API. This is an abstract class; use #GInetSocketAddress
 * for internet sockets, or #GUnixSocketAddress for UNIX domain sockets.
 *
 */
@interface OGSocketAddress : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initFromNativeWithNative:(gpointer)native len:(gsize)len;

/**
 * Methods
 */

- (GSocketAddress*)castedGObject;

/**
 * Gets the socket family type of @address.
 *
 * @return the socket family type of @address
 */
- (GSocketFamily)family;

/**
 * Gets the size of @address's native struct sockaddr.
 * You can use this to allocate memory to pass to
 * g_socket_address_to_native().
 *
 * @return the size of the native struct sockaddr that
 *     @address represents
 */
- (gssize)nativeSize;

/**
 * Converts a #GSocketAddress to a native struct sockaddr, which can
 * be passed to low-level functions like connect() or bind().
 * 
 * If not enough space is available, a %G_IO_ERROR_NO_SPACE error
 * is returned. If the address type is not known on the system
 * then a %G_IO_ERROR_NOT_SUPPORTED error is returned.
 *
 * @param dest a pointer to a memory location that will contain the native
 * struct sockaddr
 * @param destlen the size of @dest. Must be at least as large as
 *     g_socket_address_get_native_size()
 * @return %TRUE if @dest was filled in, %FALSE on error
 */
- (bool)toNativeWithDest:(gpointer)dest destlen:(gsize)destlen;

@end