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

/**
 * A `GPropertyAction` is a way to get a [iface@Gio.Action] with a state value
 * reflecting and controlling the value of a [class@GObject.Object] property.
 * 
 * The state of the action will correspond to the value of the property.
 * Changing it will change the property (assuming the requested value
 * matches the requirements as specified in the [type@GObject.ParamSpec]).
 * 
 * Only the most common types are presently supported.  Booleans are
 * mapped to booleans, strings to strings, signed/unsigned integers to
 * int32/uint32 and floats and doubles to doubles.
 * 
 * If the property is an enum then the state will be string-typed and
 * conversion will automatically be performed between the enum value and
 * ‘nick’ string as per the [type@GObject.EnumValue] table.
 * 
 * Flags types are not currently supported.
 * 
 * Properties of object types, boxed types and pointer types are not
 * supported and probably never will be.
 * 
 * Properties of [type@GLib.Variant] types are not currently supported.
 * 
 * If the property is boolean-valued then the action will have a `NULL`
 * parameter type, and activating the action (with no parameter) will
 * toggle the value of the property.
 * 
 * In all other cases, the parameter type will correspond to the type of
 * the property.
 * 
 * The general idea here is to reduce the number of locations where a
 * particular piece of state is kept (and therefore has to be synchronised
 * between). `GPropertyAction` does not have a separate state that is kept
 * in sync with the property value — its state is the property value.
 * 
 * For example, it might be useful to create a [iface@Gio.Action] corresponding
 * to the `visible-child-name` property of a [`GtkStack`](https://docs.gtk.org/gtk4/class.Stack.html)
 * so that the current page can be switched from a menu.  The active radio
 * indication in the menu is then directly determined from the active page of
 * the `GtkStack`.
 * 
 * An anti-example would be binding the `active-id` property on a
 * [`GtkComboBox`](https://docs.gtk.org/gtk4/class.ComboBox.html). This is
 * because the state of the combo box itself is probably uninteresting and is
 * actually being used to control something else.
 * 
 * Another anti-example would be to bind to the `visible-child-name`
 * property of a [`GtkStack`](https://docs.gtk.org/gtk4/class.Stack.html) if
 * this value is actually stored in [class@Gio.Settings].  In that case, the
 * real source of the value is* [class@Gio.Settings].  If you want
 * a [iface@Gio.Action] to control a setting stored in [class@Gio.Settings],
 * see [method@Gio.Settings.create_action] instead, and possibly combine its
 * use with [method@Gio.Settings.bind].
 *
 */
@interface OGPropertyAction : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initWithName:(OFString*)name object:(gpointer)object propertyName:(OFString*)propertyName;

/**
 * Methods
 */

- (GPropertyAction*)castedGObject;

@end