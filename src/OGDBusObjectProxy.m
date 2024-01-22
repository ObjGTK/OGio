/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectProxy.h"

#import "OGDBusConnection.h"

@implementation OGDBusObjectProxy

- (instancetype)initWithConnection:(OGDBusConnection*)connection objectPath:(OFString*)objectPath
{
	GDBusObjectProxy* gobjectValue = G_DBUS_OBJECT_PROXY(g_dbus_object_proxy_new([connection castedGObject], [objectPath UTF8String]));

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

- (GDBusObjectProxy*)castedGObject
{
	return G_DBUS_OBJECT_PROXY([self gObject]);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_object_proxy_get_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection wrapperFor:gobjectValue];
	return returnValue;
}


@end