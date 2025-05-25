/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNativeSocketAddress.h"

@implementation OGNativeSocketAddress

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_NATIVE_SOCKET_ADDRESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_NATIVE_SOCKET_ADDRESS);
	return gObjectClass;
}

+ (instancetype)nativeSocketAddressWithNative:(gpointer)native len:(gsize)len
{
	GNativeSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_native_socket_address_new(native, len), G_TYPE_NATIVE_SOCKET_ADDRESS, GNativeSocketAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGNativeSocketAddress* wrapperObject;
	@try {
		wrapperObject = [[OGNativeSocketAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GNativeSocketAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_NATIVE_SOCKET_ADDRESS, GNativeSocketAddress);
}


@end