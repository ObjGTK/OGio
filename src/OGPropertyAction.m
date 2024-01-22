/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGPropertyAction.h"

@implementation OGPropertyAction

- (instancetype)initWithName:(OFString*)name object:(gpointer)object propertyName:(OFString*)propertyName
{
	GPropertyAction* gobjectValue = G_PROPERTY_ACTION(g_property_action_new([name UTF8String], object, [propertyName UTF8String]));

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

- (GPropertyAction*)castedGObject
{
	return G_PROPERTY_ACTION([self gObject]);
}


@end