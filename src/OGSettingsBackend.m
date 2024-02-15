/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSettingsBackend.h"

@implementation OGSettingsBackend

+ (void)flattenTreeWithTree:(GTree*)tree path:(gchar**)path keys:(const gchar***)keys values:(GVariant***)values
{
	g_settings_backend_flatten_tree(tree, path, keys, values);
}

+ (OGSettingsBackend*)default
{
	GSettingsBackend* gobjectValue = G_SETTINGS_BACKEND(g_settings_backend_get_default());

	OGSettingsBackend* returnValue = [OGSettingsBackend withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GSettingsBackend*)castedGObject
{
	return G_SETTINGS_BACKEND([self gObject]);
}

- (void)changedWithKey:(OFString*)key originTag:(gpointer)originTag
{
	g_settings_backend_changed([self castedGObject], [key UTF8String], originTag);
}

- (void)changedTreeWithTree:(GTree*)tree originTag:(gpointer)originTag
{
	g_settings_backend_changed_tree([self castedGObject], tree, originTag);
}

- (void)keysChangedWithPath:(OFString*)path items:(const gchar* const*)items originTag:(gpointer)originTag
{
	g_settings_backend_keys_changed([self castedGObject], [path UTF8String], items, originTag);
}

- (void)pathChangedWithPath:(OFString*)path originTag:(gpointer)originTag
{
	g_settings_backend_path_changed([self castedGObject], [path UTF8String], originTag);
}

- (void)pathWritableChanged:(OFString*)path
{
	g_settings_backend_path_writable_changed([self castedGObject], [path UTF8String]);
}

- (void)writableChanged:(OFString*)key
{
	g_settings_backend_writable_changed([self castedGObject], [key UTF8String]);
}


@end