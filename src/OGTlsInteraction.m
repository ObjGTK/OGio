/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsInteraction.h"

#import "OGCancellable.h"
#import "OGTlsConnection.h"
#import "OGTlsPassword.h"

@implementation OGTlsInteraction

- (GTlsInteraction*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTlsInteraction, GTlsInteraction);
}

- (GTlsInteractionResult)askPasswordWithPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = g_tls_interaction_ask_password([self castedGObject], [password castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)askPasswordAsyncWithPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_interaction_ask_password_async([self castedGObject], [password castedGObject], [cancellable castedGObject], callback, userData);
}

- (GTlsInteractionResult)askPasswordFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = g_tls_interaction_ask_password_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GTlsInteractionResult)invokeAskPasswordWithPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = g_tls_interaction_invoke_ask_password([self castedGObject], [password castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GTlsInteractionResult)invokeRequestCertificateWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = g_tls_interaction_invoke_request_certificate([self castedGObject], [connection castedGObject], flags, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GTlsInteractionResult)requestCertificateWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = g_tls_interaction_request_certificate([self castedGObject], [connection castedGObject], flags, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)requestCertificateAsyncWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_interaction_request_certificate_async([self castedGObject], [connection castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GTlsInteractionResult)requestCertificateFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = g_tls_interaction_request_certificate_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end