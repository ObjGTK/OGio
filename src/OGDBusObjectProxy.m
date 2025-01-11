/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusObjectProxy.h"

#import "OGDBusConnection.h"

@implementation OGDBusObjectProxy

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_OBJECT_PROXY;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)dBusObjectProxyWithConnection:(OGDBusConnection*)connection objectPath:(OFString*)objectPath
{
	GDBusObjectProxy* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_object_proxy_new([connection castedGObject], [objectPath UTF8String]), GDBusObjectProxy, GDBusObjectProxy);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDBusObjectProxy* wrapperObject;
	@try {
		wrapperObject = [[OGDBusObjectProxy alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDBusObjectProxy*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDBusObjectProxy, GDBusObjectProxy);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = g_dbus_object_proxy_get_connection([self castedGObject]);

	OGDBusConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}


@end