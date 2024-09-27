/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddressEnumerator.h"

#import "OGSocketAddress.h"
#import "OGCancellable.h"

@implementation OGSocketAddressEnumerator

- (GSocketAddressEnumerator*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketAddressEnumerator, GSocketAddressEnumerator);
}

- (OGSocketAddress*)next:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_address_enumerator_next([self castedGObject], [cancellable castedGObject], &err), GSocketAddress, GSocketAddress);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketAddress* returnValue = [OGSocketAddress withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)nextAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_socket_address_enumerator_next_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (OGSocketAddress*)nextFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_socket_address_enumerator_next_finish([self castedGObject], result, &err), GSocketAddress, GSocketAddress);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGSocketAddress* returnValue = [OGSocketAddress withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}


@end