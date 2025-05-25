/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusServer.h"

#import "OGCancellable.h"
#import "OGDBusAuthObserver.h"

@implementation OGDBusServer

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_SERVER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_SERVER);
	return gObjectClass;
}

+ (instancetype)dBusServerSyncWithAddress:(OFString*)address flags:(GDBusServerFlags)flags guid:(OFString*)guid observer:(OGDBusAuthObserver*)observer cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusServer* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_server_new_sync([address UTF8String], flags, [guid UTF8String], [observer castedGObject], [cancellable castedGObject], &err), G_TYPE_DBUS_SERVER, GDBusServer);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusServer* wrapperObject;
	@try {
		wrapperObject = [[OGDBusServer alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDBusServer*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_SERVER, GDBusServer);
}

- (OFString*)clientAddress
{
	const gchar* gobjectValue = g_dbus_server_get_client_address([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GDBusServerFlags)flags
{
	GDBusServerFlags returnValue = (GDBusServerFlags)g_dbus_server_get_flags([self castedGObject]);

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
	bool returnValue = (bool)g_dbus_server_is_active([self castedGObject]);

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