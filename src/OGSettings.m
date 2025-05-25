/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSettings.h"

@implementation OGSettings

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SETTINGS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SETTINGS);
	return gObjectClass;
}

+ (const gchar* const*)listRelocatableSchemas
{
	const gchar* const* returnValue = (const gchar* const*)g_settings_list_relocatable_schemas();

	return returnValue;
}

+ (const gchar* const*)listSchemas
{
	const gchar* const* returnValue = (const gchar* const*)g_settings_list_schemas();

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

+ (instancetype)settingsWithSchemaId:(OFString*)schemaId
{
	GSettings* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_settings_new([schemaId UTF8String]), G_TYPE_SETTINGS, GSettings);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSettings* wrapperObject;
	@try {
		wrapperObject = [[OGSettings alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)settingsFullWithSchema:(GSettingsSchema*)schema backend:(GSettingsBackend*)backend path:(OFString*)path
{
	GSettings* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_settings_new_full(schema, backend, [path UTF8String]), G_TYPE_SETTINGS, GSettings);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSettings* wrapperObject;
	@try {
		wrapperObject = [[OGSettings alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)settingsWithBackendWithSchemaId:(OFString*)schemaId backend:(GSettingsBackend*)backend
{
	GSettings* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_settings_new_with_backend([schemaId UTF8String], backend), G_TYPE_SETTINGS, GSettings);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSettings* wrapperObject;
	@try {
		wrapperObject = [[OGSettings alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)settingsWithBackendAndPathWithSchemaId:(OFString*)schemaId backend:(GSettingsBackend*)backend path:(OFString*)path
{
	GSettings* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_settings_new_with_backend_and_path([schemaId UTF8String], backend, [path UTF8String]), G_TYPE_SETTINGS, GSettings);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSettings* wrapperObject;
	@try {
		wrapperObject = [[OGSettings alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)settingsWithPathWithSchemaId:(OFString*)schemaId path:(OFString*)path
{
	GSettings* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_settings_new_with_path([schemaId UTF8String], [path UTF8String]), G_TYPE_SETTINGS, GSettings);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSettings* wrapperObject;
	@try {
		wrapperObject = [[OGSettings alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSettings*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SETTINGS, GSettings);
}

- (void)apply
{
	g_settings_apply((GSettings*)[self castedGObject]);
}

- (void)bindWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property flags:(GSettingsBindFlags)flags
{
	g_settings_bind((GSettings*)[self castedGObject], [key UTF8String], object, [property UTF8String], flags);
}

- (void)bindWithMappingWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property flags:(GSettingsBindFlags)flags getMapping:(GSettingsBindGetMapping)getMapping setMapping:(GSettingsBindSetMapping)setMapping userData:(gpointer)userData destroy:(GDestroyNotify)destroy
{
	g_settings_bind_with_mapping((GSettings*)[self castedGObject], [key UTF8String], object, [property UTF8String], flags, getMapping, setMapping, userData, destroy);
}

- (void)bindWritableWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property inverted:(bool)inverted
{
	g_settings_bind_writable((GSettings*)[self castedGObject], [key UTF8String], object, [property UTF8String], inverted);
}

- (GAction*)createActionWithKey:(OFString*)key
{
	GAction* returnValue = (GAction*)g_settings_create_action((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (void)delay
{
	g_settings_delay((GSettings*)[self castedGObject]);
}

- (bool)booleanWithKey:(OFString*)key
{
	bool returnValue = (bool)g_settings_get_boolean((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (OGSettings*)childWithName:(OFString*)name
{
	GSettings* gobjectValue = g_settings_get_child((GSettings*)[self castedGObject], [name UTF8String]);

	OGSettings* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GVariant*)defaultValueWithKey:(OFString*)key
{
	GVariant* returnValue = (GVariant*)g_settings_get_default_value((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gdouble)doubleWithKey:(OFString*)key
{
	gdouble returnValue = (gdouble)g_settings_get_double((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gint)enumWithKey:(OFString*)key
{
	gint returnValue = (gint)g_settings_get_enum((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (guint)flagsWithKey:(OFString*)key
{
	guint returnValue = (guint)g_settings_get_flags((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (bool)hasUnapplied
{
	bool returnValue = (bool)g_settings_get_has_unapplied((GSettings*)[self castedGObject]);

	return returnValue;
}

- (gint)intWithKey:(OFString*)key
{
	gint returnValue = (gint)g_settings_get_int((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gint64)int64WithKey:(OFString*)key
{
	gint64 returnValue = (gint64)g_settings_get_int64((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (gpointer)mappedWithKey:(OFString*)key mapping:(GSettingsGetMapping)mapping userData:(gpointer)userData
{
	gpointer returnValue = (gpointer)g_settings_get_mapped((GSettings*)[self castedGObject], [key UTF8String], mapping, userData);

	return returnValue;
}

- (GVariant*)rangeWithKey:(OFString*)key
{
	GVariant* returnValue = (GVariant*)g_settings_get_range((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (OFString*)stringWithKey:(OFString*)key
{
	gchar* gobjectValue = g_settings_get_string((GSettings*)[self castedGObject], [key UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (gchar**)strvWithKey:(OFString*)key
{
	gchar** returnValue = (gchar**)g_settings_get_strv((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (guint)uintWithKey:(OFString*)key
{
	guint returnValue = (guint)g_settings_get_uint((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (guint64)uint64WithKey:(OFString*)key
{
	guint64 returnValue = (guint64)g_settings_get_uint64((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (GVariant*)userValueWithKey:(OFString*)key
{
	GVariant* returnValue = (GVariant*)g_settings_get_user_value((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (GVariant*)valueWithKey:(OFString*)key
{
	GVariant* returnValue = (GVariant*)g_settings_get_value((GSettings*)[self castedGObject], [key UTF8String]);

	return returnValue;
}

- (bool)isWritableWithName:(OFString*)name
{
	bool returnValue = (bool)g_settings_is_writable((GSettings*)[self castedGObject], [name UTF8String]);

	return returnValue;
}

- (gchar**)listChildren
{
	gchar** returnValue = (gchar**)g_settings_list_children((GSettings*)[self castedGObject]);

	return returnValue;
}

- (gchar**)listKeys
{
	gchar** returnValue = (gchar**)g_settings_list_keys((GSettings*)[self castedGObject]);

	return returnValue;
}

- (bool)rangeCheckWithKey:(OFString*)key value:(GVariant*)value
{
	bool returnValue = (bool)g_settings_range_check((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (void)resetWithKey:(OFString*)key
{
	g_settings_reset((GSettings*)[self castedGObject], [key UTF8String]);
}

- (void)revert
{
	g_settings_revert((GSettings*)[self castedGObject]);
}

- (bool)setBooleanWithKey:(OFString*)key value:(bool)value
{
	bool returnValue = (bool)g_settings_set_boolean((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setDoubleWithKey:(OFString*)key value:(gdouble)value
{
	bool returnValue = (bool)g_settings_set_double((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setEnumWithKey:(OFString*)key value:(gint)value
{
	bool returnValue = (bool)g_settings_set_enum((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setFlagsWithKey:(OFString*)key value:(guint)value
{
	bool returnValue = (bool)g_settings_set_flags((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setIntWithKey:(OFString*)key value:(gint)value
{
	bool returnValue = (bool)g_settings_set_int((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setInt64WithKey:(OFString*)key value:(gint64)value
{
	bool returnValue = (bool)g_settings_set_int64((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setStringWithKey:(OFString*)key value:(OFString*)value
{
	bool returnValue = (bool)g_settings_set_string((GSettings*)[self castedGObject], [key UTF8String], [value UTF8String]);

	return returnValue;
}

- (bool)setStrvWithKey:(OFString*)key value:(const gchar* const*)value
{
	bool returnValue = (bool)g_settings_set_strv((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setUintWithKey:(OFString*)key value:(guint)value
{
	bool returnValue = (bool)g_settings_set_uint((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setUint64WithKey:(OFString*)key value:(guint64)value
{
	bool returnValue = (bool)g_settings_set_uint64((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}

- (bool)setValueWithKey:(OFString*)key value:(GVariant*)value
{
	bool returnValue = (bool)g_settings_set_value((GSettings*)[self castedGObject], [key UTF8String], value);

	return returnValue;
}


@end