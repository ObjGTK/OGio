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

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_DATABASE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_TLS_DATABASE);
	return gObjectClass;
}

- (GTlsDatabase*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_TLS_DATABASE, GTlsDatabase);
}

- (OFString*)createCertificateHandle:(OGTlsCertificate*)certificate
{
	gchar* gobjectValue = g_tls_database_create_certificate_handle((GTlsDatabase*)[self castedGObject], [certificate castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (OGTlsCertificate*)lookupCertificateForHandle:(OFString*)handle interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_for_handle((GTlsDatabase*)[self castedGObject], [handle UTF8String], [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)lookupCertificateForHandleAsync:(OFString*)handle interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificate_for_handle_async((GTlsDatabase*)[self castedGObject], [handle UTF8String], [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (OGTlsCertificate*)lookupCertificateForHandleFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_for_handle_finish((GTlsDatabase*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OGTlsCertificate*)lookupCertificateIssuer:(OGTlsCertificate*)certificate interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_issuer((GTlsDatabase*)[self castedGObject], [certificate castedGObject], [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)lookupCertificateIssuerAsync:(OGTlsCertificate*)certificate interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificate_issuer_async((GTlsDatabase*)[self castedGObject], [certificate castedGObject], [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (OGTlsCertificate*)lookupCertificateIssuerFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = g_tls_database_lookup_certificate_issuer_finish((GTlsDatabase*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GList*)lookupCertificatesIssuedByWithIssuerRawDn:(GByteArray*)issuerRawDn interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GList* returnValue = (GList*)g_tls_database_lookup_certificates_issued_by((GTlsDatabase*)[self castedGObject], issuerRawDn, [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)lookupCertificatesIssuedByAsyncWithIssuerRawDn:(GByteArray*)issuerRawDn interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseLookupFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_lookup_certificates_issued_by_async((GTlsDatabase*)[self castedGObject], issuerRawDn, [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GList*)lookupCertificatesIssuedByFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GList* returnValue = (GList*)g_tls_database_lookup_certificates_issued_by_finish((GTlsDatabase*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (GTlsCertificateFlags)verifyChain:(OGTlsCertificate*)chain purpose:(OFString*)purpose identity:(GSocketConnectable*)identity interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseVerifyFlags)flags cancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_database_verify_chain((GTlsDatabase*)[self castedGObject], [chain castedGObject], [purpose UTF8String], identity, [interaction castedGObject], flags, [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)verifyChainAsync:(OGTlsCertificate*)chain purpose:(OFString*)purpose identity:(GSocketConnectable*)identity interaction:(OGTlsInteraction*)interaction flags:(GTlsDatabaseVerifyFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_tls_database_verify_chain_async((GTlsDatabase*)[self castedGObject], [chain castedGObject], [purpose UTF8String], identity, [interaction castedGObject], flags, [cancellable castedGObject], callback, userData);
}

- (GTlsCertificateFlags)verifyChainFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_database_verify_chain_finish((GTlsDatabase*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end