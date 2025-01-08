/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSocketAddressEnumerator.h"

#import "OGCancellable.h"
#import "OGSocketAddress.h"

@implementation OGSocketAddressEnumerator

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SOCKET_ADDRESS_ENUMERATOR;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GSocketAddressEnumerator*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSocketAddressEnumerator, GSocketAddressEnumerator);
}

- (OGSocketAddress*)next:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GSocketAddress* gobjectValue = g_socket_address_enumerator_next([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
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

	GSocketAddress* gobjectValue = g_socket_address_enumerator_next_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSocketAddress* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}


@end