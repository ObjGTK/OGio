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

@class OGMenuAttributeIter;
@class OGMenuLinkIter;

/**
 * `GMenuModel` represents the contents of a menu — an ordered list of
 * menu items. The items are associated with actions, which can be
 * activated through them. Items can be grouped in sections, and may
 * have submenus associated with them. Both items and sections usually
 * have some representation data, such as labels or icons. The type of
 * the associated action (ie whether it is stateful, and what kind of
 * state it has) can influence the representation of the item.
 * 
 * The conceptual model of menus in `GMenuModel` is hierarchical:
 * sections and submenus are again represented by `GMenuModel`s.
 * Menus themselves do not define their own roles. Rather, the role
 * of a particular `GMenuModel` is defined by the item that references
 * it (or, in the case of the ‘root’ menu, is defined by the context
 * in which it is used).
 * 
 * As an example, consider the visible portions of this menu:
 * 
 * ## An example menu
 * 
 * ![](menu-example.png)
 * 
 * There are 8 ‘menus’ visible in the screenshot: one menubar, two
 * submenus and 5 sections:
 * 
 * - the toplevel menubar (containing 4 items)
 * - the View submenu (containing 3 sections)
 * - the first section of the View submenu (containing 2 items)
 * - the second section of the View submenu (containing 1 item)
 * - the final section of the View submenu (containing 1 item)
 * - the Highlight Mode submenu (containing 2 sections)
 * - the Sources section (containing 2 items)
 * - the Markup section (containing 2 items)
 * 
 * The [example](#a-menu-example) illustrates the conceptual connection between
 * these 8 menus. Each large block in the figure represents a menu and the
 * smaller blocks within the large block represent items in that menu. Some
 * items contain references to other menus.
 * 
 * ## A menu example
 * 
 * ![](menu-model.png)
 * 
 * Notice that the separators visible in the [example](#an-example-menu)
 * appear nowhere in the [menu model](#a-menu-example). This is because
 * separators are not explicitly represented in the menu model. Instead,
 * a separator is inserted between any two non-empty sections of a menu.
 * Section items can have labels just like any other item. In that case,
 * a display system may show a section header instead of a separator.
 * 
 * The motivation for this abstract model of application controls is
 * that modern user interfaces tend to make these controls available
 * outside the application. Examples include global menus, jumplists,
 * dash boards, etc. To support such uses, it is necessary to ‘export’
 * information about actions and their representation in menus, which
 * is exactly what the action group exporter and the menu model exporter do for
 * [iface@Gio.ActionGroup] and [class@Gio.MenuModel]. The client-side
 * counterparts to make use of the exported information are
 * [class@Gio.DBusActionGroup] and [class@Gio.DBusMenuModel].
 * 
 * The API of `GMenuModel` is very generic, with iterators for the
 * attributes and links of an item, see
 * [method@Gio.MenuModel.iterate_item_attributes] and
 * [method@Gio.MenuModel.iterate_item_links]. The ‘standard’ attributes and
 * link types have predefined names: `G_MENU_ATTRIBUTE_LABEL`,
 * `G_MENU_ATTRIBUTE_ACTION`, `G_MENU_ATTRIBUTE_TARGET`, `G_MENU_LINK_SECTION`
 * and `G_MENU_LINK_SUBMENU`.
 * 
 * Items in a `GMenuModel` represent active controls if they refer to
 * an action that can get activated when the user interacts with the
 * menu item. The reference to the action is encoded by the string ID
 * in the `G_MENU_ATTRIBUTE_ACTION` attribute. An action ID uniquely
 * identifies an action in an action group. Which action group(s) provide
 * actions depends on the context in which the menu model is used.
 * E.g. when the model is exported as the application menu of a
 * [`GtkApplication`](https://docs.gtk.org/gtk4/class.Application.html),
 * actions can be application-wide or window-specific (and thus come from
 * two different action groups). By convention, the application-wide actions
 * have names that start with `app.`, while the names of window-specific
 * actions start with `win.`.
 * 
 * While a wide variety of stateful actions is possible, the following
 * is the minimum that is expected to be supported by all users of exported
 * menu information:
 * - an action with no parameter type and no state
 * - an action with no parameter type and boolean state
 * - an action with string parameter type and string state
 * 
 * ## Stateless
 * 
 * A stateless action typically corresponds to an ordinary menu item.
 * 
 * Selecting such a menu item will activate the action (with no parameter).
 * 
 * ## Boolean State
 * 
 * An action with a boolean state will most typically be used with a ‘toggle’
 * or ‘switch’ menu item. The state can be set directly, but activating the
 * action (with no parameter) results in the state being toggled.
 * 
 * Selecting a toggle menu item will activate the action. The menu item should
 * be rendered as ‘checked’ when the state is true.
 * 
 * ## String Parameter and State
 * 
 * Actions with string parameters and state will most typically be used to
 * represent an enumerated choice over the items available for a group of
 * radio menu items. Activating the action with a string parameter is
 * equivalent to setting that parameter as the state.
 * 
 * Radio menu items, in addition to being associated with the action, will
 * have a target value. Selecting that menu item will result in activation
 * of the action with the target value as the parameter. The menu item should
 * be rendered as ‘selected’ when the state of the action is equal to the
 * target value of the menu item.
 *
 */
