/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNetworkService.h"

@implementation OGNetworkService

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_NETWORK_SERVICE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_NETWORK_SERVICE);
	return gObjectClass;
}

+ (instancetype)networkServiceWithService:(OFString*)service protocol:(OFString*)protocol domain:(OFString*)domain
{
	GNetworkService* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_network_service_new([service UTF8String], [protocol UTF8String], [domain UTF8String]), G_TYPE_NETWORK_SERVICE, GNetworkService);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGNetworkService* wrapperObject;
	@try {
		wrapperObject = [[OGNetworkService alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GNetworkService*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_NETWORK_SERVICE, GNetworkService);
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