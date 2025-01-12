/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixfdmessage.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gio.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * Monitors a file or directory for changes.
 * 
 * To obtain a `GFileMonitor` for a file or directory, use
 * [method@Gio.File.monitor], [method@Gio.File.monitor_file], or
 * [method@Gio.File.monitor_directory].
 * 
 * To get informed about changes to the file or directory you are
 * monitoring, connect to the [signal@Gio.FileMonitor::changed] signal. The
 * signal will be emitted in the thread-default main context (see
 * [method@GLib.MainContext.push_thread_default]) of the thread that the monitor
 * was created in (though if the global default main context is blocked, this
 * may cause notifications to be blocked even if the thread-default
 * context is still running).
 *
 */
@interface OGFileMonitor : OGObject
{

}


/**
 * Methods
 */

- (GFileMonitor*)castedGObject;

/**
 * Cancels a file monitor.
 *
 * @return always %TRUE
 */
- (bool)cancel;

/**
 * Emits the #GFileMonitor::changed signal if a change
 * has taken place. Should be called from file monitor
 * implementations only.
 * 
 * Implementations are responsible to call this method from the
 * [thread-default main context][g-main-context-push-thread-default] of the
 * thread that the monitor was created in.
 *
 * @param child a #GFile.
 * @param otherFile a #GFile.
 * @param eventType a set of #GFileMonitorEvent flags.
 */
- (void)emitEventWithChild:(GFile*)child otherFile:(GFile*)otherFile eventType:(GFileMonitorEvent)eventType;

/**
 * Returns whether the monitor is canceled.
 *
 * @return %TRUE if monitor is canceled. %FALSE otherwise.
 */
- (bool)isCancelled;

/**
 * Sets the rate limit to which the @monitor will report
 * consecutive change events to the same file.
 *
 * @param limitMsecs a non-negative integer with the limit in milliseconds
 *     to poll for changes
 */
- (void)setRateLimit:(gint)limitMsecs;

@end