/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * Watches #GUnixMounts for changes.
 *
 */
@interface OGUnixMountMonitor : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Gets the #GUnixMountMonitor for the current thread-default main
 * context.
 * 
 * The mount monitor can be used to monitor for changes to the list of
 * mounted filesystems as well as the list of mount points (ie: fstab
 * entries).
 * 
 * You must only call g_object_unref() on the return value from under
 * the same main context as you called this function.
 *
 * @return the #GUnixMountMonitor.
 */
+ (OGUnixMountMonitor*)get;

/**
 * Constructors
 */
+ (instancetype)unixMountMonitor;

/**
 * Methods
 */

- (GUnixMountMonitor*)castedGObject;

/**
 * This function does nothing.
 * 
 * Before 2.44, this was a partially-effective way of controlling the
 * rate at which events would be reported under some uncommon
 * circumstances.  Since @mount_monitor is a singleton, it also meant
 * that calling this function would have side effects for other users of
 * the monitor.
 *
 * @param limitMsec a integer with the limit in milliseconds to
 *     poll for changes.
 */
- (void)setRateLimitWithLimitMsec:(int)limitMsec;

@end