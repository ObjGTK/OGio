/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

/**
 * The `GCredentials` type is a reference-counted wrapper for native
 * credentials.
 * 
 * The information in `GCredentials` is typically used for identifying,
 * authenticating and authorizing other processes.
 * 
 * Some operating systems supports looking up the credentials of the remote
 * peer of a communication endpoint - see e.g. [method@Gio.Socket.get_credentials].
 * 
 * Some operating systems supports securely sending and receiving
 * credentials over a Unix Domain Socket, see [class@Gio.UnixCredentialsMessage],
 * [method@Gio.UnixConnection.send_credentials] and
 * [method@Gio.UnixConnection.receive_credentials] for details.
 * 
 * On Linux, the native credential type is a `struct ucred` - see the
 * [`unix(7)` man page](man:unix(7)) for details. This corresponds to
 * `G_CREDENTIALS_TYPE_LINUX_UCRED`.
 * 
 * On Apple operating systems (including iOS, tvOS, and macOS), the native credential
 * type is a `struct xucred`. This corresponds to `G_CREDENTIALS_TYPE_APPLE_XUCRED`.
 * 
 * On FreeBSD, Debian GNU/kFreeBSD, and GNU/Hurd, the native credential type is a
 * `struct cmsgcred`. This corresponds to `G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED`.
 * 
 * On NetBSD, the native credential type is a `struct unpcbid`.
 * This corresponds to `G_CREDENTIALS_TYPE_NETBSD_UNPCBID`.
 * 
 * On OpenBSD, the native credential type is a `struct sockpeercred`.
 * This corresponds to `G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED`.
 * 
 * On Solaris (including OpenSolaris and its derivatives), the native credential type
 * is a `ucred_t`. This corresponds to `G_CREDENTIALS_TYPE_SOLARIS_UCRED`.
 * 
 * Since GLib 2.72, on Windows, the native credentials may contain the PID of a
 * process. This corresponds to `G_CREDENTIALS_TYPE_WIN32_PID`.
 *
 */
@interface OGCredentials : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)credentials;

/**
 * Methods
 */

- (GCredentials*)castedGObject;

/**
 * Gets a pointer to native credentials of type @native_type from
 * @credentials.
 * 
 * It is a programming error (which will cause a warning to be
 * logged) to use this method if there is no #GCredentials support for
 * the OS or if @native_type isn't supported by the OS.
 *
 * @param nativeType The type of native credentials to get.
 * @return The pointer to native credentials or
 *     %NULL if there is no #GCredentials support for the OS or if @native_type
 *     isn't supported by the OS. Do not free the returned data, it is owned
 *     by @credentials.
 */
- (gpointer)native:(GCredentialsType)nativeType;

/**
 * Tries to get the UNIX process identifier from @credentials. This
 * method is only available on UNIX platforms.
 * 
 * This operation can fail if #GCredentials is not supported on the
 * OS or if the native credentials type does not contain information
 * about the UNIX process ID.
 *
 * @return The UNIX process ID, or `-1` if @error is set.
 */
- (pid_t)unixPid;

/**
 * Tries to get the UNIX user identifier from @credentials. This
 * method is only available on UNIX platforms.
 * 
 * This operation can fail if #GCredentials is not supported on the
 * OS or if the native credentials type does not contain information
 * about the UNIX user.
 *
 * @return The UNIX user identifier or `-1` if @error is set.
 */
- (uid_t)unixUser;

/**
 * Checks if @credentials and @other_credentials is the same user.
 * 
 * This operation can fail if #GCredentials is not supported on the
 * the OS.
 *
 * @param otherCredentials A #GCredentials.
 * @return %TRUE if @credentials and @other_credentials has the same
 * user, %FALSE otherwise or if @error is set.
 */
- (bool)isSameUser:(OGCredentials*)otherCredentials;

/**
 * Copies the native credentials of type @native_type from @native
 * into @credentials.
 * 
 * It is a programming error (which will cause a warning to be
 * logged) to use this method if there is no #GCredentials support for
 * the OS or if @native_type isn't supported by the OS.
 *
 * @param nativeType The type of native credentials to set.
 * @param native A pointer to native credentials.
 */
- (void)setNativeWithNativeType:(GCredentialsType)nativeType native:(gpointer)native;

/**
 * Tries to set the UNIX user identifier on @credentials. This method
 * is only available on UNIX platforms.
 * 
 * This operation can fail if #GCredentials is not supported on the
 * OS or if the native credentials type does not contain information
 * about the UNIX user. It can also fail if the OS does not allow the
 * use of "spoofed" credentials.
 *
 * @param uid The UNIX user identifier to set.
 * @return %TRUE if @uid was set, %FALSE if error is set.
 */
- (bool)setUnixUser:(uid_t)uid;

/**
 * Creates a human-readable textual representation of @credentials
 * that can be used in logging and debug messages. The format of the
 * returned string may change in future GLib release.
 *
 * @return A string that should be freed with g_free().
 */
- (OFString*)toString;

@end