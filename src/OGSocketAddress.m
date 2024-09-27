/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddress.h"

@implementation OGSocketAddress

- (instancetype)initFromNativeWithNative:(gpointer)native len:(gsize)len
{
	GSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_address_new_from_native(native, len), GSocketAddress, GSocketAddress);

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

- (GSocketAddress*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketAddress, GSocketAddress);
}

- (GSocketFamily)family
{
	GSocketFamily returnValue = g_socket_address_get_family([self castedGObject]);

	return returnValue;
}

- (gssize)nativeSize
{
	gssize returnValue = g_socket_address_get_native_size([self castedGObject]);

	return returnValue;
}

- (bool)toNativeWithDest:(gpointer)dest destlen:(gsize)destlen
{
	GError* err = NULL;

	bool returnValue = g_socket_address_to_native([self castedGObject], dest, destlen, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end