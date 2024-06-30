/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixoutputstream.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

/**
 * #GMenuAttributeIter is an opaque structure type.  You must access it
 * using the functions below.
 *
 */
@interface OGMenuAttributeIter : OGObject
{

}


/**
 * Methods
 */

- (GMenuAttributeIter*)castedGObject;

/**
 * Gets the name of the attribute at the current iterator position, as
 * a string.
 * 
 * The iterator is not advanced.
 *
 * @return the name of the attribute
 */
- (OFString*)name;

/**
 * This function combines g_menu_attribute_iter_next() with
 * g_menu_attribute_iter_get_name() and g_menu_attribute_iter_get_value().
 * 
 * First the iterator is advanced to the next (possibly first) attribute.
 * If that fails, then %FALSE is returned and there are no other
 * effects.
 * 
 * If successful, @name and @value are set to the name and value of the
 * attribute that has just been advanced to.  At this point,
 * g_menu_attribute_iter_get_name() and g_menu_attribute_iter_get_value() will
 * return the same values again.
 * 
 * The value returned in @name remains valid for as long as the iterator
 * remains at the current position.  The value returned in @value must
 * be unreffed using g_variant_unref() when it is no longer in use.
 *
 * @param outName the type of the attribute
 * @param value the attribute value
 * @return %TRUE on success, or %FALSE if there is no additional
 *     attribute
 */
- (bool)nextWithOutName:(const gchar**)outName value:(GVariant**)value;

/**
 * Gets the value of the attribute at the current iterator position.
 * 
 * The iterator is not advanced.
 *
 * @return the value of the current attribute
 */
- (GVariant*)value;

/**
 * Attempts to advance the iterator to the next (possibly first)
 * attribute.
 * 
 * %TRUE is returned on success, or %FALSE if there are no more
 * attributes.
 * 
 * You must call this function when you first acquire the iterator
 * to advance it to the first attribute (and determine if the first
 * attribute exists at all).
 *
 * @return %TRUE on success, or %FALSE when there are no more attributes
 */
- (bool)next;

@end