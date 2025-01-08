/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGProxyAddress.h"

#import "OGInetAddress.h"
#import "OGSocketAddress.h"

@implementation OGProxyAddress

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_PROXY_ADDRESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithInetaddr:(OGInetAddress*)inetaddr port:(guint16)port protocol:(OFString*)protocol destHostname:(OFString*)destHostname destPort:(guint16)destPort username:(OFString*)username password:(OFString*)password
{
	GProxyAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_proxy_address_new([inetaddr castedGObject], port, [protocol UTF8String], [destHostname UTF8String], destPort, [username UTF8String], [password UTF8String]), GProxyAddress, GProxyAddress);

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

- (GProxyAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GProxyAddress, GProxyAddress);
}

- (OFString*)destinationHostname
{
	const gchar* gobjectValue = g_proxy_address_get_destination_hostname([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (guint16)destinationPort
{
	guint16 returnValue = (guint16)g_proxy_address_get_destination_port([self castedGObject]);

	return returnValue;
}

- (OFString*)destinationProtocol
{
	const gchar* gobjectValue = g_proxy_address_get_destination_protocol([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)password
{
	const gchar* gobjectValue = g_proxy_address_get_password([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)protocol
{
	const gchar* gobjectValue = g_proxy_address_get_protocol([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)uri
{
	const gchar* gobjectValue = g_proxy_address_get_uri([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)username
{
	const gchar* gobjectValue = g_proxy_address_get_username([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}


@end