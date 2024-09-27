/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNetworkAddress.h"

@implementation OGNetworkAddress

+ (GSocketConnectable*)parseWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort
{
	GError* err = NULL;

	GSocketConnectable* returnValue = g_network_address_parse([hostAndPort UTF8String], defaultPort, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

+ (GSocketConnectable*)parseUriWithUri:(OFString*)uri defaultPort:(guint16)defaultPort
{
	GError* err = NULL;

	GSocketConnectable* returnValue = g_network_address_parse_uri([uri UTF8String], defaultPort, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (instancetype)initWithHostname:(OFString*)hostname port:(guint16)port
{
	GNetworkAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_network_address_new([hostname UTF8String], port), GNetworkAddress, GNetworkAddress);

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

- (instancetype)initLoopback:(guint16)port
{
	GNetworkAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_network_address_new_loopback(port), GNetworkAddress, GNetworkAddress);

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

- (GNetworkAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GNetworkAddress, GNetworkAddress);
}

- (OFString*)hostname
{
	const gchar* gobjectValue = g_network_address_get_hostname([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (guint16)port
{
	guint16 returnValue = g_network_address_get_port([self castedGObject]);

	return returnValue;
}

- (OFString*)scheme
{
	const gchar* gobjectValue = g_network_address_get_scheme([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}


@end