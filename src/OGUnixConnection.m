/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixConnection.h"

#import "OGCredentials.h"
#import "OGCancellable.h"

@implementation OGUnixConnection

- (GUnixConnection*)castedGObject
{
	return G_UNIX_CONNECTION([self gObject]);
}

- (OGCredentials*)receiveCredentials:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GCredentials* gobjectValue = G_CREDENTIALS(g_unix_connection_receive_credentials([self castedGObject], [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGCredentials* returnValue = [OGCredentials wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)receiveCredentialsAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_unix_connection_receive_credentials_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (OGCredentials*)receiveCredentialsFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GCredentials* gobjectValue = G_CREDENTIALS(g_unix_connection_receive_credentials_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGCredentials* returnValue = [OGCredentials wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (gint)receiveFd:(OGCancellable*)cancellable
{
	GError* err = NULL;

	gint returnValue = g_unix_connection_receive_fd([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)sendCredentials:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_unix_connection_send_credentials([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)sendCredentialsAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_unix_connection_send_credentials_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)sendCredentialsFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_unix_connection_send_credentials_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)sendFdWithFd:(gint)fd cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_unix_connection_send_fd([self castedGObject], fd, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end