/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNativeSocketAddress.h"

@implementation OGNativeSocketAddress

- (instancetype)initWithNative:(gpointer)native len:(gsize)len
{
	GNativeSocketAddress* gobjectValue = G_NATIVE_SOCKET_ADDRESS(g_native_socket_address_new(native, len));

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
	return G_NATIVE_SOCKET_ADDRESS([self gObject]);
}


@end