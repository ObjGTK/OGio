/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGAppLaunchContext.h"

@implementation OGAppLaunchContext

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_APP_LAUNCH_CONTEXT;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GAppLaunchContext* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_app_launch_context_new(), GAppLaunchContext, GAppLaunchContext);

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

- (GAppLaunchContext*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GAppLaunchContext, GAppLaunchContext);
}

- (char*)displayWithInfo:(GAppInfo*)info files:(GList*)files
{
	char* gobjectValue = g_app_launch_context_get_display([self castedGObject], info, files);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (char**)environment
{
	char** returnValue = (char**)g_app_launch_context_get_environment([self castedGObject]);

	return returnValue;
}

- (char*)startupNotifyIdWithInfo:(GAppInfo*)info files:(GList*)files
{
	char* gobjectValue = g_app_launch_context_get_startup_notify_id([self castedGObject], info, files);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (void)launchFailed:(OFString*)startupNotifyId
{
	g_app_launch_context_launch_failed([self castedGObject], [startupNotifyId UTF8String]);
}

- (void)setenvWithVariable:(OFString*)variable value:(OFString*)value
{
	g_app_launch_context_setenv([self castedGObject], [variable UTF8String], [value UTF8String]);
}

- (void)unsetenv:(OFString*)variable
{
	g_app_launch_context_unsetenv([self castedGObject], [variable UTF8String]);
}


@end