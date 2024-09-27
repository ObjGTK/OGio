/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixSocketAddress.h"

@implementation OGUnixSocketAddress

+ (bool)abstractNamesSupported
{
	bool returnValue = g_unix_socket_address_abstract_names_supported();

	return returnValue;
}

- (instancetype)init:(OFString*)path
{
	GUnixSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_socket_address_new([path UTF8String]), GUnixSocketAddress, GUnixSocketAddress);

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

- (instancetype)initAbstractWithPath:(OFString*)path pathLen:(gint)pathLen
{
	GUnixSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_socket_address_new_abstract([path UTF8String], pathLen), GUnixSocketAddress, GUnixSocketAddress);

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

- (instancetype)initWithTypeWithPath:(OFString*)path pathLen:(gint)pathLen type:(GUnixSocketAddressType)type
{
	GUnixSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_unix_socket_address_new_with_type([path UTF8String], pathLen, type), GUnixSocketAddress, GUnixSocketAddress);

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

- (GUnixSocketAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GUnixSocketAddress, GUnixSocketAddress);
}

- (GUnixSocketAddressType)addressType
{
	GUnixSocketAddressType returnValue = g_unix_socket_address_get_address_type([self castedGObject]);

	return returnValue;
}

- (bool)isAbstract
{
	bool returnValue = g_unix_socket_address_get_is_abstract([self castedGObject]);

	return returnValue;
}

- (OFString*)path
{
	const char* gobjectValue = g_unix_socket_address_get_path([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (gsize)pathLen
{
	gsize returnValue = g_unix_socket_address_get_path_len([self castedGObject]);

	return returnValue;
}


@end