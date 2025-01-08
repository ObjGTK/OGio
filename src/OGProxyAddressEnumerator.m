/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGProxyAddressEnumerator.h"

@implementation OGProxyAddressEnumerator

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_PROXY_ADDRESS_ENUMERATOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GProxyAddressEnumerator*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GProxyAddressEnumerator, GProxyAddressEnumerator);
}


@end