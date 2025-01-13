/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsInteraction.h"

#import "OGCancellable.h"
#import "OGTlsConnection.h"
#import "OGTlsPassword.h"

@implementation OGTlsInteraction

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_INTERACTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GTlsInteraction*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTlsInteraction, GTlsInteraction);
}

- (GTlsInteractionResult)askPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = (GTlsInteractionResult)g_tls_interaction_ask_password([self castedGObject], [password castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)askPasswordAsync:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_interaction_ask_password_async([self castedGObject], [password castedGObject], [cancellable castedGObject], callback, userData);
}

- (GTlsInteractionResult)askPasswordFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = (GTlsInteractionResult)g_tls_interaction_ask_password_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GTlsInteractionResult)invokeAskPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = (GTlsInteractionResult)g_tls_interaction_invoke_ask_password([self castedGObject], [password castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GTlsInteractionResult)invokeRequestCertificateWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = (GTlsInteractionResult)g_tls_interaction_invoke_request_certificate([self castedGObject], [connection castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GTlsInteractionResult)requestCertificateWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = (GTlsInteractionResult)g_tls_interaction_request_certificate([self castedGObject], [connection castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)requestCertificateAsyncWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_interaction_request_certificate_async([self castedGObject], [connection castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GTlsInteractionResult)requestCertificateFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsInteractionResult returnValue = (GTlsInteractionResult)g_tls_interaction_request_certificate_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end