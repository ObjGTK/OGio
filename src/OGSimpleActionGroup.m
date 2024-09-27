/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimpleActionGroup.h"

@implementation OGSimpleActionGroup

- (instancetype)init
{
	GSimpleActionGroup* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_action_group_new(), GSimpleActionGroup, GSimpleActionGroup);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSimpleActionGroup, GSimpleActionGroup);
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