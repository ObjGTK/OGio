/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixfdmessage.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

@class OGUnixFDList;
@class OGDBusConnection;
@class OGDBusMessage;

/**
 * Instances of the #GDBusMethodInvocation class are used when
 * handling D-Bus method calls. It provides a way to asynchronously
 * return results and errors.
 * 
 * The normal way to obtain a #GDBusMethodInvocation object is to receive
 * it as an argument to the handle_method_call() function in a
 * #GDBusInterfaceVTable that was passed to g_dbus_connection_register_object().
 *
 */
@interface OGDBusMethodInvocation : OGObject
{

}


/**
 * Methods
 */

- (GDBusMethodInvocation*)castedGObject;

/**
 * Gets the #GDBusConnection the method was invoked on.
 *
 * @return A #GDBusConnection. Do not free, it is owned by @invocation.
 */
- (OGDBusConnection*)connection;

/**
 * Gets the name of the D-Bus interface the method was invoked on.
 * 
 * If this method call is a property Get, Set or GetAll call that has
 * been redirected to the method call handler then
 * "org.freedesktop.DBus.Properties" will be returned.  See
 * #GDBusInterfaceVTable for more information.
 *
 * @return A string. Do not free, it is owned by @invocation.
 */
- (OFString*)interfaceName;

/**
 * Gets the #GDBusMessage for the method invocation. This is useful if
 * you need to use low-level protocol features, such as UNIX file
 * descriptor passing, that cannot be properly expressed in the
 * #GVariant API.
 * 
 * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
 * for an example of how to use this low-level API to send and receive
 * UNIX file descriptors.
 *
 * @return #GDBusMessage. Do not free, it is owned by @invocation.
 */
- (OGDBusMessage*)message;

/**
 * Gets information about the method call, if any.
 * 
 * If this method invocation is a property Get, Set or GetAll call that
 * has been redirected to the method call handler then %NULL will be
 * returned.  See g_dbus_method_invocation_get_property_info() and
 * #GDBusInterfaceVTable for more information.
 *
 * @return A #GDBusMethodInfo or %NULL. Do not free, it is owned by @invocation.
 */
- (const GDBusMethodInfo*)methodInfo;

/**
 * Gets the name of the method that was invoked.
 *
 * @return A string. Do not free, it is owned by @invocation.
 */
- (OFString*)methodName;

/**
 * Gets the object path the method was invoked on.
 *
 * @return A string. Do not free, it is owned by @invocation.
 */
- (OFString*)objectPath;

/**
 * Gets the parameters of the method invocation. If there are no input
 * parameters then this will return a GVariant with 0 children rather than NULL.
 *
 * @return A #GVariant tuple. Do not unref this because it is owned by @invocation.
 */
- (GVariant*)parameters;

/**
 * Gets information about the property that this method call is for, if
 * any.
 * 
 * This will only be set in the case of an invocation in response to a
 * property Get or Set call that has been directed to the method call
 * handler for an object on account of its property_get() or
 * property_set() vtable pointers being unset.
 * 
 * See #GDBusInterfaceVTable for more information.
 * 
 * If the call was GetAll, %NULL will be returned.
 *
 * @return a #GDBusPropertyInfo or %NULL
 */
- (const GDBusPropertyInfo*)propertyInfo;

/**
 * Gets the bus name that invoked the method.
 *
 * @return A string. Do not free, it is owned by @invocation.
 */
- (OFString*)sender;

/**
 * Gets the @user_data #gpointer passed to g_dbus_connection_register_object().
 *
 * @return A #gpointer.
 */
- (gpointer)userData;

/**
 * Finishes handling a D-Bus method call by returning an error.
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 *
 * @param errorName A valid D-Bus error name.
 * @param errorMessage A valid D-Bus error message.
 */
- (void)returnDbusErrorWithErrorName:(OFString*)errorName errorMessage:(OFString*)errorMessage;

/**
 * Like g_dbus_method_invocation_return_error() but without printf()-style formatting.
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 *
 * @param domain A #GQuark for the #GError error domain.
 * @param code The error code.
 * @param message The error message.
 */
- (void)returnErrorLiteralWithDomain:(GQuark)domain code:(gint)code message:(OFString*)message;

/**
 * Like g_dbus_method_invocation_return_error() but intended for
 * language bindings.
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 *
 * @param domain A #GQuark for the #GError error domain.
 * @param code The error code.
 * @param format printf()-style format.
 * @param varArgs #va_list of parameters for @format.
 */
- (void)returnErrorValistWithDomain:(GQuark)domain code:(gint)code format:(OFString*)format varArgs:(va_list)varArgs;

/**
 * Like g_dbus_method_invocation_return_error() but takes a #GError
 * instead of the error domain, error code and message.
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 *
 * @param error A #GError.
 */
- (void)returnGerror:(const GError*)error;

/**
 * Finishes handling a D-Bus method call by returning @parameters.
 * If the @parameters GVariant is floating, it is consumed.
 * 
 * It is an error if @parameters is not of the right format: it must be a tuple
 * containing the out-parameters of the D-Bus method. Even if the method has a
 * single out-parameter, it must be contained in a tuple. If the method has no
 * out-parameters, @parameters may be %NULL or an empty tuple.
 * 
 * |[<!-- language="C" -->
 * GDBusMethodInvocation *invocation = some_invocation;
 * g_autofree gchar *result_string = NULL;
 * g_autoptr (GError) error = NULL;
 * 
 * result_string = calculate_result (&error);
 * 
 * if (error != NULL)
 *   g_dbus_method_invocation_return_gerror (invocation, error);
 * else
 *   g_dbus_method_invocation_return_value (invocation,
 *                                          g_variant_new ("(s)", result_string));
 * 
 * // Do not free @invocation here; returning a value does that
 * ]|
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 * 
 * Since 2.48, if the method call requested for a reply not to be sent
 * then this call will sink @parameters and free @invocation, but
 * otherwise do nothing (as per the recommendations of the D-Bus
 * specification).
 *
 * @param parameters A #GVariant tuple with out parameters for the method or %NULL if not passing any parameters.
 */
- (void)returnValue:(GVariant*)parameters;

/**
 * Like g_dbus_method_invocation_return_value() but also takes a #GUnixFDList.
 * 
 * This method is only available on UNIX.
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 *
 * @param parameters A #GVariant tuple with out parameters for the method or %NULL if not passing any parameters.
 * @param fdList A #GUnixFDList or %NULL.
 */
- (void)returnValueWithUnixFdListWithParameters:(GVariant*)parameters fdList:(OGUnixFDList*)fdList;

/**
 * Like g_dbus_method_invocation_return_gerror() but takes ownership
 * of @error so the caller does not need to free it.
 * 
 * This method will take ownership of @invocation. See
 * #GDBusInterfaceVTable for more information about the ownership of
 * @invocation.
 *
 * @param error A #GError.
 */
- (void)takeError:(GError*)error;

@end