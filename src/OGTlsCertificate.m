/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsCertificate.h"

@implementation OGTlsCertificate

+ (GList*)listNewFromFile:(OFString*)file
{
	GError* err = NULL;

	GList* returnValue = g_tls_certificate_list_new_from_file([file UTF8String], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (instancetype)initFromFile:(OFString*)file
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_file([file UTF8String], &err), GTlsCertificate, GTlsCertificate);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initFromFileWithPasswordWithFile:(OFString*)file password:(OFString*)password
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_file_with_password([file UTF8String], [password UTF8String], &err), GTlsCertificate, GTlsCertificate);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initFromFilesWithCertFile:(OFString*)certFile keyFile:(OFString*)keyFile
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_files([certFile UTF8String], [keyFile UTF8String], &err), GTlsCertificate, GTlsCertificate);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initFromPemWithData:(OFString*)data length:(gssize)length
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_pem([data UTF8String], length, &err), GTlsCertificate, GTlsCertificate);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initFromPkcs11UrisWithPkcs11Uri:(OFString*)pkcs11Uri privateKeyPkcs11Uri:(OFString*)privateKeyPkcs11Uri
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_pkcs11_uris([pkcs11Uri UTF8String], [privateKeyPkcs11Uri UTF8String], &err), GTlsCertificate, GTlsCertificate);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (instancetype)initFromPkcs12WithData:(const guint8*)data length:(gsize)length password:(OFString*)password
{
	GError* err = NULL;

	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_new_from_pkcs12(data, length, [password UTF8String], &err), GTlsCertificate, GTlsCertificate);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

	@try {
		self = [super initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[self release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return self;
}

- (GTlsCertificate*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTlsCertificate, GTlsCertificate);
}

- (GPtrArray*)dnsNames
{
	GPtrArray* returnValue = g_tls_certificate_get_dns_names([self castedGObject]);

	return returnValue;
}

- (GPtrArray*)ipAddresses
{
	GPtrArray* returnValue = g_tls_certificate_get_ip_addresses([self castedGObject]);

	return returnValue;
}

- (OGTlsCertificate*)issuer
{
	GTlsCertificate* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_certificate_get_issuer([self castedGObject]), GTlsCertificate, GTlsCertificate);

	OGTlsCertificate* returnValue = [OGTlsCertificate withGObject:gobjectValue];
	return returnValue;
}

- (OFString*)issuerName
{
	gchar* gobjectValue = g_tls_certificate_get_issuer_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (GDateTime*)notValidAfter
{
	GDateTime* returnValue = g_tls_certificate_get_not_valid_after([self castedGObject]);

	return returnValue;
}

- (GDateTime*)notValidBefore
{
	GDateTime* returnValue = g_tls_certificate_get_not_valid_before([self castedGObject]);

	return returnValue;
}

- (OFString*)subjectName
{
	gchar* gobjectValue = g_tls_certificate_get_subject_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (bool)isSame:(OGTlsCertificate*)certTwo
{
	bool returnValue = g_tls_certificate_is_same([self castedGObject], [certTwo castedGObject]);

	return returnValue;
}

- (GTlsCertificateFlags)verifyWithIdentity:(GSocketConnectable*)identity trustedCa:(OGTlsCertificate*)trustedCa
{
	GTlsCertificateFlags returnValue = g_tls_certificate_verify([self castedGObject], identity, [trustedCa castedGObject]);

	return returnValue;
}


@end