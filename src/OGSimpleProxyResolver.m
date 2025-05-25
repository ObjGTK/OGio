/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleProxyResolver.h"

@implementation OGSimpleProxyResolver

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_PROXY_RESOLVER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SIMPLE_PROXY_RESOLVER);
	return gObjectClass;
}

+ (GProxyResolver*)newWithDefaultProxy:(OFString*)defaultProxy ignoreHosts:(gchar**)ignoreHosts
{
	GProxyResolver* returnValue = (GProxyResolver*)g_simple_proxy_resolver_new([defaultProxy UTF8String], ignoreHosts);

	return returnValue;
}

- (GSimpleProxyResolver*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SIMPLE_PROXY_RESOLVER, GSimpleProxyResolver);
}

- (void)setDefaultProxy:(OFString*)defaultProxy
{
	g_simple_proxy_resolver_set_default_proxy([self castedGObject], [defaultProxy UTF8String]);
}

- (void)setIgnoreHosts:(gchar**)ignoreHosts
{
	g_simple_proxy_resolver_set_ignore_hosts([self castedGObject], ignoreHosts);
}

- (void)setUriProxyWithUriScheme:(OFString*)uriScheme proxy:(OFString*)proxy
{
	g_simple_proxy_resolver_set_uri_proxy([self castedGObject], [uriScheme UTF8String], [proxy UTF8String]);
}


@end