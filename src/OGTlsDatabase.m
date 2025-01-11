/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsDatabase.h"

#import "OGCancellable.h"
#import "OGTlsCertificate.h"
#import "OGTlsInteraction.h"

@implementation OGTlsDatabase

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_DATABASE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GTlsDatabase*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTlsDatabase, GTlsDatabase);
}

- (OFString*)createCertificateHandle:(OGTlsCertificate*)certificate
{
	gchar* gobjectValue = g_tls_database_create_certificate_handle([self castedGObject], [certificate castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OGTlsCertificate*)lookupCertificateForHandleWithHandle:(OFString*)handle interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_for_handle([self castedGObject], [handle UTF8String], [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)lookupCertificateForHandleAsyncWithHandle:(OFString*)handle interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificate_for_handle_async([self castedGObject], [handle UTF8String], [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (OGTlsCertificate*)lookupCertificateForHandleFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_for_handle_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGTlsCertificate*)lookupCertificateIssuerWithCertificate:(OGTlsCertificate*)certificate interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_issuer([self castedGObject], [certificate castedGObject], [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)lookupCertificateIssuerAsyncWithCertificate:(OGTlsCertificate*)certificate interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificate_issuer_async([self castedGObject], [certificate castedGObject], [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (OGTlsCertificate*)lookupCertificateIssuerFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_issuer_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GList*)lookupCertificatesIssuedByWithIssuerRawDn:(GByteArray*)issuerRawDn interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = (GList*)g_tls_database_lookup_certificates_issued_by([self castedGObject], issuerRawDn, [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)lookupCertificatesIssuedByAsyncWithIssuerRawDn:(GByteArray*)issuerRawDn interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificates_issued_by_async([self castedGObject], issuerRawDn, [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GList*)lookupCertificatesIssuedByFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = (GList*)g_tls_database_lookup_certificates_issued_by_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GTlsCertificateFlags)verifyChainWithChain:(OGTlsCertificate*)chain purpose:(OFString*)purpose identity:(GSocketConnectable*)identity interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseVerifyFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_database_verify_chain([self castedGObject], [chain castedGObject], [purpose UTF8String], identity, [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)verifyChainAsyncWithChain:(OGTlsCertificate*)chain purpose:(OFString*)purpose identity:(GSocketConnectable*)identity interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseVerifyFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_verify_chain_async([self castedGObject], [chain castedGObject], [purpose UTF8String], identity, [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GTlsCertificateFlags)verifyChainFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_database_verify_chain_finish([self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end