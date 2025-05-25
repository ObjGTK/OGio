/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGAppLaunchContext.h"

@implementation OGAppLaunchContext

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_APP_LAUNCH_CONTEXT;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_APP_LAUNCH_CONTEXT);
	return gObjectClass;
}

+ (instancetype)appLaunchContext
{
	GAppLaunchContext* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_app_launch_context_new(), G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContext);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGAppLaunchContext* wrapperObject;
	@try {
		wrapperObject = [[OGAppLaunchContext alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GAppLaunchContext*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_APP_LAUNCH_CONTEXT, GAppLaunchContext);
}

- (OFString*)displayWithInfo:(GAppInfo*)info files:(GList*)files
{
	char* gobjectValue = g_app_launch_context_get_display([self castedGObject], info, files);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (char**)environment
{
	char** returnValue = (char**)g_app_launch_context_get_environment([self castedGObject]);

	return returnValue;
}

- (OFString*)startupNotifyIdWithInfo:(GAppInfo*)info files:(GList*)files
{
	char* gobjectValue = g_app_launch_context_get_startup_notify_id([self castedGObject], info, files);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (void)launchFailedWithStartupNotifyId:(OFString*)startupNotifyId
{
	g_app_launch_context_launch_failed([self castedGObject], [startupNotifyId UTF8String]);
}

- (void)setenvWithVariable:(OFString*)variable value:(OFString*)value
{
	g_app_launch_context_setenv([self castedGObject], [variable UTF8String], [value UTF8String]);
}

- (void)unsetenvWithVariable:(OFString*)variable
{
	g_app_launch_context_unsetenv([self castedGObject], [variable UTF8String]);
}


@end