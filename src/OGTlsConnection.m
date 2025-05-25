/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsConnection.h"

#import "OGCancellable.h"
#import "OGTlsCertificate.h"
#import "OGTlsDatabase.h"
#import "OGTlsInteraction.h"

@implementation OGTlsConnection

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_TLS_CONNECTION);
	return gObjectClass;
}

- (GTlsConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_TLS_CONNECTION, GTlsConnection);
}

- (bool)emitAcceptCertificateWithPeerCert:(OGTlsCertificate*)peerCert errors:(GTlsCertificateFlags)errors
{
	bool returnValue = (bool)g_tls_connection_emit_accept_certificate((GTlsConnection*)[self castedGObject], [peerCert castedGObject], errors);

	return returnValue;
}

- (OGTlsCertificate*)certificate
{
	GTlsCertificate* gobjectValue = g_tls_connection_get_certificate((GTlsConnection*)[self castedGObject]);

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)channelBindingDataWithType:(GTlsChannelBindingType)type data:(GByteArray*)data
{
	GError* err = NULL;

	bool returnValue = (bool)g_tls_connection_get_channel_binding_data((GTlsConnection*)[self castedGObject], type, data, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OFString*)ciphersuiteName
{
	gchar* gobjectValue = g_tls_connection_get_ciphersuite_name((GTlsConnection*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OGTlsDatabase*)database
{
	GTlsDatabase* gobjectValue = g_tls_connection_get_database((GTlsConnection*)[self castedGObject]);

	OGTlsDatabase* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGTlsInteraction*)interaction
{
	GTlsInteraction* gobjectValue = g_tls_connection_get_interaction((GTlsConnection*)[self castedGObject]);

	OGTlsInteraction* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OFString*)negotiatedProtocol
{
	const gchar* gobjectValue = g_tls_connection_get_negotiated_protocol((GTlsConnection*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OGTlsCertificate*)peerCertificate
{
	GTlsCertificate* gobjectValue = g_tls_connection_get_peer_certificate((GTlsConnection*)[self castedGObject]);

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GTlsCertificateFlags)peerCertificateErrors
{
	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_connection_get_peer_certificate_errors((GTlsConnection*)[self castedGObject]);

	return returnValue;
}

- (GTlsProtocolVersion)protocolVersion
{
	GTlsProtocolVersion returnValue = (GTlsProtocolVersion)g_tls_connection_get_protocol_version((GTlsConnection*)[self castedGObject]);

	return returnValue;
}

- (GTlsRehandshakeMode)rehandshakeMode
{
	GTlsRehandshakeMode returnValue = (GTlsRehandshakeMode)g_tls_connection_get_rehandshake_mode((GTlsConnection*)[self castedGObject]);

	return returnValue;
}

- (bool)requireCloseNotify
{
	bool returnValue = (bool)g_tls_connection_get_require_close_notify((GTlsConnection*)[self castedGObject]);

	return returnValue;
}

- (bool)useSystemCertdb
{
	bool returnValue = (bool)g_tls_connection_get_use_system_certdb((GTlsConnection*)[self castedGObject]);

	return returnValue;
}

- (bool)handshakeWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_tls_connection_handshake((GTlsConnection*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)handshakeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_connection_handshake_async((GTlsConnection*)[self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)handshakeFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_tls_connection_handshake_finish((GTlsConnection*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setAdvertisedProtocols:(const gchar* const*)protocols
{
	g_tls_connection_set_advertised_protocols((GTlsConnection*)[self castedGObject], protocols);
}

- (void)setCertificate:(OGTlsCertificate*)certificate
{
	g_tls_connection_set_certificate((GTlsConnection*)[self castedGObject], [certificate castedGObject]);
}

- (void)setDatabase:(OGTlsDatabase*)database
{
	g_tls_connection_set_database((GTlsConnection*)[self castedGObject], [database castedGObject]);
}

- (void)setInteraction:(OGTlsInteraction*)interaction
{
	g_tls_connection_set_interaction((GTlsConnection*)[self castedGObject], [interaction castedGObject]);
}

- (void)setRehandshakeMode:(GTlsRehandshakeMode)mode
{
	g_tls_connection_set_rehandshake_mode((GTlsConnection*)[self castedGObject], mode);
}

- (void)setRequireCloseNotify:(bool)requireCloseNotify
{
	g_tls_connection_set_require_close_notify((GTlsConnection*)[self castedGObject], requireCloseNotify);
}

- (void)setUseSystemCertdb:(bool)useSystemCertdb
{
	g_tls_connection_set_use_system_certdb((GTlsConnection*)[self castedGObject], useSystemCertdb);
}


@end