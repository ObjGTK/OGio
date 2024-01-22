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

@class OGIOStream;
@class OGCredentials;

/**
 * The #GDBusAuthObserver type provides a mechanism for participating
 * in how a #GDBusServer (or a #GDBusConnection) authenticates remote
 * peers. Simply instantiate a #GDBusAuthObserver and connect to the
 * signals you are interested in. Note that new signals may be added
 * in the future
 * 
 * ## Controlling Authentication Mechanisms
 * 
 * By default, a #GDBusServer or server-side #GDBusConnection will allow
 * any authentication mechanism to be used. If you only
 * want to allow D-Bus connections with the `EXTERNAL` mechanism,
 * which makes use of credentials passing and is the recommended
 * mechanism for modern Unix platforms such as Linux and the BSD family,
 * you would use a signal handler like this:
 * 
 * |[<!-- language="C" -->
 * static gboolean
 * on_allow_mechanism (GDBusAuthObserver *observer,
 *                     const gchar       *mechanism,
 *                     gpointer           user_data)
 * {
 *   if (g_strcmp0 (mechanism, "EXTERNAL") == 0)
 *     {
 *       return TRUE;
 *     }
 * 
 *   return FALSE;
 * }
 * ]|
 * 
 * ## Controlling Authorization # {#auth-observer}
 * 
 * By default, a #GDBusServer or server-side #GDBusConnection will accept
 * connections from any successfully authenticated user (but not from
 * anonymous connections using the `ANONYMOUS` mechanism). If you only
 * want to allow D-Bus connections from processes owned by the same uid
 * as the server, since GLib 2.68, you should use the
 * %G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER flag. It’s equivalent
 * to the following signal handler:
 * 
 * |[<!-- language="C" -->
 * static gboolean
 * on_authorize_authenticated_peer (GDBusAuthObserver *observer,
 *                                  GIOStream         *stream,
 *                                  GCredentials      *credentials,
 *                                  gpointer           user_data)
 * {
 *   gboolean authorized;
 * 
 *   authorized = FALSE;
 *   if (credentials != NULL)
 *     {
 *       GCredentials *own_credentials;
 *       own_credentials = g_credentials_new ();
 *       if (g_credentials_is_same_user (credentials, own_credentials, NULL))
 *         authorized = TRUE;
 *       g_object_unref (own_credentials);
 *     }
 * 
 *   return authorized;
 * }
 * ]|
 *
 */
@interface OGDBusAuthObserver : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init;

/**
 * Methods
 */

- (GDBusAuthObserver*)castedGObject;

/**
 * Emits the #GDBusAuthObserver::allow-mechanism signal on @observer.
 *
 * @param mechanism The name of the mechanism, e.g. `DBUS_COOKIE_SHA1`.
 * @return %TRUE if @mechanism can be used to authenticate the other peer, %FALSE if not.
 */
- (bool)allowMechanism:(OFString*)mechanism;

/**
 * Emits the #GDBusAuthObserver::authorize-authenticated-peer signal on @observer.
 *
 * @param stream A #GIOStream for the #GDBusConnection.
 * @param credentials Credentials received from the peer or %NULL.
 * @return %TRUE if the peer is authorized, %FALSE if not.
 */
- (bool)authorizeAuthenticatedPeerWithStream:(OGIOStream*)stream credentials:(OGCredentials*)credentials;

@end