/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInetAddress.h"

@implementation OGInetAddress

- (instancetype)initAny:(GSocketFamily)family
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_any(family), GInetAddress, GInetAddress);

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

- (instancetype)initFromBytesWithBytes:(const guint8*)bytes family:(GSocketFamily)family
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_from_bytes(bytes, family), GInetAddress, GInetAddress);

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

- (instancetype)initFromString:(OFString*)string
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_from_string([string UTF8String]), GInetAddress, GInetAddress);

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

- (instancetype)initLoopback:(GSocketFamily)family
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_loopback(family), GInetAddress, GInetAddress);

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

- (GInetAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GInetAddress, GInetAddress);
}

- (bool)equal:(OGInetAddress*)otherAddress
{
	bool returnValue = g_inet_address_equal([self castedGObject], [otherAddress castedGObject]);

	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = g_inet_address_get_family([self castedGObject]);

	return returnValue;
}

- (bool)isAny
{
	bool returnValue = g_inet_address_get_is_any([self castedGObject]);

	return returnValue;
}

- (bool)isLinkLocal
{
	bool returnValue = g_inet_address_get_is_link_local([self castedGObject]);

	return returnValue;
}

- (bool)isLoopback
{
	bool returnValue = g_inet_address_get_is_loopback([self castedGObject]);

	return returnValue;
}

- (bool)isMcGlobal
{
	bool returnValue = g_inet_address_get_is_mc_global([self castedGObject]);

	return returnValue;
}

- (bool)isMcLinkLocal
{
	bool returnValue = g_inet_address_get_is_mc_link_local([self castedGObject]);

	return returnValue;
}

- (bool)isMcNodeLocal
{
	bool returnValue = g_inet_address_get_is_mc_node_local([self castedGObject]);

	return returnValue;
}

- (bool)isMcOrgLocal
{
	bool returnValue = g_inet_address_get_is_mc_org_local([self castedGObject]);

	return returnValue;
}

- (bool)isMcSiteLocal
{
	bool returnValue = g_inet_address_get_is_mc_site_local([self castedGObject]);

	return returnValue;
}

- (bool)isMulticast
{
	bool returnValue = g_inet_address_get_is_multicast([self castedGObject]);

	return returnValue;
}

- (bool)isSiteLocal
{
	bool returnValue = g_inet_address_get_is_site_local([self castedGObject]);

	return returnValue;
}

- (gsize)nativeSize
{
	gsize returnValue = g_inet_address_get_native_size([self castedGObject]);

	return returnValue;
}

- (const guint8*)toBytes
{
	const guint8* returnValue = g_inet_address_to_bytes([self castedGObject]);

	return returnValue;
}

- (OFString*)toString
{
	gchar* gobjectValue = g_inet_address_to_string([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}


@end