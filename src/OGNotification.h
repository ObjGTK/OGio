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
 * #GNotification is a mechanism for creating a notification to be shown
 * to the user -- typically as a pop-up notification presented by the
 * desktop environment shell.
 * 
 * The key difference between #GNotification and other similar APIs is
 * that, if supported by the desktop environment, notifications sent
 * with #GNotification will persist after the application has exited,
 * and even across system reboots.
 * 
 * Since the user may click on a notification while the application is
 * not running, applications using #GNotification should be able to be
 * started as a D-Bus service, using #GApplication.
 * 
 * In order for #GNotification to work, the application must have installed
 * a `.desktop` file. For example:
 * |[
 *  [Desktop Entry]
 *   Name=Test Application
 *   Comment=Description of what Test Application does
 *   Exec=gnome-test-application
 *   Icon=org.gnome.TestApplication
 *   Terminal=false
 *   Type=Application
 *   Categories=GNOME;GTK;TestApplication Category;
 *   StartupNotify=true
 *   DBusActivatable=true
 *   X-GNOME-UsesNotifications=true
 * ]|
 * 
 * The `X-GNOME-UsesNotifications` key indicates to GNOME Control Center
 * that this application uses notifications, so it can be listed in the
 * Control Center’s ‘Notifications’ panel.
 * 
 * The `.desktop` file must be named as `org.gnome.TestApplication.desktop`,
 * where `org.gnome.TestApplication` is the ID passed to g_application_new().
 * 
 * User interaction with a notification (either the default action, or
 * buttons) must be associated with actions on the application (ie:
 * "app." actions).  It is not possible to route user interaction
 * through the notification itself, because the object will not exist if
 * the application is autostarted as a result of a notification being
 * clicked.
 * 
 * A notification can be sent with g_application_send_notification().
 *
 */
@interface OGNotification : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init:(OFString*)title;

/**
 * Methods
 */

- (GNotification*)castedGObject;

/**
 * Adds a button to @notification that activates the action in
 * @detailed_action when clicked. That action must be an
 * application-wide action (starting with "app."). If @detailed_action
 * contains a target, the action will be activated with that target as
 * its parameter.
 * 
 * See g_action_parse_detailed_name() for a description of the format
 * for @detailed_action.
 *
 * @param label label of the button
 * @param detailedAction a detailed action name
 */
- (void)addButtonWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction;

/**
 * Adds a button to @notification that activates @action when clicked.
 * @action must be an application-wide action (it must start with "app.").
 * 
 * If @target is non-%NULL, @action will be activated with @target as
 * its parameter.
 *
 * @param label label of the button
 * @param action an action name
 * @param target a #GVariant to use as @action's parameter, or %NULL
 */
- (void)addButtonWithTargetValueWithLabel:(OFString*)label action:(OFString*)action target:(GVariant*)target;

/**
 * Sets the body of @notification to @body.
 *
 * @param body the new body for @notification, or %NULL
 */
- (void)setBody:(OFString*)body;

/**
 * Sets the type of @notification to @category. Categories have a main
 * type like `email`, `im` or `device` and can have a detail separated
 * by a `.`, e.g. `im.received` or `email.arrived`. Setting the category
 * helps the notification server to select proper feedback to the user.
 * 
 * Standard categories are [listed in the specification](https://specifications.freedesktop.org/notification-spec/latest/ar01s06.html).
 *
 * @param category the category for @notification, or %NULL for no category
 */
- (void)setCategory:(OFString*)category;

/**
 * Sets the default action of @notification to @detailed_action. This
 * action is activated when the notification is clicked on.
 * 
 * The action in @detailed_action must be an application-wide action (it
 * must start with "app."). If @detailed_action contains a target, the
 * given action will be activated with that target as its parameter.
 * See g_action_parse_detailed_name() for a description of the format
 * for @detailed_action.
 * 
 * When no default action is set, the application that the notification
 * was sent on is activated.
 *
 * @param detailedAction a detailed action name
 */
- (void)setDefaultAction:(OFString*)detailedAction;

/**
 * Sets the default action of @notification to @action. This action is
 * activated when the notification is clicked on. It must be an
 * application-wide action (start with "app.").
 * 
 * If @target is non-%NULL, @action will be activated with @target as
 * its parameter. If @target is floating, it will be consumed.
 * 
 * When no default action is set, the application that the notification
 * was sent on is activated.
 *
 * @param action an action name
 * @param target a #GVariant to use as @action's parameter, or %NULL
 */
- (void)setDefaultActionAndTargetValueWithAction:(OFString*)action target:(GVariant*)target;

/**
 * Sets the icon of @notification to @icon.
 *
 * @param icon the icon to be shown in @notification, as a #GIcon
 */
- (void)setIcon:(GIcon*)icon;

/**
 * Sets the priority of @notification to @priority. See
 * #GNotificationPriority for possible values.
 *
 * @param priority a #GNotificationPriority
 */
- (void)setPriority:(GNotificationPriority)priority;

/**
 * Sets the title of @notification to @title.
 *
 * @param title the new title for @notification
 */
- (void)setTitle:(OFString*)title;

/**
 * Deprecated in favor of g_notification_set_priority().
 *
 * @param urgent %TRUE if @notification is urgent
 */
- (void)setUrgent:(bool)urgent;

@end