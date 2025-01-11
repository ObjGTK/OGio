/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGPropertyAction.h"

@implementation OGPropertyAction

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_PROPERTY_ACTION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)propertyActionWithName:(OFString*)name object:(gpointer)object propertyName:(OFString*)propertyName
{
	GPropertyAction* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_property_action_new([name UTF8String], object, [propertyName UTF8String]), GPropertyAction, GPropertyAction);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGPropertyAction* wrapperObject;
	@try {
		wrapperObject = [[OGPropertyAction alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GPropertyAction*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GPropertyAction, GPropertyAction);
}


@end