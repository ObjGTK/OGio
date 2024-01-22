/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleAction.h"

@implementation OGSimpleAction

- (instancetype)initWithName:(OFString*)name parameterType:(const GVariantType*)parameterType
{
	GSimpleAction* gobjectValue = G_SIMPLE_ACTION(g_simple_action_new([name UTF8String], parameterType));

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

- (instancetype)initStatefulWithName:(OFString*)name parameterType:(const GVariantType*)parameterType state:(GVariant*)state
{
	GSimpleAction* gobjectValue = G_SIMPLE_ACTION(g_simple_action_new_stateful([name UTF8String], parameterType, state));

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

- (GSimpleAction*)castedGObject
{
	return G_SIMPLE_ACTION([self gObject]);
}

- (void)setEnabled:(bool)enabled
{
	g_simple_action_set_enabled([self castedGObject], enabled);
}

- (void)setState:(GVariant*)value
{
	g_simple_action_set_state([self castedGObject], value);
}

- (void)setStateHint:(GVariant*)stateHint
{
	g_simple_action_set_state_hint([self castedGObject], stateHint);
}


@end