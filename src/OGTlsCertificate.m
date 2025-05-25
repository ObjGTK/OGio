/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsCertificate.h"

@implementation OGTlsCertificate

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_CERTIFICATE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_TLS_CERTIFICATE);
	return gObjectClass;
}

+ (GList*)listNewFromFile:(OFString*)file
{
	GError* err = NULL;

	GList* returnValue = (GList*)g_tls_certificate_list_new_from_file([file UTF8String], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

+ (instancetype)tlsCertificateFromFile:(OFString*)file
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_file([file UTF8String], &err), G_TYPE_TLS_CERTIFICATE, GTlsCertificate);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* wrapperObject;
	@try {
		wrapperObject = [[OGTlsCertificate alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)tlsCertificateFromFileWithPassword:(OFString*)file password:(OFString*)password
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_file_with_password([file UTF8String], [password UTF8String], &err), G_TYPE_TLS_CERTIFICATE, GTlsCertificate);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* wrapperObject;
	@try {
		wrapperObject = [[OGTlsCertificate alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)tlsCertificateFromFilesWithCertFile:(OFString*)certFile keyFile:(OFString*)keyFile
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_files([certFile UTF8String], [keyFile UTF8String], &err), G_TYPE_TLS_CERTIFICATE, GTlsCertificate);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* wrapperObject;
	@try {
		wrapperObject = [[OGTlsCertificate alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)tlsCertificateFromPemWithData:(OFString*)data length:(gssize)length
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_pem([data UTF8String], length, &err), G_TYPE_TLS_CERTIFICATE, GTlsCertificate);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* wrapperObject;
	@try {
		wrapperObject = [[OGTlsCertificate alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)tlsCertificateFromPkcs11Uris:(OFString*)pkcs11Uri privateKeyPkcs11Uri:(OFString*)privateKeyPkcs11Uri
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_pkcs11_uris([pkcs11Uri UTF8String], [privateKeyPkcs11Uri UTF8String], &err), G_TYPE_TLS_CERTIFICATE, GTlsCertificate);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* wrapperObject;
	@try {
		wrapperObject = [[OGTlsCertificate alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)tlsCertificateFromPkcs12WithData:(const guint8*)data length:(gsize)length password:(OFString*)password
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_pkcs12(data, length, [password UTF8String], &err), G_TYPE_TLS_CERTIFICATE, GTlsCertificate);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGTlsCertificate* wrapperObject;
	@try {
		wrapperObject = [[OGTlsCertificate alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GTlsCertificate*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_TLS_CERTIFICATE, GTlsCertificate);
}

- (GPtrArray*)dnsNames
{
	GPtrArray* returnValue = (GPtrArray*)g_tls_certificate_get_dns_names((GTlsCertificate*)[self castedGObject]);

	return returnValue;
}

- (GPtrArray*)ipAddresses
{
	GPtrArray* returnValue = (GPtrArray*)g_tls_certificate_get_ip_addresses((GTlsCertificate*)[self castedGObject]);

	return returnValue;
}

- (OGTlsCertificate*)issuer
{
	GTlsCertificate* gobjectValue = g_tls_certificate_get_issuer((GTlsCertificate*)[self castedGObject]);

	OGTlsCertificate* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OFString*)issuerName
{
	gchar* gobjectValue = g_tls_certificate_get_issuer_name((GTlsCertificate*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (GDateTime*)notValidAfter
{
	GDateTime* returnValue = (GDateTime*)g_tls_certificate_get_not_valid_after((GTlsCertificate*)[self castedGObject]);

	return returnValue;
}

- (GDateTime*)notValidBefore
{
	GDateTime* returnValue = (GDateTime*)g_tls_certificate_get_not_valid_before((GTlsCertificate*)[self castedGObject]);

	return returnValue;
}

- (OFString*)subjectName
{
	gchar* gobjectValue = g_tls_certificate_get_subject_name((GTlsCertificate*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (bool)isSameWithCertTwo:(OGTlsCertificate*)certTwo
{
	bool returnValue = (bool)g_tls_certificate_is_same((GTlsCertificate*)[self castedGObject], [certTwo castedGObject]);

	return returnValue;
}

- (GTlsCertificateFlags)verifyWithIdentity:(GSocketConnectable*)identity trustedCa:(OGTlsCertificate*)trustedCa
{
	GTlsCertificateFlags returnValue = (GTlsCertificateFlags)g_tls_certificate_verify((GTlsCertificate*)[self castedGObject], identity, [trustedCa castedGObject]);

	return returnValue;
}


@end