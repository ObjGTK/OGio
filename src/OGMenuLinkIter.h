/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixmounts.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

@class OGMenuModel;

/**
 * #GMenuLinkIter is an opaque structure type.  You must access it using
 * the functions below.
 *
 */
@interface OGMenuLinkIter : OGObject
{

}


/**
 * Methods
 */

- (GMenuLinkIter*)castedGObject;

/**
 * Gets the name of the link at the current iterator position.
 * 
 * The iterator is not advanced.
 *
 * @return the type of the link
 */
- (OFString*)name;

/**
 * This function combines g_menu_link_iter_next() with
 * g_menu_link_iter_get_name() and g_menu_link_iter_get_value().
 * 
 * First the iterator is advanced to the next (possibly first) link.
 * If that fails, then %FALSE is returned and there are no other effects.
 * 
 * If successful, @out_link and @value are set to the name and #GMenuModel
 * of the link that has just been advanced to.  At this point,
 * g_menu_link_iter_get_name() and g_menu_link_iter_get_value() will return the
 * same values again.
 * 
 * The value returned in @out_link remains valid for as long as the iterator
 * remains at the current position.  The value returned in @value must
 * be unreffed using g_object_unref() when it is no longer in use.
 *
 * @param outLink the name of the link
 * @param value the linked #GMenuModel
 * @return %TRUE on success, or %FALSE if there is no additional link
 */
- (bool)nextWithOutLink:(const gchar**)outLink value:(GMenuModel**)value;

/**
 * Gets the linked #GMenuModel at the current iterator position.
 * 
 * The iterator is not advanced.
 *
 * @return the #GMenuModel that is linked to
 */
- (OGMenuModel*)value;

/**
 * Attempts to advance the iterator to the next (possibly first)
 * link.
 * 
 * %TRUE is returned on success, or %FALSE if there are no more links.
 * 
 * You must call this function when you first acquire the iterator to
 * advance it to the first link (and determine if the first link exists
 * at all).
 *
 * @return %TRUE on success, or %FALSE when there are no more links
 */
- (bool)next;

@end