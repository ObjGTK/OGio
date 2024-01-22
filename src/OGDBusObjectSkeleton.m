/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectSkeleton.h"

#import "OGDBusInterfaceSkeleton.h"

@implementation OGDBusObjectSkeleton

- (instancetype)init:(OFString*)objectPath
{
	GDBusObjectSkeleton* gobjectValue = G_DBUS_OBJECT_SKELETON(g_dbus_object_skeleton_new([objectPath UTF8String]));

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GDBusObjectSkeleton*)castedGObject
{
	return G_DBUS_OBJECT_SKELETON([self gObject]);
}

- (void)addInterface:(OGDBusInterfaceSkeleton*)interface
{
	g_dbus_object_skeleton_add_interface([self castedGObject], [interface castedGObject]);
}

- (void)flush
{
	g_dbus_object_skeleton_flush([self castedGObject]);
}

- (void)removeInterface:(OGDBusInterfaceSkeleton*)interface
{
	g_dbus_object_skeleton_remove_interface([self castedGObject], [interface castedGObject]);
}

- (void)removeInterfaceByName:(OFString*)interfaceName
{
	g_dbus_object_skeleton_remove_interface_by_name([self castedGObject], [interfaceName UTF8String]);
}

- (void)setObjectPath:(OFString*)objectPath
{
	g_dbus_object_skeleton_set_object_path([self castedGObject], [objectPath UTF8String]);
}


@end