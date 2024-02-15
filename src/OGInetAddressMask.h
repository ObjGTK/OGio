/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

@class OGInetAddress;

/**
 * #GInetAddressMask represents a range of IPv4 or IPv6 addresses
 * described by a base address and a length indicating how many bits
 * of the base address are relevant for matching purposes. These are
 * often given in string form. Eg, "10.0.0.0/8", or "fe80::/10".
 *
 */
@interface OGInetAddressMask : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initWithAddr:(OGInetAddress*)addr length:(guint)length;
- (instancetype)initFromString:(OFString*)maskString;

/**
 * Methods
 */

- (GInetAddressMask*)castedGObject;

/**
 * Tests if @mask and @mask2 are the same mask.
 *
 * @param mask2 another #GInetAddressMask
 * @return whether @mask and @mask2 are the same mask
 */
- (bool)equal:(OGInetAddressMask*)mask2;

/**
 * Gets @mask's base address
 *
 * @return @mask's base address
 */
- (OGInetAddress*)address;

/**
 * Gets the #GSocketFamily of @mask's address
 *
 * @return the #GSocketFamily of @mask's address
 */
- (GSocketFamily)family;

/**
 * Gets @mask's length
 *
 * @return @mask's length
 */
- (guint)length;

/**
 * Tests if @address falls within the range described by @mask.
 *
 * @param address a #GInetAddress
 * @return whether @address falls within the range described by
 * @mask.
 */
- (bool)matches:(OGInetAddress*)address;

/**
 * Converts @mask back to its corresponding string form.
 *
 * @return a string corresponding to @mask.
 */
- (OFString*)toString;

@end