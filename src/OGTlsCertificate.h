/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>

#import <OGObject/OGObject.h>

/**
 * A certificate used for TLS authentication and encryption.
 * This can represent either a certificate only (eg, the certificate
 * received by a client from a server), or the combination of
 * a certificate and a private key (which is needed when acting as a
 * [iface@Gio.TlsServerConnection]).
 *
 */
@interface OGTlsCertificate : OGObject
{

}

/**
 * Functions
 */

/**
 * Creates one or more #GTlsCertificates from the PEM-encoded
 * data in @file. If @file cannot be read or parsed, the function will
 * return %NULL and set @error. If @file does not contain any
 * PEM-encoded certificates, this will return an empty list and not
 * set @error.
 *
 * @param file file containing PEM-encoded certificates to import
 * @return a
 * #GList containing #GTlsCertificate objects. You must free the list
 * and its contents when you are done with it.
 */
+ (GList*)listNewFromFile:(OFString*)file;

/**
 * Constructors
 */
- (instancetype)initFromFile:(OFString*)file;
- (instancetype)initFromFileWithPasswordWithFile:(OFString*)file password:(OFString*)password;
- (instancetype)initFromFilesWithCertFile:(OFString*)certFile keyFile:(OFString*)keyFile;
- (instancetype)initFromPemWithData:(OFString*)data length:(gssize)length;
- (instancetype)initFromPkcs11UrisWithPkcs11Uri:(OFString*)pkcs11Uri privateKeyPkcs11Uri:(OFString*)privateKeyPkcs11Uri;
- (instancetype)initFromPkcs12WithData:(const guint8*)data length:(gsize)length password:(OFString*)password;

/**
 * Methods
 */

- (GTlsCertificate*)castedGObject;

/**
 * Gets the value of #GTlsCertificate:dns-names.
 *
 * @return A #GPtrArray of
 * #GBytes elements, or %NULL if it's not available.
 */
- (GPtrArray*)dnsNames;

/**
 * Gets the value of #GTlsCertificate:ip-addresses.
 *
 * @return A #GPtrArray
 * of #GInetAddress elements, or %NULL if it's not available.
 */
- (GPtrArray*)ipAddresses;

/**
 * Gets the #GTlsCertificate representing @cert's issuer, if known
 *
 * @return The certificate of @cert's issuer,
 * or %NULL if @cert is self-signed or signed with an unknown
 * certificate.
 */
- (OGTlsCertificate*)issuer;

/**
 * Returns the issuer name from the certificate.
 *
 * @return The issuer name, or %NULL if it's not available.
 */
- (OFString*)issuerName;

/**
 * Returns the time at which the certificate became or will become invalid.
 *
 * @return The not-valid-after date, or %NULL if it's not available.
 */
- (GDateTime*)notValidAfter;

/**
 * Returns the time at which the certificate became or will become valid.
 *
 * @return The not-valid-before date, or %NULL if it's not available.
 */
- (GDateTime*)notValidBefore;

/**
 * Returns the subject name from the certificate.
 *
 * @return The subject name, or %NULL if it's not available.
 */
- (OFString*)subjectName;

/**
 * Check if two #GTlsCertificate objects represent the same certificate.
 * The raw DER byte data of the two certificates are checked for equality.
 * This has the effect that two certificates may compare equal even if
 * their #GTlsCertificate:issuer, #GTlsCertificate:private-key, or
 * #GTlsCertificate:private-key-pem properties differ.
 *
 * @param certTwo second certificate to compare
 * @return whether the same or not
 */
- (bool)isSame:(OGTlsCertificate*)certTwo;

/**
 * This verifies @cert and returns a set of #GTlsCertificateFlags
 * indicating any problems found with it. This can be used to verify a
 * certificate outside the context of making a connection, or to
 * check a certificate against a CA that is not part of the system
 * CA database.
 * 
 * If @cert is valid, %G_TLS_CERTIFICATE_NO_FLAGS is returned.
 * 
 * If @identity is not %NULL, @cert's name(s) will be compared against
 * it, and %G_TLS_CERTIFICATE_BAD_IDENTITY will be set in the return
 * value if it does not match. If @identity is %NULL, that bit will
 * never be set in the return value.
 * 
 * If @trusted_ca is not %NULL, then @cert (or one of the certificates
 * in its chain) must be signed by it, or else
 * %G_TLS_CERTIFICATE_UNKNOWN_CA will be set in the return value. If
 * @trusted_ca is %NULL, that bit will never be set in the return
 * value.
 * 
 * GLib guarantees that if certificate verification fails, at least one
 * error will be set in the return value, but it does not guarantee
 * that all possible errors will be set. Accordingly, you may not safely
 * decide to ignore any particular type of error. For example, it would
 * be incorrect to mask %G_TLS_CERTIFICATE_EXPIRED if you want to allow
 * expired certificates, because this could potentially be the only
 * error flag set even if other problems exist with the certificate.
 * 
 * Because TLS session context is not used, #GTlsCertificate may not
 * perform as many checks on the certificates as #GTlsConnection would.
 * For example, certificate constraints may not be honored, and
 * revocation checks may not be performed. The best way to verify TLS
 * certificates used by a TLS connection is to let #GTlsConnection
 * handle the verification.
 *
 * @param identity the expected peer identity
 * @param trustedCa the certificate of a trusted authority
 * @return the appropriate #GTlsCertificateFlags
 */
- (GTlsCertificateFlags)verifyWithIdentity:(GSocketConnectable*)identity trustedCa:(OGTlsCertificate*)trustedCa;

@end