/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSettings.h"

#import "OGSettingsBackend.h"

@implementation OGSettings

+ (const gchar* const*)listRelocatableSchemas
{
	const gchar* const* returnValue = g_settings_list_relocatable_schemas();

	return returnValue;
}

+ (const gchar* const*)listSchemas
{
	const gchar* const* returnValue = g_settings_list_schemas();

	return returnValue;
}

+ (void)sync
{
	g_settings_sync();
}

+ (void)unbindWithObject:(gpointer)object property:(OFString*)property
{
	g_settings_unbind(object, [property UTF8String]);
}

- (instancetype)init:(OFString*)schemaId
{
	GSettings* gobjectValue = G_SETTINGS(g_settings_new([schemaId UTF8String]));

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

- (instancetype)initFullWithSchema:(GSettingsSchema*)schema backend:(OGSettingsBackend*)backend path:(OFString*)path
{
	GSettings* gobjectValue = G_SETTINGS(g_settings_new_full(schema, [backend castedGObject], [path UTF8String]));

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

- (instancetype)initWithBackendWithSchemaId:(OFString*)schemaId backend:(OGSettingsBackend*)backend
{
	GSettings* gobjectValue = G_SETTINGS(g_settings_new_with_backend([schemaId UTF8String], [backend castedGObject]));

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

- (instancetype)initWithBackendAndPathWithSchemaId:(OFString*)schemaId backend:(OGSettingsBackend*)backend path:(OFString*)path
{
	GSettings* gobjectValue = G_SETTINGS(g_settings_new_with_backend_and_path([schemaId UTF8String], [backend castedGObject], [path UTF8String]));

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

- (instancetype)initWithPathWithSchemaId:(OFString*)schemaId path:(OFString*)path
{
	GSettings* gobjectValue = G_SETTINGS(g_settings_new_with_path([schemaId UTF8String], [path UTF8String]));

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

- (GSettings*)castedGObject
{
	return G_SETTINGS([self gObject]);
}

- (void)apply
{
	g_settings_apply([self castedGObject]);
}

- (void)bindWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property flags:(GSettingsBindFlags)flags
{
	g_settings_bind([self castedGObject], [key UTF8String], object, [property UTF8String], flags);
}

- (void)bindWithMappingWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property flags:(GSettingsBindFlags)flags getMapping:(GSettingsBindGetMapping)getMapping setMapping:(GSettingsBindSetMapping)setMapping userData:(gpointer)userData destroy:(GDestroyNotify)destroy
{
	g_settings_bind_with_mapping([self castedGObject], [key UTF8String], object, [property UTF8String], flags, getMapping, setMapping, userData, destroy);
}

- (void)bindWritableWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property inverted:(bool)inverted
{
	g_settings_bind_writable([self castedGObject], [key UTF8String], object, [property UTF8String], inverted);
}

- (GAction*)createAction:(OFString*)key
{
	GAction* returnValue = g_settings_create_action([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (void)delay
{
	g_settings_delay([self castedGObject]);
}

- (bool)boolean:(OFString*)key
{
	bool returnValue = g_settings_get_boolean([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (OGSettings*)child:(OFString*)name
{
	GSettings* gobjectValue = G_SETTINGS(g_settings_get_child([self castedGObject], [name UTF8String]));

	OGSettings* returnValue = [OGSettings withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GVariant*)defaultValue:(OFString*)key
{
	GVariant* returnValue = g_settings_get_default_value([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gdouble)double:(OFString*)key
{
	gdouble returnValue = g_settings_get_double([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gint)enum:(OFString*)key
{
	gint returnValue = g_settings_get_enum([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (guint)flags:(OFString*)key
{
	guint returnValue = g_settings_get_flags([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (bool)hasUnapplied
{
	bool returnValue = g_settings_get_has_unapplied([self castedGObject]);

	return returnValue;
}

- (gint)int:(OFString*)key
{
	gint returnValue = g_settings_get_int([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gint64)int64:(OFString*)key
{
	gint64 returnValue = g_settings_get_int64([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gpointer)mappedWithKey:(OFString*)key mapping:(GSettingsGetMapping)mapping userData:(gpointer)userData
{
	gpointer returnValue = g_settings_get_mapped([self castedGObject], [key UTF8String], mapping, userData);

	return returnValue;
}

- (GVariant*)range:(OFString*)key
{
	GVariant* returnValue = g_settings_get_range([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (OFString*)string:(OFString*)key
{
	gchar* gobjectValue = g_settings_get_string([self castedGObject], [key UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (gchar**)strv:(OFString*)key
{
	gchar** returnValue = g_settings_get_strv([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (guint)uint:(OFString*)key
{
	guint returnValue = g_settings_get_uint([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (guint64)uint64:(OFString*)key
{
	guint64 returnValue = g_settings_get_uint64([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (GVariant*)userValue:(OFString*)key
{
	GVariant* returnValue = g_settings_get_user_value([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (GVariant*)value:(OFString*)key
{
	GVariant* returnValue = g_settings_get_value([self castedGObject], [key UTF8String]);

	return returnValue;
}

- (bool)isWritable:(OFString*)name
{
	bool returnValue = g_settings_is_writable([self castedGObject], [name UTF8String]);

	return returnValue;
}

- (gchar**)listChildren
{
	gchar** returnValue = g_settings_list_children([self castedGObject]);

	return returnValue;
}

- (gchar**)listKeys
{
	gchar** returnValue = g_settings_list_keys([self castedGObject]);

	return returnValue;
}

- (bool)rangeCheckWithKey:(OFString*)key value:(GVariant*)value
{
	bool returnValue = g_settings_range_check([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (void)reset:(OFString*)key
{
	g_settings_reset([self castedGObject], [key UTF8String]);
}

- (void)revert
{
	g_settings_revert([self castedGObject]);
}

- (bool)setBooleanWithKey:(OFString*)key value:(bool)value
{
	bool returnValue = g_settings_set_boolean([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setDoubleWithKey:(OFString*)key value:(gdouble)value
{
	bool returnValue = g_settings_set_double([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setEnumWithKey:(OFString*)key value:(gint)value
{
	bool returnValue = g_settings_set_enum([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setFlagsWithKey:(OFString*)key value:(guint)value
{
	bool returnValue = g_settings_set_flags([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setIntWithKey:(OFString*)key value:(gint)value
{
	bool returnValue = g_settings_set_int([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setInt64WithKey:(OFString*)key value:(gint64)value
{
	bool returnValue = g_settings_set_int64([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setStringWithKey:(OFString*)key value:(OFString*)value
{
	bool returnValue = g_settings_set_string([self castedGObject], [key UTF8String], [value UTF8String]);

	return returnValue;
}

- (bool)setStrvWithKey:(OFString*)key value:(const gchar* const*)value
{
	bool returnValue = g_settings_set_strv([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setUintWithKey:(OFString*)key value:(guint)value
{
	bool returnValue = g_settings_set_uint([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setUint64WithKey:(OFString*)key value:(guint64)value
{
	bool returnValue = g_settings_set_uint64([self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setValueWithKey:(OFString*)key value:(GVariant*)value
{
	bool returnValue = g_settings_set_value([self castedGObject], [key UTF8String], value);

	return returnValue;
}


@end