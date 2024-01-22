/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNetworkService.h"

@implementation OGNetworkService

- (instancetype)initWithService:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain
{
	GNetworkService* gobjectValue = G_NETWORK_SERVICE(g_network_service_new([service UTF8String], [protocol UTF8String], [domain UTF8String]));

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

- (GNetworkService*)castedGObject
{
	return G_NETWORK_SERVICE([self gObject]);
}

- (OFString*)domain
{
	const gchar* gobjectValue = g_network_service_get_domain([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)protocol
{
	const gchar* gobjectValue = g_network_service_get_protocol([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)scheme
{
	const gchar* gobjectValue = g_network_service_get_scheme([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)service
{
	const gchar* gobjectValue = g_network_service_get_service([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setScheme:(OFString*)scheme
{
	g_network_service_set_scheme([self castedGObject], [scheme UTF8String]);
}


@end