/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddress.h"

@implementation OGSocketAddress

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_ADDRESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SOCKET_ADDRESS);
	return gObjectClass;
}

+ (instancetype)socketAddressFromNative:(gpointer)native len:(gsize)len
{
	GSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_address_new_from_native(native, len), G_TYPE_SOCKET_ADDRESS, GSocketAddress);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSocketAddress* wrapperObject;
	@try {
		wrapperObject = [[OGSocketAddress alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSocketAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SOCKET_ADDRESS, GSocketAddress);
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = (GSocketFamily)g_socket_address_get_family((GSocketAddress*)[self castedGObject]);

	return returnValue;
}

- (gssize)nativeSize
{
	gssize returnValue = (gssize)g_socket_address_get_native_size((GSocketAddress*)[self castedGObject]);

	return returnValue;
}

- (bool)toNativeWithDest:(gpointer)dest destlen:(gsize)destlen
{
	GError* err = NULL;

	bool returnValue = (bool)g_socket_address_to_native((GSocketAddress*)[self castedGObject], dest, destlen, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end