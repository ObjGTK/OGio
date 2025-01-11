/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGInetAddress.h"

@implementation OGInetAddress

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_INET_ADDRESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)inetAddressAny:(GSocketFamily)family
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_any(family), GInetAddress, GInetAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGInetAddress* wrapperObject;
	@try {
		wrapperObject = [[OGInetAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)inetAddressFromBytesWithBytes:(const guint8*)bytes family:(GSocketFamily)family
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_from_bytes(bytes, family), GInetAddress, GInetAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGInetAddress* wrapperObject;
	@try {
		wrapperObject = [[OGInetAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)inetAddressFromString:(OFString*)string
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_from_string([string UTF8String]), GInetAddress, GInetAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGInetAddress* wrapperObject;
	@try {
		wrapperObject = [[OGInetAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)inetAddressLoopback:(GSocketFamily)family
{
	GInetAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_inet_address_new_loopback(family), GInetAddress, GInetAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGInetAddress* wrapperObject;
	@try {
		wrapperObject = [[OGInetAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GInetAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GInetAddress, GInetAddress);
}

- (bool)equal:(OGInetAddress*)otherAddress
{
	bool returnValue = (bool)g_inet_address_equal([self castedGObject], [otherAddress castedGObject]);

	return returnValue;
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = (GSocketFamily)g_inet_address_get_family([self castedGObject]);

	return returnValue;
}

- (bool)isAny
{
	bool returnValue = (bool)g_inet_address_get_is_any([self castedGObject]);

	return returnValue;
}

- (bool)isLinkLocal
{
	bool returnValue = (bool)g_inet_address_get_is_link_local([self castedGObject]);

	return returnValue;
}

- (bool)isLoopback
{
	bool returnValue = (bool)g_inet_address_get_is_loopback([self castedGObject]);

	return returnValue;
}

- (bool)isMcGlobal
{
	bool returnValue = (bool)g_inet_address_get_is_mc_global([self castedGObject]);

	return returnValue;
}

- (bool)isMcLinkLocal
{
	bool returnValue = (bool)g_inet_address_get_is_mc_link_local([self castedGObject]);

	return returnValue;
}

- (bool)isMcNodeLocal
{
	bool returnValue = (bool)g_inet_address_get_is_mc_node_local([self castedGObject]);

	return returnValue;
}

- (bool)isMcOrgLocal
{
	bool returnValue = (bool)g_inet_address_get_is_mc_org_local([self castedGObject]);

	return returnValue;
}

- (bool)isMcSiteLocal
{
	bool returnValue = (bool)g_inet_address_get_is_mc_site_local([self castedGObject]);

	return returnValue;
}

- (bool)isMulticast
{
	bool returnValue = (bool)g_inet_address_get_is_multicast([self castedGObject]);

	return returnValue;
}

- (bool)isSiteLocal
{
	bool returnValue = (bool)g_inet_address_get_is_site_local([self castedGObject]);

	return returnValue;
}

- (gsize)nativeSize
{
	gsize returnValue = (gsize)g_inet_address_get_native_size([self castedGObject]);

	return returnValue;
}

- (const guint8*)toBytes
{
	const guint8* returnValue = (const guint8*)g_inet_address_to_bytes([self castedGObject]);

	return returnValue;
}

- (OFString*)toString
{
	gchar* gobjectValue = g_inet_address_to_string([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}


@end