/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixoutputstream.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

/**
 * #GAppInfoMonitor is a very simple object used for monitoring the app
 * info database for changes (ie: newly installed or removed
 * applications).
 * 
 * Call g_app_info_monitor_get() to get a #GAppInfoMonitor and connect
 * to the "changed" signal.
 * 
 * In the usual case, applications should try to make note of the change
 * (doing things like invalidating caches) but not act on it.  In
 * particular, applications should avoid making calls to #GAppInfo APIs
 * in response to the change signal, deferring these until the time that
 * the data is actually required.  The exception to this case is when
 * application information is actually being displayed on the screen
 * (eg: during a search or when the list of all applications is shown).
 * The reason for this is that changes to the list of installed
 * applications often come in groups (like during system updates) and
 * rescanning the list on every change is pointless and expensive.
 *
 */
@interface OGAppInfoMonitor : OGObject
{

}

/**
 * Functions
 */

/**
 * Gets the #GAppInfoMonitor for the current thread-default main
 * context.
 * 
 * The #GAppInfoMonitor will emit a "changed" signal in the
 * thread-default main context whenever the list of installed
 * applications (as reported by g_app_info_get_all()) may have changed.
 * 
 * You must only call g_object_unref() on the return value from under
 * the same main context as you created it.
 *
 * @return a reference to a #GAppInfoMonitor
 */
+ (OGAppInfoMonitor*)get;

/**
 * Methods
 */

- (GAppInfoMonitor*)castedGObject;

@end