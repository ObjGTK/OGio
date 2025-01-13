/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixfdmessage.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gio.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

/**
 * An abstract interface representing a password used in TLS. Often used in
 * user interaction such as unlocking a key storage token.
 *
 */
@interface OGTlsPassword : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)tlsPasswordWithFlags:(GTlsPasswordFlags)flags description:(OFString*)description;

/**
 * Methods
 */

- (GTlsPassword*)castedGObject;

/**
 * Get a description string about what the password will be used for.
 *
 * @return The description of the password.
 */
- (OFString*)description;

/**
 * Get flags about the password.
 *
 * @return The flags about the password.
 */
- (GTlsPasswordFlags)flags;

/**
 * Get the password value. If @length is not %NULL then it will be
 * filled in with the length of the password value. (Note that the
 * password value is not nul-terminated, so you can only pass %NULL
 * for @length in contexts where you know the password will have a
 * certain fixed length.)
 *
 * @param length location to place the length of the password.
 * @return The password value (owned by the password object).
 */
- (const guchar*)valueWithLength:(gsize*)length;

/**
 * Get a user readable translated warning. Usually this warning is a
 * representation of the password flags returned from
 * g_tls_password_get_flags().
 *
 * @return The warning.
 */
- (OFString*)warning;

/**
 * Set a description string about what the password will be used for.
 *
 * @param description The description of the password
 */
- (void)setDescription:(OFString*)description;

/**
 * Set flags about the password.
 *
 * @param flags The flags about the password
 */
- (void)setFlags:(GTlsPasswordFlags)flags;

/**
 * Set the value for this password. The @value will be copied by the password
 * object.
 * 
 * Specify the @length, for a non-nul-terminated password. Pass -1 as
 * @length if using a nul-terminated password, and @length will be
 * calculated automatically. (Note that the terminating nul is not
 * considered part of the password in this case.)
 *
 * @param value the new password value
 * @param length the length of the password, or -1
 */
- (void)setValue:(const guchar*)value length:(gssize)length;

/**
 * Provide the value for this password.
 * 
 * The @value will be owned by the password object, and later freed using
 * the @destroy function callback.
 * 
 * Specify the @length, for a non-nul-terminated password. Pass -1 as
 * @length if using a nul-terminated password, and @length will be
 * calculated automatically. (Note that the terminating nul is not
 * considered part of the password in this case.)
 *
 * @param value the value for the password
 * @param length the length of the password, or -1
 * @param destroy a function to use to free the password.
 */
- (void)setValueFull:(guchar*)value length:(gssize)length destroy:(GDestroyNotify)destroy;

/**
 * Set a user readable translated warning. Usually this warning is a
 * representation of the password flags returned from
 * g_tls_password_get_flags().
 *
 * @param warning The user readable warning
 */
- (void)setWarning:(OFString*)warning;

@end