/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusInterfaceSkeleton.h"

#import "OGDBusConnection.h"

@implementation OGDBusInterfaceSkeleton

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_INTERFACE_SKELETON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_INTERFACE_SKELETON);
	return gObjectClass;
}

- (GDBusInterfaceSkeleton*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_INTERFACE_SKELETON, GDBusInterfaceSkeleton);
}

- (bool)exportWithConnection:(OGDBusConnection*)connection objectPath:(OFString*)objectPath
{
	GError* err = NULL;

	bool returnValue = (bool)g_dbus_interface_skeleton_export((GDBusInterfaceSkeleton*)[self castedGObject], [connection castedGObject], [objectPath UTF8String], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)flush
{
	g_dbus_interface_skeleton_flush((GDBusInterfaceSkeleton*)[self castedGObject]);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = g_dbus_interface_skeleton_get_connection((GDBusInterfaceSkeleton*)[self castedGObject]);

	OGDBusConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GList*)connections
{
	GList* returnValue = (GList*)g_dbus_interface_skeleton_get_connections((GDBusInterfaceSkeleton*)[self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceSkeletonFlags)flags
{
	GDBusInterfaceSkeletonFlags returnValue = (GDBusInterfaceSkeletonFlags)g_dbus_interface_skeleton_get_flags((GDBusInterfaceSkeleton*)[self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceInfo*)info
{
	GDBusInterfaceInfo* returnValue = (GDBusInterfaceInfo*)g_dbus_interface_skeleton_get_info((GDBusInterfaceSkeleton*)[self castedGObject]);

	return returnValue;
}

- (OFString*)objectPath
{
	const gchar* gobjectValue = g_dbus_interface_skeleton_get_object_path((GDBusInterfaceSkeleton*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GVariant*)properties
{
	GVariant* returnValue = (GVariant*)g_dbus_interface_skeleton_get_properties((GDBusInterfaceSkeleton*)[self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceVTable*)vtable
{
	GDBusInterfaceVTable* returnValue = (GDBusInterfaceVTable*)g_dbus_interface_skeleton_get_vtable((GDBusInterfaceSkeleton*)[self castedGObject]);

	return returnValue;
}

- (bool)hasConnection:(OGDBusConnection*)connection
{
	bool returnValue = (bool)g_dbus_interface_skeleton_has_connection((GDBusInterfaceSkeleton*)[self castedGObject], [connection castedGObject]);

	return returnValue;
}

- (void)setFlags:(GDBusInterfaceSkeletonFlags)flags
{
	g_dbus_interface_skeleton_set_flags((GDBusInterfaceSkeleton*)[self castedGObject], flags);
}

- (void)unexport
{
	g_dbus_interface_skeleton_unexport((GDBusInterfaceSkeleton*)[self castedGObject]);
}

- (void)unexportFromConnection:(OGDBusConnection*)connection
{
	g_dbus_interface_skeleton_unexport_from_connection((GDBusInterfaceSkeleton*)[self castedGObject], [connection castedGObject]);
}


@end