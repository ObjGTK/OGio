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
 * `GVolumeMonitor` is for listing the user interesting devices and volumes
 * on the computer. In other words, what a file selector or file manager
 * would show in a sidebar.
 * 
 * `GVolumeMonitor` is not
 * thread-default-context aware (see
 * [method@GLib.MainContext.push_thread_default]), and so should not be used
 * other than from the main thread, with no thread-default-context active.
 * 
 * In order to receive updates about volumes and mounts monitored through GVFS,
 * a main loop must be running.
 *
 */
@interface OGVolumeMonitor : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * This function should be called by any #GVolumeMonitor
 * implementation when a new #GMount object is created that is not
 * associated with a #GVolume object. It must be called just before
 * emitting the @mount_added signal.
 * 
 * If the return value is not %NULL, the caller must associate the
 * returned #GVolume object with the #GMount. This involves returning
 * it in its g_mount_get_volume() implementation. The caller must
 * also listen for the "removed" signal on the returned object
 * and give up its reference when handling that signal
 * 
 * Similarly, if implementing g_volume_monitor_adopt_orphan_mount(),
 * the implementor must take a reference to @mount and return it in
 * its g_volume_get_mount() implemented. Also, the implementor must
 * listen for the "unmounted" signal on @mount and give up its
 * reference upon handling that signal.
 * 
 * There are two main use cases for this function.
 * 
 * One is when implementing a user space file system driver that reads
 * blocks of a block device that is already represented by the native
 * volume monitor (for example a CD Audio file system driver). Such
 * a driver will generate its own #GMount object that needs to be
 * associated with the #GVolume object that represents the volume.
 * 
 * The other is for implementing a #GVolumeMonitor whose sole purpose
 * is to return #GVolume objects representing entries in the users
 * "favorite servers" list or similar.
 *
 * @param mount a #GMount object to find a parent for
 * @return the #GVolume object that is the parent for @mount or %NULL
 * if no wants to adopt the #GMount.
 */
+ (GVolume*)adoptOrphanMount:(GMount*)mount;

/**
 * Gets the volume monitor used by gio.
 *
 * @return a reference to the #GVolumeMonitor used by gio. Call
 *    g_object_unref() when done with it.
 */
+ (OGVolumeMonitor*)get;

/**
 * Methods
 */

- (GVolumeMonitor*)castedGObject;

/**
 * Gets a list of drives connected to the system.
 * 
 * The returned list should be freed with g_list_free(), after
 * its elements have been unreffed with g_object_unref().
 *
 * @return a #GList of connected #GDrive objects.
 */
- (GList*)connectedDrives;

/**
 * Finds a #GMount object by its UUID (see g_mount_get_uuid())
 *
 * @param uuid the UUID to look for
 * @return a #GMount or %NULL if no such mount is available.
 *     Free the returned object with g_object_unref().
 */
- (GMount*)mountForUuid:(OFString*)uuid;

/**
 * Gets a list of the mounts on the system.
 * 
 * The returned list should be freed with g_list_free(), after
 * its elements have been unreffed with g_object_unref().
 *
 * @return a #GList of #GMount objects.
 */
- (GList*)mounts;

/**
 * Finds a #GVolume object by its UUID (see g_volume_get_uuid())
 *
 * @param uuid the UUID to look for
 * @return a #GVolume or %NULL if no such volume is available.
 *     Free the returned object with g_object_unref().
 */
- (GVolume*)volumeForUuid:(OFString*)uuid;

/**
 * Gets a list of the volumes on the system.
 * 
 * The returned list should be freed with g_list_free(), after
 * its elements have been unreffed with g_object_unref().
 *
 * @return a #GList of #GVolume objects.
 */
- (GList*)volumes;

@end