/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectManagerServer.h"

#import "OGDBusConnection.h"
#import "OGDBusObjectSkeleton.h"

@implementation OGDBusObjectManagerServer

- (instancetype)init:(OFString*)objectPath
{
	GDBusObjectManagerServer* gobjectValue = G_DBUS_OBJECT_MANAGER_SERVER(g_dbus_object_manager_server_new([objectPath UTF8String]));

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

- (GDBusObjectManagerServer*)castedGObject
{
	return G_DBUS_OBJECT_MANAGER_SERVER([self gObject]);
}

- (void)export:(OGDBusObjectSkeleton*)object
{
	g_dbus_object_manager_server_export([self castedGObject], [object castedGObject]);
}

- (void)exportUniquely:(OGDBusObjectSkeleton*)object
{
	g_dbus_object_manager_server_export_uniquely([self castedGObject], [object castedGObject]);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_object_manager_server_get_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)isExported:(OGDBusObjectSkeleton*)object
{
	bool returnValue = g_dbus_object_manager_server_is_exported([self castedGObject], [object castedGObject]);

	return returnValue;
}

- (void)setConnection:(OGDBusConnection*)connection
{
	g_dbus_object_manager_server_set_connection([self castedGObject], [connection castedGObject]);
}

- (bool)unexport:(OFString*)objectPath
{
	bool returnValue = g_dbus_object_manager_server_unexport([self castedGObject], [objectPath UTF8String]);

	return returnValue;
}


@end