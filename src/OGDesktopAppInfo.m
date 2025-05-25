/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDesktopAppInfo.h"

#import "OGAppLaunchContext.h"

@implementation OGDesktopAppInfo

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DESKTOP_APP_INFO;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_DESKTOP_APP_INFO);
	return gObjectClass;
}

+ (GList*)implementationsWithInterface:(OFString*)interface
{
	GList* returnValue = (GList*)g_desktop_app_info_get_implementations([interface UTF8String]);

	return returnValue;
}

+ (gchar***)searchWithSearchString:(OFString*)searchString
{
	gchar*** returnValue = (gchar***)g_desktop_app_info_search([searchString UTF8String]);

	return returnValue;
}

+ (void)setDesktopEnv:(OFString*)desktopEnv
{
	g_desktop_app_info_set_desktop_env([desktopEnv UTF8String]);
}

+ (instancetype)desktopAppInfoWithDesktopId:(OFString*)desktopId
{
	GDesktopAppInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_desktop_app_info_new([desktopId UTF8String]), G_TYPE_DESKTOP_APP_INFO, GDesktopAppInfo);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDesktopAppInfo* wrapperObject;
	@try {
		wrapperObject = [[OGDesktopAppInfo alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)desktopAppInfoFromFilename:(OFString*)filename
{
	GDesktopAppInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_desktop_app_info_new_from_filename([filename UTF8String]), G_TYPE_DESKTOP_APP_INFO, GDesktopAppInfo);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDesktopAppInfo* wrapperObject;
	@try {
		wrapperObject = [[OGDesktopAppInfo alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)desktopAppInfoFromKeyfile:(GKeyFile*)keyFile
{
	GDesktopAppInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_desktop_app_info_new_from_keyfile(keyFile), G_TYPE_DESKTOP_APP_INFO, GDesktopAppInfo);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGDesktopAppInfo* wrapperObject;
	@try {
		wrapperObject = [[OGDesktopAppInfo alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GDesktopAppInfo*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_DESKTOP_APP_INFO, GDesktopAppInfo);
}

- (OFString*)actionName:(OFString*)actionName
{
	gchar* gobjectValue = g_desktop_app_info_get_action_name((GDesktopAppInfo*)[self castedGObject], [actionName UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (bool)booleanWithKey:(OFString*)key
{
	bool returnValue = (bool)g_desktop_app_info_get_boolean((GDesktopAppInfo*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (OFString*)categories
{
	const char* gobjectValue = g_desktop_app_info_get_categories((GDesktopAppInfo*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)filename
{
	const char* gobjectValue = g_desktop_app_info_get_filename((GDesktopAppInfo*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)genericName
{
	const char* gobjectValue = g_desktop_app_info_get_generic_name((GDesktopAppInfo*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)isHidden
{
	bool returnValue = (bool)g_desktop_app_info_get_is_hidden((GDesktopAppInfo*)[self castedGObject]);

	return returnValue;
}

- (const char* const*)keywords
{
	const char* const* returnValue = (const char* const*)g_desktop_app_info_get_keywords((GDesktopAppInfo*)[self castedGObject]);

	return returnValue;
}

- (OFString*)localeStringWithKey:(OFString*)key
{
	char* gobjectValue = g_desktop_app_info_get_locale_string((GDesktopAppInfo*)[self castedGObject], [key UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (bool)nodisplay
{
	bool returnValue = (bool)g_desktop_app_info_get_nodisplay((GDesktopAppInfo*)[self castedGObject]);

	return returnValue;
}

- (bool)showInWithDesktopEnv:(OFString*)desktopEnv
{
	bool returnValue = (bool)g_desktop_app_info_get_show_in((GDesktopAppInfo*)[self castedGObject], [desktopEnv UTF8String]);

	return returnValue;
}

- (OFString*)startupWmClass
{
	const char* gobjectValue = g_desktop_app_info_get_startup_wm_class((GDesktopAppInfo*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)stringWithKey:(OFString*)key
{
	char* gobjectValue = g_desktop_app_info_get_string((GDesktopAppInfo*)[self castedGObject], [key UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (gchar**)stringListWithKey:(OFString*)key length:(gsize*)length
{
	gchar** returnValue = (gchar**)g_desktop_app_info_get_string_list((GDesktopAppInfo*)[self castedGObject], [key UTF8String], length);

	return returnValue;
}

- (bool)hasKey:(OFString*)key
{
	bool returnValue = (bool)g_desktop_app_info_has_key((GDesktopAppInfo*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (void)launchActionWithActionName:(OFString*)actionName launchContext:(OGAppLaunchContext*)launchContext
{
	g_desktop_app_info_launch_action((GDesktopAppInfo*)[self castedGObject], [actionName UTF8String], [launchContext castedGObject]);
}

- (bool)launchUrisAsManager:(GList*)uris launchContext:(OGAppLaunchContext*)launchContext spawnFlags:(GSpawnFlags)spawnFlags userSetup:(GSpawnChildSetupFunc)userSetup userSetupData:(gpointer)userSetupData pidCallback:(GDesktopAppLaunchCallback)pidCallback pidCallbackData:(gpointer)pidCallbackData
{
	GError* err = NULL;

	bool returnValue = (bool)g_desktop_app_info_launch_uris_as_manager((GDesktopAppInfo*)[self castedGObject], uris, [launchContext castedGObject], spawnFlags, userSetup, userSetupData, pidCallback, pidCallbackData, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)launchUrisAsManagerWithFds:(GList*)uris launchContext:(OGAppLaunchContext*)launchContext spawnFlags:(GSpawnFlags)spawnFlags userSetup:(GSpawnChildSetupFunc)userSetup userSetupData:(gpointer)userSetupData pidCallback:(GDesktopAppLaunchCallback)pidCallback pidCallbackData:(gpointer)pidCallbackData stdinFd:(gint)stdinFd stdoutFd:(gint)stdoutFd stderrFd:(gint)stderrFd
{
	GError* err = NULL;

	bool returnValue = (bool)g_desktop_app_info_launch_uris_as_manager_with_fds((GDesktopAppInfo*)[self castedGObject], uris, [launchContext castedGObject], spawnFlags, userSetup, userSetupData, pidCallback, pidCallbackData, stdinFd, stdoutFd, stderrFd, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (const gchar* const*)listActions
{
	const gchar* const* returnValue = (const gchar* const*)g_desktop_app_info_list_actions((GDesktopAppInfo*)[self castedGObject]);

	return returnValue;
}


@end