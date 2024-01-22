/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusAuthObserver.h"

#import "OGIOStream.h"
#import "OGCredentials.h"

@implementation OGDBusAuthObserver

- (instancetype)init
{
	GDBusAuthObserver* gobjectValue = G_DBUS_AUTH_OBSERVER(g_dbus_auth_observer_new());

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

- (GDBusAuthObserver*)castedGObject
{
	return G_DBUS_AUTH_OBSERVER([self gObject]);
}

- (bool)allowMechanism:(OFString*)mechanism
{
	bool returnValue = g_dbus_auth_observer_allow_mechanism([self castedGObject], [mechanism UTF8String]);

	return returnValue;
}

- (bool)authorizeAuthenticatedPeerWithStream:(OGIOStream*)stream credentials:(OGCredentials*)credentials
{
	bool returnValue = g_dbus_auth_observer_authorize_authenticated_peer([self castedGObject], [stream castedGObject], [credentials castedGObject]);

	return returnValue;
}


@end