/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleAction.h"

@implementation OGSimpleAction

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_ACTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SIMPLE_ACTION);
	return gObjectClass;
}

+ (instancetype)simpleActionWithName:(OFString*)name parameterType:(const GVariantType*)parameterType
{
	GSimpleAction* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_action_new([name UTF8String], parameterType), G_TYPE_SIMPLE_ACTION, GSimpleAction);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleAction* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleAction alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)simpleActionStatefulWithName:(OFString*)name parameterType:(const GVariantType*)parameterType state:(GVariant*)state
{
	GSimpleAction* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_action_new_stateful([name UTF8String], parameterType, state), G_TYPE_SIMPLE_ACTION, GSimpleAction);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleAction* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleAction alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSimpleAction*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SIMPLE_ACTION, GSimpleAction);
}

- (void)setEnabled:(bool)enabled
{
	g_simple_action_set_enabled((GSimpleAction*)[self castedGObject], enabled);
}

- (void)setStateWithValue:(GVariant*)value
{
	g_simple_action_set_state((GSimpleAction*)[self castedGObject], value);
}

- (void)setStateHint:(GVariant*)stateHint
{
	g_simple_action_set_state_hint((GSimpleAction*)[self castedGObject], stateHint);
}


@end