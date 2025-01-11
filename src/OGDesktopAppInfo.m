/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGDesktopAppInfo.h"

#import "OGAppLaunchContext.h"

@implementation OGDesktopAppInfo

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_DESKTOP_APP_INFO;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GList*)implementations:(OFString*)interface
{
	GList* returnValue = (GList*)g_desktop_app_info_get_implementations([interface UTF8String]);

	return returnValue;
}

+ (gchar***)search:(OFString*)searchString
{
	gchar*** returnValue = (gchar***)g_desktop_app_info_search([searchString UTF8String]);

	return returnValue;
}

+ (void)setDesktopEnv:(OFString*)desktopEnv
{
	g_desktop_app_info_set_desktop_env([desktopEnv UTF8String]);
}

+ (instancetype)desktopAppInfo:(OFString*)desktopId
{
	GDesktopAppInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_desktop_app_info_new([desktopId UTF8String]), GDesktopAppInfo, GDesktopAppInfo);

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
	GDesktopAppInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_desktop_app_info_new_from_filename([filename UTF8String]), GDesktopAppInfo, GDesktopAppInfo);

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
	GDesktopAppInfo* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_desktop_app_info_new_from_keyfile(keyFile), GDesktopAppInfo, GDesktopAppInfo);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GDesktopAppInfo, GDesktopAppInfo);
}

- (OFString*)actionName:(OFString*)actionName
{
	gchar* gobjectValue = g_desktop_app_info_get_action_name([self castedGObject], [actionName UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (bool)boolean:(OFString*)key
{
	bool returnValue = (bool)g_desktop_app_info_get_boolean([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (OFString*)categories
{
	const char* gobjectValue = g_desktop_app_info_get_categories([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)filename
{
	const char* gobjectValue = g_desktop_app_info_get_filename([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)genericName
{
	const char* gobjectValue = g_desktop_app_info_get_generic_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)isHidden
{
	bool returnValue = (bool)g_desktop_app_info_get_is_hidden([self castedGObject]);

	return returnValue;
}

- (const char* const*)keywords
{
	const char* const* returnValue = (const char* const*)g_desktop_app_info_get_keywords([self castedGObject]);

	return returnValue;
}

- (char*)localeString:(OFString*)key
{
	char* gobjectValue = g_desktop_app_info_get_locale_string([self castedGObject], [key UTF8String]);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (bool)nodisplay
{
	bool returnValue = (bool)g_desktop_app_info_get_nodisplay([self castedGObject]);

	return returnValue;
}

- (bool)showIn:(OFString*)desktopEnv
{
	bool returnValue = (bool)g_desktop_app_info_get_show_in([self castedGObject], [desktopEnv UTF8String]);

	return returnValue;
}

- (OFString*)startupWmClass
{
	const char* gobjectValue = g_desktop_app_info_get_startup_wm_class([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (char*)string:(OFString*)key
{
	char* gobjectValue = g_desktop_app_info_get_string([self castedGObject], [key UTF8String]);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (gchar**)stringListWithKey:(OFString*)key length:(gsize*)length
{
	gchar** returnValue = (gchar**)g_desktop_app_info_get_string_list([self castedGObject], [key UTF8String], length);

	return returnValue;
}

- (bool)hasKey:(OFString*)key
{
	bool returnValue = (bool)g_desktop_app_info_has_key([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (void)launchActionWithActionName:(OFString*)actionName launchContext:(OGAppLaunchContext*)launchContext
{
	g_desktop_app_info_launch_action([self castedGObject], [actionName UTF8String], [launchContext castedGObject]);
}

- (bool)launchUrisAsManagerWithUris:(GList*)uris launchContext:(OGAppLaunchContext*)launchContext spawnFlags:(GSpawnFlags)spawnFlags userSetup:(GSpawnChildSetupFunc)userSetup userSetupData:(gpointer)userSetupData pidCallback:(GDesktopAppLaunchCallback)pidCallback pidCallbackData:(gpointer)pidCallbackData
{
	GError* err = NULL;

	bool returnValue = (bool)g_desktop_app_info_launch_uris_as_manager([self castedGObject], uris, [launchContext castedGObject], spawnFlags, userSetup, userSetupData, pidCallback, pidCallbackData, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)launchUrisAsManagerWithFdsWithUris:(GList*)uris launchContext:(OGAppLaunchContext*)launchContext spawnFlags:(GSpawnFlags)spawnFlags userSetup:(GSpawnChildSetupFunc)userSetup userSetupData:(gpointer)userSetupData pidCallback:(GDesktopAppLaunchCallback)pidCallback pidCallbackData:(gpointer)pidCallbackData stdinFd:(gint)stdinFd stdoutFd:(gint)stdoutFd stderrFd:(gint)stderrFd
{
	GError* err = NULL;

	bool returnValue = (bool)g_desktop_app_info_launch_uris_as_manager_with_fds([self castedGObject], uris, [launchContext castedGObject], spawnFlags, userSetup, userSetupData, pidCallback, pidCallbackData, stdinFd, stdoutFd, stderrFd, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (const gchar* const*)listActions
{
	const gchar* const* returnValue = (const gchar* const*)g_desktop_app_info_list_actions([self castedGObject]);

	return returnValue;
}


@end