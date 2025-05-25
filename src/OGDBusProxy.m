/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusProxy.h"

#import "OGCancellable.h"
#import "OGDBusConnection.h"
#import "OGUnixFDList.h"

@implementation OGDBusProxy

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DBUS_PROXY;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DBUS_PROXY);
	return gObjectClass;
}

+ (void)newWithConnection:(OGDBusConnection*)connection flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_new([connection castedGObject], flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], callback, userData);
}

+ (void)newForBusWithBusType:(GBusType)busType flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_new_for_bus(busType, flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], callback, userData);
}

+ (instancetype)dBusProxyFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_proxy_new_finish(res, &err), G_TYPE_DBUS_PROXY, GDBusProxy);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusProxy* wrapperObject;
	@try {
		wrapperObject = [[OGDBusProxy alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusProxyForBusFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_proxy_new_for_bus_finish(res, &err), G_TYPE_DBUS_PROXY, GDBusProxy);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusProxy* wrapperObject;
	@try {
		wrapperObject = [[OGDBusProxy alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusProxyForBusSyncWithBusType:(GBusType)busType flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_proxy_new_for_bus_sync(busType, flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], &err), G_TYPE_DBUS_PROXY, GDBusProxy);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusProxy* wrapperObject;
	@try {
		wrapperObject = [[OGDBusProxy alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)dBusProxySyncWithConnection:(OGDBusConnection*)connection flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_dbus_proxy_new_sync([connection castedGObject], flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], &err), G_TYPE_DBUS_PROXY, GDBusProxy);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGDBusProxy* wrapperObject;
	@try {
		wrapperObject = [[OGDBusProxy alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDBusProxy*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DBUS_PROXY, GDBusProxy);
}

- (void)callWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_call((GDBusProxy*)[self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [cancellable castedGObject], callback, userData);
}

- (GVariant*)callFinishWithRes:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_proxy_call_finish((GDBusProxy*)[self castedGObject], res, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GVariant*)callSyncWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_proxy_call_sync((GDBusProxy*)[self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)callWithUnixFdListWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_call_with_unix_fd_list((GDBusProxy*)[self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [fdList castedGObject], [cancellable castedGObject], callback, userData);
}

- (GVariant*)callWithUnixFdListFinishWithOutFdList:(GUnixFDList**)outFdList res:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_proxy_call_with_unix_fd_list_finish((GDBusProxy*)[self castedGObject], outFdList, res, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GVariant*)callWithUnixFdListSyncWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList outFdList:(GUnixFDList**)outFdList cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = (GVariant*)g_dbus_proxy_call_with_unix_fd_list_sync((GDBusProxy*)[self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [fdList castedGObject], outFdList, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GVariant*)cachedPropertyWithPropertyName:(OFString*)propertyName
{
	GVariant* returnValue = (GVariant*)g_dbus_proxy_get_cached_property((GDBusProxy*)[self castedGObject], [propertyName UTF8String]);

	return returnValue;
}

- (gchar**)cachedPropertyNames
{
	gchar** returnValue = (gchar**)g_dbus_proxy_get_cached_property_names((GDBusProxy*)[self castedGObject]);

	return returnValue;
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = g_dbus_proxy_get_connection((GDBusProxy*)[self castedGObject]);

	OGDBusConnection* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (gint)defaultTimeout
{
	gint returnValue = (gint)g_dbus_proxy_get_default_timeout((GDBusProxy*)[self castedGObject]);

	return returnValue;
}

- (GDBusProxyFlags)flags
{
	GDBusProxyFlags returnValue = (GDBusProxyFlags)g_dbus_proxy_get_flags((GDBusProxy*)[self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceInfo*)interfaceInfo
{
	GDBusInterfaceInfo* returnValue = (GDBusInterfaceInfo*)g_dbus_proxy_get_interface_info((GDBusProxy*)[self castedGObject]);

	return returnValue;
}

- (OFString*)interfaceName
{
	const gchar* gobjectValue = g_dbus_proxy_get_interface_name((GDBusProxy*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)name
{
	const gchar* gobjectValue = g_dbus_proxy_get_name((GDBusProxy*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)nameOwner
{
	gchar* gobjectValue = g_dbus_proxy_get_name_owner((GDBusProxy*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OFString*)objectPath
{
	const gchar* gobjectValue = g_dbus_proxy_get_object_path((GDBusProxy*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setCachedPropertyWithPropertyName:(OFString*)propertyName value:(GVariant*)value
{
	g_dbus_proxy_set_cached_property((GDBusProxy*)[self castedGObject], [propertyName UTF8String], value);
}

- (void)setDefaultTimeoutWithTimeoutMsec:(gint)timeoutMsec
{
	g_dbus_proxy_set_default_timeout((GDBusProxy*)[self castedGObject], timeoutMsec);
}

- (void)setInterfaceInfo:(GDBusInterfaceInfo*)info
{
	g_dbus_proxy_set_interface_info((GDBusProxy*)[self castedGObject], info);
}


@end