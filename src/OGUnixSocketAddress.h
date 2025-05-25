/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddress.h"

/**
 * Support for UNIX-domain (also known as local) sockets, corresponding to
 * `struct sockaddr_un`.
 * 
 * UNIX domain sockets are generally visible in the filesystem.
 * However, some systems support abstract socket names which are not
 * visible in the filesystem and not affected by the filesystem
 * permissions, visibility, etc. Currently this is only supported
 * under Linux. If you attempt to use abstract sockets on other
 * systems, function calls may return `G_IO_ERROR_NOT_SUPPORTED`
 * errors. You can use [func@Gio.UnixSocketAddress.abstract_names_supported]
 * to see if abstract names are supported.
 * 
 * Since GLib 2.72, `GUnixSocketAddress` is available on all platforms. It
 * requires underlying system support (such as Windows 10 with `AF_UNIX`) at
 * run time.
 * 
 * Before GLib 2.72, `<gio/gunixsocketaddress.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 *
 */
@interface OGUnixSocketAddress : OGSocketAddress
{

}

/**
 * Functions and class methods
 */
+ (void)load;

+ (GTypeClass*)gObjectClass;

/**
 * Checks if abstract UNIX domain socket names are supported.
 *
 * @return %TRUE if supported, %FALSE otherwise
 */
+ (bool)abstractNamesSupported;

/**
 * Constructors
 */
+ (instancetype)unixSocketAddressWithPath:(OFString*)path;
+ (instancetype)unixSocketAddressAbstractWithPath:(OFString*)path pathLen:(gint)pathLen;
+ (instancetype)unixSocketAddressWithTypeWithPath:(OFString*)path pathLen:(gint)pathLen type:(GUnixSocketAddressType)type;

/**
 * Methods
 */

- (GUnixSocketAddress*)castedGObject;

/**
 * Gets @address's type.
 *
 * @return a #GUnixSocketAddressType
 */
- (GUnixSocketAddressType)addressType;

/**
 * Tests if @address is abstract.
 *
 * @return %TRUE if the address is abstract, %FALSE otherwise
 */
- (bool)isAbstract;

/**
 * Gets @address's path, or for abstract sockets the "name".
 * 
 * Guaranteed to be zero-terminated, but an abstract socket
 * may contain embedded zeros, and thus you should use
 * g_unix_socket_address_get_path_len() to get the true length
 * of this string.
 *
 * @return the path for @address
 */
- (OFString*)path;

/**
 * Gets the length of @address's path.
 * 
 * For details, see g_unix_socket_address_get_path().
 *
 * @return the length of the path
 */
- (gsize)pathLen;

@end