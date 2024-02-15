/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusServer.h"

#import "OGCancellable.h"
#import "OGDBusAuthObserver.h"

@implementation OGDBusServer

- (instancetype)initSyncWithAddress:(OFString*)address flags:(GDBusServerFlags)flags guid:(OFString*)guid observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusServer* gobjectValue = G_DBUS_SERVER(g_dbus_server_new_sync([address UTF8String], flags, [guid UTF8String], [observer castedGObject], [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

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

- (GDBusServer*)castedGObject
{
	return G_DBUS_SERVER([self gObject]);
}

- (OFString*)clientAddress
{
	const gchar* gobjectValue = g_dbus_server_get_client_address([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GDBusServerFlags)flags
{
	GDBusServerFlags returnValue = g_dbus_server_get_flags([self castedGObject]);

	return returnValue;
}

- (OFString*)guid
{
	const gchar* gobjectValue = g_dbus_server_get_guid([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)isActive
{
	bool returnValue = g_dbus_server_is_active([self castedGObject]);

	return returnValue;
}

- (void)start
{
	g_dbus_server_start([self castedGObject]);
}

- (void)stop
{
	g_dbus_server_stop([self castedGObject]);
}


@end