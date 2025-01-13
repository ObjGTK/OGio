/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

@class OGMenuModel;

/**
 * #GMenuItem is an opaque structure type.  You must access it using the
 * functions below.
 *
 */
@interface OGMenuItem : OGObject
{

}


/**
 * Constructors
 */
+ (instancetype)menuItemWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction;
+ (instancetype)menuItemFromModel:(OGMenuModel*)model itemIndex:(gint)itemIndex;
+ (instancetype)menuItemSectionWithLabel:(OFString*)label section:(OGMenuModel*)section;
+ (instancetype)menuItemSubmenuWithLabel:(OFString*)label submenu:(OGMenuModel*)submenu;

/**
 * Methods
 */

- (GMenuItem*)castedGObject;

/**
 * Queries the named @attribute on @menu_item.
 * 
 * If @expected_type is specified and the attribute does not have this
 * type, %NULL is returned.  %NULL is also returned if the attribute
 * simply does not exist.
 *
 * @param attribute the attribute name to query
 * @param expectedType the expected type of the attribute
 * @return the attribute value, or %NULL
 */
- (GVariant*)attributeValueWithAttribute:(OFString*)attribute expectedType:(const GVariantType*)expectedType;

/**
 * Queries the named @link on @menu_item.
 *
 * @param link the link name to query
 * @return the link, or %NULL
 */
- (OGMenuModel*)linkWithLink:(OFString*)link;

/**
 * Sets or unsets the "action" and "target" attributes of @menu_item.
 * 
 * If @action is %NULL then both the "action" and "target" attributes
 * are unset (and @target_value is ignored).
 * 
 * If @action is non-%NULL then the "action" attribute is set.  The
 * "target" attribute is then set to the value of @target_value if it is
 * non-%NULL or unset otherwise.
 * 
 * Normal menu items (ie: not submenu, section or other custom item
 * types) are expected to have the "action" attribute set to identify
 * the action that they are associated with.  The state type of the
 * action help to determine the disposition of the menu item.  See
 * #GAction and #GActionGroup for an overview of actions.
 * 
 * In general, clicking on the menu item will result in activation of
 * the named action with the "target" attribute given as the parameter
 * to the action invocation.  If the "target" attribute is not set then
 * the action is invoked with no parameter.
 * 
 * If the action has no state then the menu item is usually drawn as a
 * plain menu item (ie: with no additional decoration).
 * 
 * If the action has a boolean state then the menu item is usually drawn
 * as a toggle menu item (ie: with a checkmark or equivalent
 * indication).  The item should be marked as 'toggled' or 'checked'
 * when the boolean state is %TRUE.
 * 
 * If the action has a string state then the menu item is usually drawn
 * as a radio menu item (ie: with a radio bullet or equivalent
 * indication).  The item should be marked as 'selected' when the string
 * state is equal to the value of the @target property.
 * 
 * See g_menu_item_set_action_and_target() or
 * g_menu_item_set_detailed_action() for two equivalent calls that are
 * probably more convenient for most uses.
 *
 * @param action the name of the action for this item
 * @param targetValue a #GVariant to use as the action target
 */
- (void)setActionAndTargetValue:(OFString*)action targetValue:(GVariant*)targetValue;

/**
 * Sets or unsets an attribute on @menu_item.
 * 
 * The attribute to set or unset is specified by @attribute. This
 * can be one of the standard attribute names %G_MENU_ATTRIBUTE_LABEL,
 * %G_MENU_ATTRIBUTE_ACTION, %G_MENU_ATTRIBUTE_TARGET, or a custom
 * attribute name.
 * Attribute names are restricted to lowercase characters, numbers
 * and '-'. Furthermore, the names must begin with a lowercase character,
 * must not end with a '-', and must not contain consecutive dashes.
 * 
 * must consist only of lowercase
 * ASCII characters, digits and '-'.
 * 
 * If @value is non-%NULL then it is used as the new value for the
 * attribute.  If @value is %NULL then the attribute is unset. If
 * the @value #GVariant is floating, it is consumed.
 * 
 * See also g_menu_item_set_attribute() for a more convenient way to do
 * the same.
 *
 * @param attribute the attribute to set
 * @param value a #GVariant to use as the value, or %NULL
 */
- (void)setAttributeValue:(OFString*)attribute value:(GVariant*)value;

/**
 * Sets the "action" and possibly the "target" attribute of @menu_item.
 * 
 * The format of @detailed_action is the same format parsed by
 * g_action_parse_detailed_name().
 * 
 * See g_menu_item_set_action_and_target() or
 * g_menu_item_set_action_and_target_value() for more flexible (but
 * slightly less convenient) alternatives.
 * 
 * See also g_menu_item_set_action_and_target_value() for a description of
 * the semantics of the action and target attributes.
 *
 * @param detailedAction the "detailed" action string
 */
- (void)setDetailedAction:(OFString*)detailedAction;

/**
 * Sets (or unsets) the icon on @menu_item.
 * 
 * This call is the same as calling g_icon_serialize() and using the
 * result as the value to g_menu_item_set_attribute_value() for
 * %G_MENU_ATTRIBUTE_ICON.
 * 
 * This API is only intended for use with "noun" menu items; things like
 * bookmarks or applications in an "Open With" menu.  Don't use it on
 * menu items corresponding to verbs (eg: stock icons for 'Save' or
 * 'Quit').
 * 
 * If @icon is %NULL then the icon is unset.
 *
 * @param icon a #GIcon, or %NULL
 */
- (void)setIcon:(GIcon*)icon;

/**
 * Sets or unsets the "label" attribute of @menu_item.
 * 
 * If @label is non-%NULL it is used as the label for the menu item.  If
 * it is %NULL then the label attribute is unset.
 *
 * @param label the label to set, or %NULL to unset
 */
- (void)setLabel:(OFString*)label;

/**
 * Creates a link from @menu_item to @model if non-%NULL, or unsets it.
 * 
 * Links are used to establish a relationship between a particular menu
 * item and another menu.  For example, %G_MENU_LINK_SUBMENU is used to
 * associate a submenu with a particular menu item, and %G_MENU_LINK_SECTION
 * is used to create a section. Other types of link can be used, but there
 * is no guarantee that clients will be able to make sense of them.
 * Link types are restricted to lowercase characters, numbers
 * and '-'. Furthermore, the names must begin with a lowercase character,
 * must not end with a '-', and must not contain consecutive dashes.
 *
 * @param link type of link to establish or unset
 * @param model the #GMenuModel to link to (or %NULL to unset)
 */
- (void)setLink:(OFString*)link model:(OGMenuModel*)model;

/**
 * Sets or unsets the "section" link of @menu_item to @section.
 * 
 * The effect of having one menu appear as a section of another is
 * exactly as it sounds: the items from @section become a direct part of
 * the menu that @menu_item is added to.  See g_menu_item_new_section()
 * for more information about what it means for a menu item to be a
 * section.
 *
 * @param section a #GMenuModel, or %NULL
 */
- (void)setSection:(OGMenuModel*)section;

/**
 * Sets or unsets the "submenu" link of @menu_item to @submenu.
 * 
 * If @submenu is non-%NULL, it is linked to.  If it is %NULL then the
 * link is unset.
 * 
 * The effect of having one menu appear as a submenu of another is
 * exactly as it sounds.
 *
 * @param submenu a #GMenuModel, or %NULL
 */
- (void)setSubmenu:(OGMenuModel*)submenu;

@end