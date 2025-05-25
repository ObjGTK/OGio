/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGNotification.h"

@implementation OGNotification

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_NOTIFICATION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_NOTIFICATION);
	return gObjectClass;
}

+ (instancetype)notificationWithTitle:(OFString*)title
{
	GNotification* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_notification_new([title UTF8String]), G_TYPE_NOTIFICATION, GNotification);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGNotification* wrapperObject;
	@try {
		wrapperObject = [[OGNotification alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GNotification*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_NOTIFICATION, GNotification);
}

- (void)addButtonWithLabel:(OFString*)label detailedAction:(OFString*)detailedAction
{
	g_notification_add_button((GNotification*)[self castedGObject], [label UTF8String], [detailedAction UTF8String]);
}

- (void)addButtonWithTargetValueWithLabel:(OFString*)label action:(OFString*)action target:(GVariant*)target
{
	g_notification_add_button_with_target_value((GNotification*)[self castedGObject], [label UTF8String], [action UTF8String], target);
}

- (void)setBody:(OFString*)body
{
	g_notification_set_body((GNotification*)[self castedGObject], [body UTF8String]);
}

- (void)setCategory:(OFString*)category
{
	g_notification_set_category((GNotification*)[self castedGObject], [category UTF8String]);
}

- (void)setDefaultActionWithDetailedAction:(OFString*)detailedAction
{
	g_notification_set_default_action((GNotification*)[self castedGObject], [detailedAction UTF8String]);
}

- (void)setDefaultActionAndTargetValue:(OFString*)action target:(GVariant*)target
{
	g_notification_set_default_action_and_target_value((GNotification*)[self castedGObject], [action UTF8String], target);
}

- (void)setIcon:(GIcon*)icon
{
	g_notification_set_icon((GNotification*)[self castedGObject], icon);
}

- (void)setPriority:(GNotificationPriority)priority
{
	g_notification_set_priority((GNotification*)[self castedGObject], priority);
}

- (void)setTitle:(OFString*)title
{
	g_notification_set_title((GNotification*)[self castedGObject], [title UTF8String]);
}

- (void)setUrgent:(bool)urgent
{
	g_notification_set_urgent((GNotification*)[self castedGObject], urgent);
}


@end