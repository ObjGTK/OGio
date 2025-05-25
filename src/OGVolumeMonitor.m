/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGVolumeMonitor.h"

@implementation OGVolumeMonitor

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_VOLUME_MONITOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_VOLUME_MONITOR);
	return gObjectClass;
}

+ (GVolume*)adoptOrphanMount:(GMount*)mount
{
	GVolume* returnValue = (GVolume*)g_volume_monitor_adopt_orphan_mount(mount);

	return returnValue;
}

+ (OGVolumeMonitor*)get
{
	GVolumeMonitor* gobjectValue = g_volume_monitor_get();

	OGVolumeMonitor* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GVolumeMonitor*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_VOLUME_MONITOR, GVolumeMonitor);
}

- (GList*)connectedDrives
{
	GList* returnValue = (GList*)g_volume_monitor_get_connected_drives([self castedGObject]);

	return returnValue;
}

- (GMount*)mountForUuid:(OFString*)uuid
{
	GMount* returnValue = (GMount*)g_volume_monitor_get_mount_for_uuid([self castedGObject], [uuid UTF8String]);

	return returnValue;
}

- (GList*)mounts
{
	GList* returnValue = (GList*)g_volume_monitor_get_mounts([self castedGObject]);

	return returnValue;
}

- (GVolume*)volumeForUuid:(OFString*)uuid
{
	GVolume* returnValue = (GVolume*)g_volume_monitor_get_volume_for_uuid([self castedGObject], [uuid UTF8String]);

	return returnValue;
}

- (GList*)volumes
{
	GList* returnValue = (GList*)g_volume_monitor_get_volumes([self castedGObject]);

	return returnValue;
}


@end