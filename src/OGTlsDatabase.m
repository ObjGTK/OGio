/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsDatabase.h"

#import "OGTlsInteraction.h"
#import "OGTlsCertificate.h"
#import "OGCancellable.h"

@implementation OGTlsDatabase

- (GTlsDatabase*)castedGObject
{
	return G_TLS_DATABASE([self gObject]);
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

	GTlsCertificate* gobjectValue = G_TLS_CERTIFICATE(g_tls_database_lookup_certificate_for_handle([self castedGObject], [handle UTF8String], [interaction castedGObject], flags, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGTlsCertificate* returnValue = [OGTlsCertificate withGObject:gobjectValue];
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

	GTlsCertificate* gobjectValue = G_TLS_CERTIFICATE(g_tls_database_lookup_certificate_for_handle_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGTlsCertificate* returnValue = [OGTlsCertificate withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGTlsCertificate*)lookupCertificateIssuerWithCertificate:(OGTlsCertificate*)certificate interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TLS_CERTIFICATE(g_tls_database_lookup_certificate_issuer([self castedGObject], [certificate castedGObject], [interaction castedGObject], flags, [cancellable castedGObject], &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGTlsCertificate* returnValue = [OGTlsCertificate withGObject:gobjectValue];
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

	GTlsCertificate* gobjectValue = G_TLS_CERTIFICATE(g_tls_database_lookup_certificate_issuer_finish([self castedGObject], result, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	OGTlsCertificate* returnValue = [OGTlsCertificate withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GList*)lookupCertificatesIssuedByWithIssuerRawDn:(GByteArray*)issuerRawDn interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = g_tls_database_lookup_certificates_issued_by([self castedGObject], issuerRawDn, [interaction castedGObject], flags, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)lookupCertificatesIssuedByAsyncWithIssuerRawDn:(GByteArray*)issuerRawDn interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificates_issued_by_async([self castedGObject], issuerRawDn, [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GList*)lookupCertificatesIssuedByFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = g_tls_database_lookup_certificates_issued_by_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (GTlsCertificateFlags)verifyChainWithChain:(OGTlsCertificate*)chain purpose:(OFString*)purpose identity:(GSocketConnectable*)identity interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseVerifyFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificateFlags returnValue = g_tls_database_verify_chain([self castedGObject], [chain castedGObject], [purpose UTF8String], identity, [interaction castedGObject], flags, [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)verifyChainAsyncWithChain:(OGTlsCertificate*)chain purpose:(OFString*)purpose identity:(GSocketConnectable*)identity interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseVerifyFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_verify_chain_async([self castedGObject], [chain castedGObject], [purpose UTF8String], identity, [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GTlsCertificateFlags)verifyChainFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificateFlags returnValue = g_tls_database_verify_chain_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end