/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusAuthObserver.h"

#import "OGCredentials.h"
#import "OGIOStream.h"

@implementation OGDBusAuthObserver

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_AUTH_OBSERVER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GDBusAuthObserver* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_auth_observer_new(), GDBusAuthObserver, GDBusAuthObserver);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDBusAuthObserver, GDBusAuthObserver);
}

- (bool)allowMechanism:(OFString*)mechanism
{
	bool returnValue = (bool)g_dbus_auth_observer_allow_mechanism([self castedGObject], [mechanism UTF8String]);

	return returnValue;
}

- (bool)authorizeAuthenticatedPeerWithStream:(OGIOStream*)stream credentials:(OGCredentials*)credentials
{
	bool returnValue = (bool)g_dbus_auth_observer_authorize_authenticated_peer([self castedGObject], [stream castedGObject], [credentials castedGObject]);

	return returnValue;
}


@end