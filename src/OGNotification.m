/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNotification.h"

@implementation OGNotification

- (instancetype)init:(OFString*)title
{
	GNotification* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_notification_new([title UTF8String]), GNotification, GNotification);

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

- (GNotification*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GNotification, GNotification);
}

- (void)addButtonWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction
{
	g_notification_add_button([self castedGObject], [label UTF8String], [detailedAction UTF8String]);
}

- (void)addButtonWithTargetValueWithLabel:(OFString*)label action:(OFString*)action target:(GVariant*)target
{
	g_notification_add_button_with_target_value([self castedGObject], [label UTF8String], [action UTF8String], target);
}

- (void)setBody:(OFString*)body
{
	g_notification_set_body([self castedGObject], [body UTF8String]);
}

- (void)setCategory:(OFString*)category
{
	g_notification_set_category([self castedGObject], [category UTF8String]);
}

- (void)setDefaultAction:(OFString*)detailedAction
{
	g_notification_set_default_action([self castedGObject], [detailedAction UTF8String]);
}

- (void)setDefaultActionAndTargetValueWithAction:(OFString*)action target:(GVariant*)target
{
	g_notification_set_default_action_and_target_value([self castedGObject], [action UTF8String], target);
}

- (void)setIcon:(GIcon*)icon
{
	g_notification_set_icon([self castedGObject], icon);
}

- (void)setPriority:(GNotificationPriority)priority
{
	g_notification_set_priority([self castedGObject], priority);
}

- (void)setTitle:(OFString*)title
{
	g_notification_set_title([self castedGObject], [title UTF8String]);
}

- (void)setUrgent:(bool)urgent
{
	g_notification_set_urgent([self castedGObject], urgent);
}


@end