@interface OGMenuModel : OGObject
{

}


/**
 * Methods
 */

- (GMenuModel*)castedGObject;

/**
 * Queries the item at position @item_index in @model for the attribute
 * specified by @attribute.
 * 
 * If @expected_type is non-%NULL then it specifies the expected type of
 * the attribute.  If it is %NULL then any type will be accepted.
 * 
 * If the attribute exists and matches @expected_type (or if the
 * expected type is unspecified) then the value is returned.
 * 
 * If the attribute does not exist, or does not match the expected type
 * then %NULL is returned.
 *
 * @param itemIndex the index of the item
 * @param attribute the attribute to query
 * @param expectedType the expected type of the attribute, or
 *     %NULL
 * @return the value of the attribute
 */
- (GVariant*)itemAttributeValueWithItemIndex:(gint)itemIndex attribute:(OFString*)attribute expectedType:(const GVariantType*)expectedType;

/**
 * Queries the item at position @item_index in @model for the link
 * specified by @link.
 * 
 * If the link exists, the linked #GMenuModel is returned.  If the link
 * does not exist, %NULL is returned.
 *
 * @param itemIndex the index of the item
 * @param link the link to query
 * @return the linked #GMenuModel, or %NULL
 */
- (OGMenuModel*)itemLinkWithItemIndex:(gint)itemIndex link:(OFString*)link;

/**
 * Query the number of items in @model.
 *
 * @return the number of items
 */
- (gint)nitems;

/**
 * Queries if @model is mutable.
 * 
 * An immutable #GMenuModel will never emit the #GMenuModel::items-changed
 * signal. Consumers of the model may make optimisations accordingly.
 *
 * @return %TRUE if the model is mutable (ie: "items-changed" may be
 *     emitted).
 */
- (bool)isMutable;

/**
 * Requests emission of the #GMenuModel::items-changed signal on @model.
 * 
 * This function should never be called except by #GMenuModel
 * subclasses.  Any other calls to this function will very likely lead
 * to a violation of the interface of the model.
 * 
 * The implementation should update its internal representation of the
 * menu before emitting the signal.  The implementation should further
 * expect to receive queries about the new state of the menu (and
 * particularly added menu items) while signal handlers are running.
 * 
 * The implementation must dispatch this call directly from a mainloop
 * entry and not in response to calls -- particularly those from the
 * #GMenuModel API.  Said another way: the menu must not change while
 * user code is running without returning to the mainloop.
 *
 * @param position the position of the change
 * @param removed the number of items removed
 * @param added the number of items added
 */
- (void)itemsChangedWithPosition:(gint)position removed:(gint)removed added:(gint)added;

/**
 * Creates a #GMenuAttributeIter to iterate over the attributes of
 * the item at position @item_index in @model.
 * 
 * You must free the iterator with g_object_unref() when you are done.
 *
 * @param itemIndex the index of the item
 * @return a new #GMenuAttributeIter
 */
- (OGMenuAttributeIter*)iterateItemAttributesWithItemIndex:(gint)itemIndex;

/**
 * Creates a #GMenuLinkIter to iterate over the links of the item at
 * position @item_index in @model.
 * 
 * You must free the iterator with g_object_unref() when you are done.
 *
 * @param itemIndex the index of the item
 * @return a new #GMenuLinkIter
 */
- (OGMenuLinkIter*)iterateItemLinksWithItemIndex:(gint)itemIndex;

@end