/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleActionGroup.h"

@implementation OGSimpleActionGroup

- (instancetype)init
{
	GSimpleActionGroup* gobjectValue = G_SIMPLE_ACTION_GROUP(g_simple_action_group_new());

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

- (GSimpleActionGroup*)castedGObject
{
	return G_SIMPLE_ACTION_GROUP([self gObject]);
}

- (void)addEntriesWithEntries:(const GActionEntry*)entries nentries:(gint)nentries userData:(gpointer)userData
{
	g_simple_action_group_add_entries([self castedGObject], entries, nentries, userData);
}

- (void)insert:(GAction*)action
{
	g_simple_action_group_insert([self castedGObject], action);
}

- (GAction*)lookup:(OFString*)actionName
{
	GAction* returnValue = g_simple_action_group_lookup([self castedGObject], [actionName UTF8String]);

	return returnValue;
}

- (void)remove:(OFString*)actionName
{
	g_simple_action_group_remove([self castedGObject], [actionName UTF8String]);
}


@end