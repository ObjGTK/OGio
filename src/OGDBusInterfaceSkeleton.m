/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusInterfaceSkeleton.h"

#import "OGDBusConnection.h"

@implementation OGDBusInterfaceSkeleton

- (GDBusInterfaceSkeleton*)castedGObject
{
	return G_DBUS_INTERFACE_SKELETON([self gObject]);
}

- (bool)exportWithConnection:(OGDBusConnection*)connection objectPath:(OFString*)objectPath
{
	GError* err = NULL;

	bool returnValue = g_dbus_interface_skeleton_export([self castedGObject], [connection castedGObject], [objectPath UTF8String], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)flush
{
	g_dbus_interface_skeleton_flush([self castedGObject]);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_interface_skeleton_get_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection wrapperFor:gobjectValue];
	return returnValue;
}

- (GList*)connections
{
	GList* returnValue = g_dbus_interface_skeleton_get_connections([self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceSkeletonFlags)flags
{
	GDBusInterfaceSkeletonFlags returnValue = g_dbus_interface_skeleton_get_flags([self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceInfo*)info
{
	GDBusInterfaceInfo* returnValue = g_dbus_interface_skeleton_get_info([self castedGObject]);

	return returnValue;
}

- (OFString*)objectPath
{
	const gchar* gobjectValue = g_dbus_interface_skeleton_get_object_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GVariant*)properties
{
	GVariant* returnValue = g_dbus_interface_skeleton_get_properties([self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceVTable*)vtable
{
	GDBusInterfaceVTable* returnValue = g_dbus_interface_skeleton_get_vtable([self castedGObject]);

	return returnValue;
}

- (bool)hasConnection:(OGDBusConnection*)connection
{
	bool returnValue = g_dbus_interface_skeleton_has_connection([self castedGObject], [connection castedGObject]);

	return returnValue;
}

- (void)setFlags:(GDBusInterfaceSkeletonFlags)flags
{
	g_dbus_interface_skeleton_set_flags([self castedGObject], flags);
}

- (void)unexport
{
	g_dbus_interface_skeleton_unexport([self castedGObject]);
}

- (void)unexportFromConnection:(OGDBusConnection*)connection
{
	g_dbus_interface_skeleton_unexport_from_connection([self castedGObject], [connection castedGObject]);
}


@end