/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDBusMethodInvocation.h"

#import "OGUnixFDList.h"
#import "OGDBusMessage.h"
#import "OGDBusConnection.h"

@implementation OGDBusMethodInvocation

- (GDBusMethodInvocation*)castedGObject
{
	return G_DBUS_METHOD_INVOCATION([self gObject]);
}

- (OGDBusConnection*)connection
{
	GDBusConnection* gobjectValue = G_DBUS_CONNECTION(g_dbus_method_invocation_get_connection([self castedGObject]));

	OGDBusConnection* returnValue = [OGDBusConnection withGObject:gobjectValue];
	return returnValue;
}

- (OFString*)interfaceName
{
	const gchar* gobjectValue = g_dbus_method_invocation_get_interface_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OGDBusMessage*)message
{
	GDBusMessage* gobjectValue = G_DBUS_MESSAGE(g_dbus_method_invocation_get_message([self castedGObject]));

	OGDBusMessage* returnValue = [OGDBusMessage withGObject:gobjectValue];
	return returnValue;
}

- (const GDBusMethodInfo*)methodInfo
{
	const GDBusMethodInfo* returnValue = g_dbus_method_invocation_get_method_info([self castedGObject]);

	return returnValue;
}

- (OFString*)methodName
{
	const gchar* gobjectValue = g_dbus_method_invocation_get_method_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)objectPath
{
	const gchar* gobjectValue = g_dbus_method_invocation_get_object_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GVariant*)parameters
{
	GVariant* returnValue = g_dbus_method_invocation_get_parameters([self castedGObject]);

	return returnValue;
}

- (const GDBusPropertyInfo*)propertyInfo
{
	const GDBusPropertyInfo* returnValue = g_dbus_method_invocation_get_property_info([self castedGObject]);

	return returnValue;
}

- (OFString*)sender
{
	const gchar* gobjectValue = g_dbus_method_invocation_get_sender([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (gpointer)userData
{
	gpointer returnValue = g_dbus_method_invocation_get_user_data([self castedGObject]);

	return returnValue;
}

- (void)returnDbusErrorWithErrorName:(OFString*)errorName errorMessage:(OFString*)errorMessage
{
	g_dbus_method_invocation_return_dbus_error([self castedGObject], [errorName UTF8String], [errorMessage UTF8String]);
}

- (void)returnErrorLiteralWithDomain:(GQuark)domain code:(gint)code message:(OFString*)message
{
	g_dbus_method_invocation_return_error_literal([self castedGObject], domain, code, [message UTF8String]);
}

- (void)returnErrorValistWithDomain:(GQuark)domain code:(gint)code format:(OFString*)format varArgs:(va_list)varArgs
{
	g_dbus_method_invocation_return_error_valist([self castedGObject], domain, code, [format UTF8String], varArgs);
}

- (void)returnGerror:(const GError*)error
{
	g_dbus_method_invocation_return_gerror([self castedGObject], error);
}

- (void)returnValue:(GVariant*)parameters
{
	g_dbus_method_invocation_return_value([self castedGObject], parameters);
}

- (void)returnValueWithUnixFdListWithParameters:(GVariant*)parameters fdList:(OGUnixFDList*)fdList
{
	g_dbus_method_invocation_return_value_with_unix_fd_list([self castedGObject], parameters, [fdList castedGObject]);
}

- (void)takeError:(GError*)error
{
	g_dbus_method_invocation_take_error([self castedGObject], error);
}


@end