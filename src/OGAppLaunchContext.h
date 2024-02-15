/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * Integrating the launch with the launching application. This is used to
 * handle for instance startup notification and launching the new application
 * on the same screen as the launching window.
 *
 */
@interface OGAppLaunchContext : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init;

/**
 * Methods
 */

- (GAppLaunchContext*)castedGObject;

/**
 * Gets the display string for the @context. This is used to ensure new
 * applications are started on the same display as the launching
 * application, by setting the `DISPLAY` environment variable.
 *
 * @param info a #GAppInfo
 * @param files a #GList of #GFile objects
 * @return a display string for the display.
 */
- (char*)displayWithInfo:(GAppInfo*)info files:(GList*)files;

/**
 * Gets the complete environment variable list to be passed to
 * the child process when @context is used to launch an application.
 * This is a %NULL-terminated array of strings, where each string has
 * the form `KEY=VALUE`.
 *
 * @return the child's environment
 */
- (char**)environment;

/**
 * Initiates startup notification for the application and returns the
 * `XDG_ACTIVATION_TOKEN` or `DESKTOP_STARTUP_ID` for the launched operation,
 * if supported.
 * 
 * The returned token may be referred to equivalently as an ‘activation token’
 * (using Wayland terminology) or a ‘startup sequence ID’ (using X11 terminology).
 * The two [are interoperable](https://gitlab.freedesktop.org/wayland/wayland-protocols/-/blob/main/staging/xdg-activation/x11-interoperation.rst).
 * 
 * Activation tokens are defined in the [XDG Activation Protocol](https://wayland.app/protocols/xdg-activation-v1),
 * and startup notification IDs are defined in the
 * [freedesktop.org Startup Notification Protocol](http://standards.freedesktop.org/startup-notification-spec/startup-notification-latest.txt).
 * 
 * Support for the XDG Activation Protocol was added in GLib 2.76.
 *
 * @param info a #GAppInfo
 * @param files a #GList of #GFile objects
 * @return a startup notification ID for the application, or %NULL if
 *     not supported.
 */
- (char*)startupNotifyIdWithInfo:(GAppInfo*)info files:(GList*)files;

/**
 * Called when an application has failed to launch, so that it can cancel
 * the application startup notification started in g_app_launch_context_get_startup_notify_id().
 *
 * @param startupNotifyId the startup notification id that was returned by g_app_launch_context_get_startup_notify_id().
 */
- (void)launchFailed:(OFString*)startupNotifyId;

/**
 * Arranges for @variable to be set to @value in the child's
 * environment when @context is used to launch an application.
 *
 * @param variable the environment variable to set
 * @param value the value for to set the variable to.
 */
- (void)setenvWithVariable:(OFString*)variable value:(OFString*)value;

/**
 * Arranges for @variable to be unset in the child's environment
 * when @context is used to launch an application.
 *
 * @param variable the environment variable to remove
 */
- (void)unsetenv:(OFString*)variable;

@end