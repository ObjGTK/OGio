/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectSkeleton.h"

#import "OGDBusInterfaceSkeleton.h"

@implementation OGDBusObjectSkeleton

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_OBJECT_SKELETON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_OBJECT_SKELETON);
	return gObjectClass;
}

+ (instancetype)dBusObjectSkeletonWithObjectPath:(OFString*)objectPath
{
	GDBusObjectSkeleton* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_object_skeleton_new([objectPath UTF8String]), G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeleton);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDBusObjectSkeleton* wrapperObject;
	@try {
		wrapperObject = [[OGDBusObjectSkeleton alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDBusObjectSkeleton*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_OBJECT_SKELETON, GDBusObjectSkeleton);
}

- (void)addInterface:(OGDBusInterfaceSkeleton*)interface
{
	g_dbus_object_skeleton_add_interface((GDBusObjectSkeleton*)[self castedGObject], [interface castedGObject]);
}

- (void)flush
{
	g_dbus_object_skeleton_flush((GDBusObjectSkeleton*)[self castedGObject]);
}

- (void)removeInterface:(OGDBusInterfaceSkeleton*)interface
{
	g_dbus_object_skeleton_remove_interface((GDBusObjectSkeleton*)[self castedGObject], [interface castedGObject]);
}

- (void)removeInterfaceByNameWithInterfaceName:(OFString*)interfaceName
{
	g_dbus_object_skeleton_remove_interface_by_name((GDBusObjectSkeleton*)[self castedGObject], [interfaceName UTF8String]);
}

- (void)setObjectPath:(OFString*)objectPath
{
	g_dbus_object_skeleton_set_object_path((GDBusObjectSkeleton*)[self castedGObject], [objectPath UTF8String]);
}


@end