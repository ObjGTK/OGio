/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleActionGroup.h"

@implementation OGSimpleActionGroup

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_ACTION_GROUP;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SIMPLE_ACTION_GROUP);
	return gObjectClass;
}

+ (instancetype)simpleActionGroup
{
	GSimpleActionGroup* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_action_group_new(), G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroup);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimpleActionGroup* wrapperObject;
	@try {
		wrapperObject = [[OGSimpleActionGroup alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSimpleActionGroup*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SIMPLE_ACTION_GROUP, GSimpleActionGroup);
}

- (void)addEntries:(const GActionEntry*)entries nentries:(gint)nentries userData:(gpointer)userData
{
	g_simple_action_group_add_entries((GSimpleActionGroup*)[self castedGObject], entries, nentries, userData);
}

- (void)insertWithAction:(GAction*)action
{
	g_simple_action_group_insert((GSimpleActionGroup*)[self castedGObject], action);
}

- (GAction*)lookupWithActionName:(OFString*)actionName
{
	GAction* returnValue = (GAction*)g_simple_action_group_lookup((GSimpleActionGroup*)[self castedGObject], [actionName UTF8String]);

	return returnValue;
}

- (void)removeWithActionName:(OFString*)actionName
{
	g_simple_action_group_remove((GSimpleActionGroup*)[self castedGObject], [actionName UTF8String]);
}


@end