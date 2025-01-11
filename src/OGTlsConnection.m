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

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_CONNECTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GTlsConnection*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTlsConnection, GTlsConnection);
}

- (bool)emitAcceptCertificateWithPeerCert:(OGTlsCertificate*)peerCert errors:(GTlsCertificateFlags)errors
{
	bool returnValue = (bool)g_tls_connection_emit_accept_certificate([self castedGObject], [peerCert castedGObject], errors);

	return returnValue;
}

- (OGTlsCertificate*)certificate
{
	GTlsCertificate* gobjectValue = g_tls_connection_get_certificate([self castedGObject]);

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)channelBindingDataWithType:(GTlsChannelBindingType)type data:(GByteArray*)data
{
	GError* err = NULL;

	bool returnValue = (bool)g_tls_connection_get_channel_binding_data([self castedGObject], type, data, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (OFString*)ciphersuiteName
{
	gchar* gobjectValue = g_tls_connection_get_ciphersuite_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OGTlsDatabase*)database
{
	GTlsDatabase* gobjectValue = g_tls_connection_get_database([self castedGObject]);

	OGTlsDatabase* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGTlsInteraction*)interaction
{
	GTlsInteraction* gobjectValue = g_tls_connection_get_interaction([self castedGObject]);

	OGTlsInteraction* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OFString*)negotiatedProtocol
{
	const gchar* gobjectValue = g_tls_connection_get_negotiated_protocol([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OGTlsCertificate*)peerCertificate
{
	GTlsCertificate* gobjectValue = g_tls_connection_get_peer_certificate([self castedGObject]);

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (GTlsCertificateFlags)peerCertificateErrors
{
	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_connection_get_peer_certificate_errors([self castedGObject]);

	return returnValue;
}

- (GTlsProtocolVersion)protocolVersion
{
	GTlsProtocolVersion returnValue = (GTlsProtocolVersion)g_tls_connection_get_protocol_version([self castedGObject]);

	return returnValue;
}

- (GTlsRehandshakeMode)rehandshakeMode
{
	GTlsRehandshakeMode returnValue = (GTlsRehandshakeMode)g_tls_connection_get_rehandshake_mode([self castedGObject]);

	return returnValue;
}

- (bool)requireCloseNotify
{
	bool returnValue = (bool)g_tls_connection_get_require_close_notify([self castedGObject]);

	return returnValue;
}

- (bool)useSystemCertdb
{
	bool returnValue = (bool)g_tls_connection_get_use_system_certdb([self castedGObject]);

	return returnValue;
}

- (bool)handshake:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_tls_connection_handshake([self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)handshakeAsyncWithIoPriority:(int)ioPriority cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_connection_handshake_async([self castedGObject], ioPriority, [cancellable castedGObject], callback, userData);
}

- (bool)handshakeFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_tls_connection_handshake_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)setAdvertisedProtocols:(const gchar* const*)protocols
{
	g_tls_connection_set_advertised_protocols([self castedGObject], protocols);
}

- (void)setCertificate:(OGTlsCertificate*)certificate
{
	g_tls_connection_set_certificate([self castedGObject], [certificate castedGObject]);
}

- (void)setDatabase:(OGTlsDatabase*)database
{
	g_tls_connection_set_database([self castedGObject], [database castedGObject]);
}

- (void)setInteraction:(OGTlsInteraction*)interaction
{
	g_tls_connection_set_interaction([self castedGObject], [interaction castedGObject]);
}

- (void)setRehandshakeMode:(GTlsRehandshakeMode)mode
{
	g_tls_connection_set_rehandshake_mode([self castedGObject], mode);
}

- (void)setRequireCloseNotify:(bool)requireCloseNotify
{
	g_tls_connection_set_require_close_notify([self castedGObject], requireCloseNotify);
}

- (void)setUseSystemCertdb:(bool)useSystemCertdb
{
	g_tls_connection_set_use_system_certdb([self castedGObject], useSystemCertdb);
}


@end