/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGVolumeMonitor.h"

@implementation OGVolumeMonitor

+ (GVolume*)adoptOrphanMount:(GMount*)mount
{
	GVolume* returnValue = g_volume_monitor_adopt_orphan_mount(mount);

	return returnValue;
}

+ (OGVolumeMonitor*)get
{
	GVolumeMonitor* gobjectValue = G_VOLUME_MONITOR(g_volume_monitor_get());

	OGVolumeMonitor* returnValue = [OGVolumeMonitor wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GVolumeMonitor*)castedGObject
{
	return G_VOLUME_MONITOR([self gObject]);
}

- (GList*)connectedDrives
{
	GList* returnValue = g_volume_monitor_get_connected_drives([self castedGObject]);

	return returnValue;
}

- (GMount*)mountForUuid:(OFString*)uuid
{
	GMount* returnValue = g_volume_monitor_get_mount_for_uuid([self castedGObject], [uuid UTF8String]);

	return returnValue;
}

- (GList*)mounts
{
	GList* returnValue = g_volume_monitor_get_mounts([self castedGObject]);

	return returnValue;
}

- (GVolume*)volumeForUuid:(OFString*)uuid
{
	GVolume* returnValue = g_volume_monitor_get_volume_for_uuid([self castedGObject], [uuid UTF8String]);

	return returnValue;
}

- (GList*)volumes
{
	GList* returnValue = g_volume_monitor_get_volumes([self castedGObject]);

	return returnValue;
}


@end