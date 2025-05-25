/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixConnection.h"

#import "OGCancellable.h"
#import "OGCredentials.h"

@implementation OGUnixConnection

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_UNIX_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_UNIX_CONNECTION);
	return gObjectClass;
}

- (GUnixConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_UNIX_CONNECTION, GUnixConnection);
}

- (OGCredentials*)receiveCredentialsWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GCredentials* gobjectValue = g_unix_connection_receive_credentials((GUnixConnection*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGCredentials* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)receiveCredentialsAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_unix_connection_receive_credentials_async((GUnixConnection*)[self castedGObject], [cancellable castedGObject], callback, userData);
}

- (OGCredentials*)receiveCredentialsFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GCredentials* gobjectValue = g_unix_connection_receive_credentials_finish((GUnixConnection*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGCredentials* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (gint)receiveFdWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint returnValue = (gint)g_unix_connection_receive_fd((GUnixConnection*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)sendCredentialsWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_unix_connection_send_credentials((GUnixConnection*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)sendCredentialsAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_unix_connection_send_credentials_async((GUnixConnection*)[self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)sendCredentialsFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_unix_connection_send_credentials_finish((GUnixConnection*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)sendFd:(gint)fd cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_unix_connection_send_fd((GUnixConnection*)[self castedGObject], fd, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end