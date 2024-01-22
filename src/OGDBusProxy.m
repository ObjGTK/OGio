/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusProxy.h"

#import "OGUnixFDList.h"
#import "OGCancellable.h"
#import "OGDBusConnection.h"

@implementation OGDBusProxy

+ (void)newWithConnection:(OGDBusConnection*)connection flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_new([connection castedGObject], flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], callback, userData);
}

+ (void)newForBusWithBusType:(GBusType)busType flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_new_for_bus(busType, flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], callback, userData);
}

- (instancetype)initFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_DBUS_PROXY(g_dbus_proxy_new_finish(res, &err));

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

- (instancetype)initForBusFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_DBUS_PROXY(g_dbus_proxy_new_for_bus_finish(res, &err));

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

- (instancetype)initForBusSyncWithBusType:(GBusType)busType flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_DBUS_PROXY(g_dbus_proxy_new_for_bus_sync(busType, flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], &err));

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

- (instancetype)initSyncWithConnection:(OGDBusConnection*)connection flags:(GDBusProxyFlags)flags info:(GDBusInterfaceInfo*)info name:(OFString*)name objectPath:(OFString*)objectPath interfaceName:(OFString*)interfaceName cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GDBusProxy* gobjectValue = G_DBUS_PROXY(g_dbus_proxy_new_sync([connection castedGObject], flags, info, [name UTF8String], [objectPath UTF8String], [interfaceName UTF8String], [cancellable castedGObject], &err));

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

- (GDBusProxy*)castedGObject
{
	return G_DBUS_PROXY([self gObject]);
}

- (void)callWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_call([self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [cancellable castedGObject], callback, userData);
}

- (GVariant*)callFinish:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_proxy_call_finish([self castedGObject], res, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GVariant*)callSyncWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_proxy_call_sync([self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)callWithUnixFdListWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_dbus_proxy_call_with_unix_fd_list([self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [fdList castedGObject], [cancellable castedGObject], callback, userData);
}

- (GVariant*)callWithUnixFdListFinishWithOutFdList:(GUnixFDList**)outFdList res:(GAsyncResult*)res
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_proxy_call_with_unix_fd_list_finish([self castedGObject], outFdList, res, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GVariant*)callWithUnixFdListSyncWithMethodName:(OFString*)methodName parameters:(GVariant*)parameters flags:(GDBusCallFlags)flags timeoutMsec:(gint)timeoutMsec fdList:(OGUnixFDList*)fdList outFdList:(GUnixFDList**)outFdList cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GVariant* returnValue = g_dbus_proxy_call_with_unix_fd_list_sync([self castedGObject], [methodName UTF8String], parameters, flags, timeoutMsec, [fdList castedGObject], outFdList, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GVariant*)cachedProperty:(OFString*)propertyName
{
	GVariant* returnValue = g_dbus_proxy_get_cached_property([self castedGObject], [propertyName UTF8String]);

	return returnValue;
}

- (gchar**)cachedPropertyNames
{
	gchar** returnValue = g_dbus_proxy_get_cached_property_names([self castedGObject]);

	return returnValue;
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_proxy_get_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection wrapperFor:gobjectValue];
	return returnValue;
}

- (gint)defaultTimeout
{
	gint returnValue = g_dbus_proxy_get_default_timeout([self castedGObject]);

	return returnValue;
}

- (GDBusProxyFlags)flags
{
	GDBusProxyFlags returnValue = g_dbus_proxy_get_flags([self castedGObject]);

	return returnValue;
}

- (GDBusInterfaceInfo*)interfaceInfo
{
	GDBusInterfaceInfo* returnValue = g_dbus_proxy_get_interface_info([self castedGObject]);

	return returnValue;
}

- (OFString*)interfaceName
{
	const gchar* gobjectValue = g_dbus_proxy_get_interface_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)name
{
	const gchar* gobjectValue = g_dbus_proxy_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)nameOwner
{
	gchar* gobjectValue = g_dbus_proxy_get_name_owner([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OFString*)objectPath
{
	const gchar* gobjectValue = g_dbus_proxy_get_object_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setCachedPropertyWithPropertyName:(OFString*)propertyName value:(GVariant*)value
{
	g_dbus_proxy_set_cached_property([self castedGObject], [propertyName UTF8String], value);
}

- (void)setDefaultTimeout:(gint)timeoutMsec
{
	g_dbus_proxy_set_default_timeout([self castedGObject], timeoutMsec);
}

- (void)setInterfaceInfo:(GDBusInterfaceInfo*)info
{
	g_dbus_proxy_set_interface_info([self castedGObject], info);
}


@end