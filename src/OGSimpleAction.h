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

/**
 * A #GSimpleAction is the obvious simple implementation of the #GAction
 * interface. This is the easiest way to create an action for purposes of
 * adding it to a #GSimpleActionGroup.
 * 
 * See also #GtkAction.
 *
 */
@interface OGSimpleAction : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initWithName:(OFString*)name parameterType:(const GVariantType*)parameterType;
- (instancetype)initStatefulWithName:(OFString*)name parameterType:(const GVariantType*)parameterType state:(GVariant*)state;

/**
 * Methods
 */

- (GSimpleAction*)castedGObject;

/**
 * Sets the action as enabled or not.
 * 
 * An action must be enabled in order to be activated or in order to
 * have its state changed from outside callers.
 * 
 * This should only be called by the implementor of the action.  Users
 * of the action should not attempt to modify its enabled flag.
 *
 * @param enabled whether the action is enabled
 */
- (void)setEnabled:(bool)enabled;

/**
 * Sets the state of the action.
 * 
 * This directly updates the 'state' property to the given value.
 * 
 * This should only be called by the implementor of the action.  Users
 * of the action should not attempt to directly modify the 'state'
 * property.  Instead, they should call g_action_change_state() to
 * request the change.
 * 
 * If the @value GVariant is floating, it is consumed.
 *
 * @param value the new #GVariant for the state
 */
- (void)setState:(GVariant*)value;

/**
 * Sets the state hint for the action.
 * 
 * See g_action_get_state_hint() for more information about
 * action state hints.
 *
 * @param stateHint a #GVariant representing the state hint
 */
- (void)setStateHint:(GVariant*)stateHint;

@end