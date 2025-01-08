/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNativeSocketAddress.h"

@implementation OGNativeSocketAddress

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_NATIVE_SOCKET_ADDRESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithNative:(gpointer)native len:(gsize)len
{
	GNativeSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_native_socket_address_new(native, len), GNativeSocketAddress, GNativeSocketAddress);

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

- (GNativeSocketAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GNativeSocketAddress, GNativeSocketAddress);
}


@end