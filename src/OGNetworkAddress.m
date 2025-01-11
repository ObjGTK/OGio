/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNetworkAddress.h"

@implementation OGNetworkAddress

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_NETWORK_ADDRESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GSocketConnectable*)parseWithHostAndPort:(OFString*)hostAndPort defaultPort:(guint16)defaultPort
{
	GError* err = NULL;

	GSocketConnectable* returnValue = (GSocketConnectable*)g_network_address_parse([hostAndPort UTF8String], defaultPort, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

+ (GSocketConnectable*)parseUriWithUri:(OFString*)uri defaultPort:(guint16)defaultPort
{
	GError* err = NULL;

	GSocketConnectable* returnValue = (GSocketConnectable*)g_network_address_parse_uri([uri UTF8String], defaultPort, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

+ (instancetype)networkAddressWithHostname:(OFString*)hostname port:(guint16)port
{
	GNetworkAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_network_address_new([hostname UTF8String], port), GNetworkAddress, GNetworkAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGNetworkAddress* wrapperObject;
	@try {
		wrapperObject = [[OGNetworkAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)networkAddressLoopback:(guint16)port
{
	GNetworkAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_network_address_new_loopback(port), GNetworkAddress, GNetworkAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGNetworkAddress* wrapperObject;
	@try {
		wrapperObject = [[OGNetworkAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
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
	guint16 returnValue = (guint16)g_network_address_get_port([self castedGObject]);

	return returnValue;
}

- (OFString*)scheme
{
	const gchar* gobjectValue = g_network_address_get_scheme([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}


@end