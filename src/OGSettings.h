/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixinputstream.h>
#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gunixoutputstream.h>
#include <gio/gio.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixfdmessage.h>

#import <OGObject/OGObject.h>

/**
 * The `GSettings` class provides a convenient API for storing and retrieving
 * application settings.
 * 
 * Reads and writes can be considered to be non-blocking.  Reading
 * settings with `GSettings` is typically extremely fast: on
 * approximately the same order of magnitude (but slower than) a
 * [struct@GLib.HashTable] lookup.  Writing settings is also extremely fast in
 * terms of time to return to your application, but can be extremely expensive
 * for other threads and other processes.  Many settings backends
 * (including dconf) have lazy initialisation which means in the common
 * case of the user using their computer without modifying any settings
 * a lot of work can be avoided.  For dconf, the D-Bus service doesn’t
 * even need to be started in this case.  For this reason, you should
 * only ever modify `GSettings` keys in response to explicit user action.
 * Particular care should be paid to ensure that modifications are not
 * made during startup — for example, when setting the initial value
 * of preferences widgets.  The built-in [method@Gio.Settings.bind]
 * functionality is careful not to write settings in response to notify signals
 * as a result of modifications that it makes to widgets.
 * 
 * When creating a `GSettings` instance, you have to specify a schema
 * that describes the keys in your settings and their types and default
 * values, as well as some other information.
 * 
 * Normally, a schema has a fixed path that determines where the settings
 * are stored in the conceptual global tree of settings. However, schemas
 * can also be ‘[relocatable](#relocatable-schemas)’, i.e. not equipped with
 * a fixed path. This is
 * useful e.g. when the schema describes an ‘account’, and you want to be
 * able to store a arbitrary number of accounts.
 * 
 * Paths must start with and end with a forward slash character (`/`)
 * and must not contain two sequential slash characters.  Paths should
 * be chosen based on a domain name associated with the program or
 * library to which the settings belong.  Examples of paths are
 * `/org/gtk/settings/file-chooser/` and `/ca/desrt/dconf-editor/`.
 * Paths should not start with `/apps/`, `/desktop/` or `/system/` as
 * they often did in GConf.
 * 
 * Unlike other configuration systems (like GConf), GSettings does not
 * restrict keys to basic types like strings and numbers. GSettings stores
 * values as [struct@GLib.Variant], and allows any [type@GLib.VariantType] for
 * keys. Key names are restricted to lowercase characters, numbers and `-`.
 * Furthermore, the names must begin with a lowercase character, must not end
 * with a `-`, and must not contain consecutive dashes.
 * 
 * Similar to GConf, the default values in GSettings schemas can be
 * localized, but the localized values are stored in gettext catalogs
 * and looked up with the domain that is specified in the
 * `gettext-domain` attribute of the `<schemalist>` or `<schema>`
 * elements and the category that is specified in the `l10n` attribute of
 * the `<default>` element. The string which is translated includes all text in
 * the `<default>` element, including any surrounding quotation marks.
 * 
 * The `l10n` attribute must be set to `messages` or `time`, and sets the
 * [locale category for
 * translation](https://www.gnu.org/software/gettext/manual/html_node/Aspects.html#index-locale-categories-1).
 * The `messages` category should be used by default; use `time` for
 * translatable date or time formats. A translation comment can be added as an
 * XML comment immediately above the `<default>` element — it is recommended to
 * add these comments to aid translators understand the meaning and
 * implications of the default value. An optional translation `context`
 * attribute can be set on the `<default>` element to disambiguate multiple
 * defaults which use the same string.
 * 
 * For example:
 * ```xml
 *  <!-- Translators: A list of words which are not allowed to be typed, in
 *       GVariant serialization syntax.
 *       See: https://developer.gnome.org/glib/stable/gvariant-text.html -->
 *  <default l10n='messages' context='Banned words'>['bad', 'words']</default>
 * ```
 * 
 * Translations of default values must remain syntactically valid serialized
 * [struct@GLib.Variant]s (e.g. retaining any surrounding quotation marks) or
 * runtime errors will occur.
 * 
 * GSettings uses schemas in a compact binary form that is created
 * by the [`glib-compile-schemas`](glib-compile-schemas.html)
 * utility. The input is a schema description in an XML format.
 * 
 * A DTD for the gschema XML format can be found here:
 * [gschema.dtd](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/gschema.dtd)
 * 
 * The [`glib-compile-schemas`](glib-compile-schemas.html) tool expects schema
 * files to have the extension `.gschema.xml`.
 * 
 * At runtime, schemas are identified by their ID (as specified in the
 * `id` attribute of the `<schema>` element). The convention for schema
 * IDs is to use a dotted name, similar in style to a D-Bus bus name,
 * e.g. `org.gnome.SessionManager`. In particular, if the settings are
 * for a specific service that owns a D-Bus bus name, the D-Bus bus name
 * and schema ID should match. For schemas which deal with settings not
 * associated with one named application, the ID should not use
 * StudlyCaps, e.g. `org.gnome.font-rendering`.
 * 
 * In addition to [struct@GLib.Variant] types, keys can have types that have
 * enumerated types. These can be described by a `<choice>`,
 * `<enum>` or `<flags>` element, as seen in the
 * second example below. The underlying type of such a key
 * is string, but you can use [method@Gio.Settings.get_enum],
 * [method@Gio.Settings.set_enum], [method@Gio.Settings.get_flags],
 * [method@Gio.Settings.set_flags] access the numeric values corresponding to
 * the string value of enum and flags keys.
 * 
 * An example for default value:
 * ```xml
 * <schemalist>
 *   <schema id="org.gtk.Test" path="/org/gtk/Test/" gettext-domain="test">
 * 
 *     <key name="greeting" type="s">
 *       <default l10n="messages">"Hello, earthlings"</default>
 *       <summary>A greeting</summary>
 *       <description>
 *         Greeting of the invading martians
 *       </description>
 *     </key>
 * 
 *     <key name="box" type="(ii)">
 *       <default>(20,30)</default>
 *     </key>
 * 
 *     <key name="empty-string" type="s">
 *       <default>""</default>
 *       <summary>Empty strings have to be provided in GVariant form</summary>
 *     </key>
 * 
 *   </schema>
 * </schemalist>
 * ```
 * 
 * An example for ranges, choices and enumerated types:
 * ```xml
 * <schemalist>
 * 
 *   <enum id="org.gtk.Test.myenum">
 *     <value nick="first" value="1"/>
 *     <value nick="second" value="2"/>
 *   </enum>
 * 
 *   <flags id="org.gtk.Test.myflags">
 *     <value nick="flag1" value="1"/>
 *     <value nick="flag2" value="2"/>
 *     <value nick="flag3" value="4"/>
 *   </flags>
 * 
 *   <schema id="org.gtk.Test">
 * 
 *     <key name="key-with-range" type="i">
 *       <range min="1" max="100"/>
 *       <default>10</default>
 *     </key>
 * 
 *     <key name="key-with-choices" type="s">
 *       <choices>
 *         <choice value='Elisabeth'/>
 *         <choice value='Annabeth'/>
 *         <choice value='Joe'/>
 *       </choices>
 *       <aliases>
 *         <alias value='Anna' target='Annabeth'/>
 *         <alias value='Beth' target='Elisabeth'/>
 *       </aliases>
 *       <default>'Joe'</default>
 *     </key>
 * 
 *     <key name='enumerated-key' enum='org.gtk.Test.myenum'>
 *       <default>'first'</default>
 *     </key>
 * 
 *     <key name='flags-key' flags='org.gtk.Test.myflags'>
 *       <default>["flag1","flag2"]</default>
 *     </key>
 *   </schema>
 * </schemalist>
 * ```
 * 
 * ## Vendor overrides
 * 
 * Default values are defined in the schemas that get installed by
 * an application. Sometimes, it is necessary for a vendor or distributor
 * to adjust these defaults. Since patching the XML source for the schema
 * is inconvenient and error-prone,
 * [`glib-compile-schemas`](glib-compile-schemas.html) reads so-called ‘vendor
 * override’ files. These are keyfiles in the same directory as the XML
 * schema sources which can override default values. The schema ID serves
 * as the group name in the key file, and the values are expected in
 * serialized [struct@GLib.Variant] form, as in the following example:
 * ```
 * [org.gtk.Example]
 * key1='string'
 * key2=1.5
 * ```
 * 
 * `glib-compile-schemas` expects schema files to have the extension
 * `.gschema.override`.
 * 
 * ## Binding
 * 
 * A very convenient feature of GSettings lets you bind [class@GObject.Object]
 * properties directly to settings, using [method@Gio.Settings.bind]. Once a
 * [class@GObject.Object] property has been bound to a setting, changes on
 * either side are automatically propagated to the other side. GSettings handles
 * details like mapping between [class@GObject.Object] and [struct@GLib.Variant]
 * types, and preventing infinite cycles.
 * 
 * This makes it very easy to hook up a preferences dialog to the
 * underlying settings. To make this even more convenient, GSettings
 * looks for a boolean property with the name `sensitivity` and
 * automatically binds it to the writability of the bound setting.
 * If this ‘magic’ gets in the way, it can be suppressed with the
 * `G_SETTINGS_BIND_NO_SENSITIVITY` flag.
 * 
 * ## Relocatable schemas
 * 
 * A relocatable schema is one with no `path` attribute specified on its
 * `<schema>` element. By using [ctor@Gio.Settings.new_with_path], a `GSettings`
 * object can be instantiated for a relocatable schema, assigning a path to the
 * instance. Paths passed to [ctor@Gio.Settings.new_with_path] will typically be
 * constructed dynamically from a constant prefix plus some form of instance
 * identifier; but they must still be valid GSettings paths. Paths could also
 * be constant and used with a globally installed schema originating from a
 * dependency library.
 * 
 * For example, a relocatable schema could be used to store geometry information
 * for different windows in an application. If the schema ID was
 * `org.foo.MyApp.Window`, it could be instantiated for paths
 * `/org/foo/MyApp/main/`, `/org/foo/MyApp/document-1/`,
 * `/org/foo/MyApp/document-2/`, etc. If any of the paths are well-known
 * they can be specified as `<child>` elements in the parent schema, e.g.:
 * ```xml
 * <schema id="org.foo.MyApp" path="/org/foo/MyApp/">
 *   <child name="main" schema="org.foo.MyApp.Window"/>
 * </schema>
 * ```
 * 
 * ## Build system integration
 * 
 * GSettings comes with autotools integration to simplify compiling and
 * installing schemas. To add GSettings support to an application, add the
 * following to your `configure.ac`:
 * ```
 * GLIB_GSETTINGS
 * ```
 * 
 * In the appropriate `Makefile.am`, use the following snippet to compile and
 * install the named schema:
 * ```
 * gsettings_SCHEMAS = org.foo.MyApp.gschema.xml
 * EXTRA_DIST = $(gsettings_SCHEMAS)
 * 
 * @GSETTINGS_RULES@
 * ```
 * 
 * No changes are needed to the build system to mark a schema XML file for
 * translation. Assuming it sets the `gettext-domain` attribute, a schema may
 * be marked for translation by adding it to `POTFILES.in`, assuming gettext
 * 0.19 is in use (the preferred method for translation):
 * ```
 * data/org.foo.MyApp.gschema.xml
 * ```
 * 
 * Alternatively, if intltool 0.50.1 is in use:
 * ```
 * [type: gettext/gsettings]data/org.foo.MyApp.gschema.xml
 * ```
 * 
 * GSettings will use gettext to look up translations for the `<summary>` and
 * `<description>` elements, and also any `<default>` elements which have a
 * `l10n` attribute set. Translations must not be included in the `.gschema.xml`
 * file by the build system, for example by using intltool XML rules with a
 * `.gschema.xml.in` template.
 * 
 * If an enumerated type defined in a C header file is to be used in a GSettings
 * schema, it can either be defined manually using an `<enum>` element in the
 * schema XML, or it can be extracted automatically from the C header. This
 * approach is preferred, as it ensures the two representations are always
 * synchronised. To do so, add the following to the relevant `Makefile.am`:
 * ```
 * gsettings_ENUM_NAMESPACE = org.foo.MyApp
 * gsettings_ENUM_FILES = my-app-enums.h my-app-misc.h
 * ```
 * 
 * `gsettings_ENUM_NAMESPACE` specifies the schema namespace for the enum files,
 * which are specified in `gsettings_ENUM_FILES`. This will generate a
 * `org.foo.MyApp.enums.xml` file containing the extracted enums, which will be
 * automatically included in the schema compilation, install and uninstall
 * rules. It should not be committed to version control or included in
 * `EXTRA_DIST`.
 *
 */
@interface OGSettings : OGObject
{

}

/**
 * Functions
 */
+ (void)load;


/**
 * Use g_settings_schema_source_list_schemas() instead
 *
 * @return a list of
 *   relocatable #GSettings schemas that are available, in no defined order.
 *   The list must not be modified or freed.
 */
+ (const gchar* const*)listRelocatableSchemas;

/**
 * Use g_settings_schema_source_list_schemas() instead.
 * If you used g_settings_list_schemas() to check for the presence of
 * a particular schema, use g_settings_schema_source_lookup() instead
 * of your whole loop.
 *
 * @return a list of
 *   #GSettings schemas that are available, in no defined order.  The list
 *   must not be modified or freed.
 */
+ (const gchar* const*)listSchemas;

/**
 * Ensures that all pending operations are complete for the default backend.
 * 
 * Writes made to a #GSettings are handled asynchronously.  For this
 * reason, it is very unlikely that the changes have it to disk by the
 * time g_settings_set() returns.
 * 
 * This call will block until all of the writes have made it to the
 * backend.  Since the mainloop is not running, no change notifications
 * will be dispatched during this call (but some may be queued by the
 * time the call is done).
 *
 */
+ (void)sync;

/**
 * Removes an existing binding for @property on @object.
 * 
 * Note that bindings are automatically removed when the
 * object is finalized, so it is rarely necessary to call this
 * function.
 *
 * @param object the object
 * @param property the property whose binding is removed
 */
+ (void)unbindWithObject:(gpointer)object property:(OFString*)property;

/**
 * Constructors
 */
+ (instancetype)settings:(OFString*)schemaId;
+ (instancetype)settingsFullWithSchema:(GSettingsSchema*)schema backend:(GSettingsBackend*)backend path:(OFString*)path;
+ (instancetype)settingsWithBackendWithSchemaId:(OFString*)schemaId backend:(GSettingsBackend*)backend;
+ (instancetype)settingsWithBackendAndPathWithSchemaId:(OFString*)schemaId backend:(GSettingsBackend*)backend path:(OFString*)path;
+ (instancetype)settingsWithPathWithSchemaId:(OFString*)schemaId path:(OFString*)path;

/**
 * Methods
 */

- (GSettings*)castedGObject;

/**
 * Applies any changes that have been made to the settings.  This
 * function does nothing unless @settings is in 'delay-apply' mode;
 * see g_settings_delay().  In the normal case settings are always
 * applied immediately.
 *
 */
- (void)apply;

/**
 * Create a binding between the @key in the @settings object
 * and the property @property of @object.
 * 
 * The binding uses the default GIO mapping functions to map
 * between the settings and property values. These functions
 * handle booleans, numeric types and string types in a
 * straightforward way. Use g_settings_bind_with_mapping() if
 * you need a custom mapping, or map between types that are not
 * supported by the default mapping functions.
 * 
 * Unless the @flags include %G_SETTINGS_BIND_NO_SENSITIVITY, this
 * function also establishes a binding between the writability of
 * @key and the "sensitive" property of @object (if @object has
 * a boolean property by that name). See g_settings_bind_writable()
 * for more details about writable bindings.
 * 
 * Note that the lifecycle of the binding is tied to @object,
 * and that you can have only one binding per object property.
 * If you bind the same property twice on the same object, the second
 * binding overrides the first one.
 *
 * @param key the key to bind
 * @param object a #GObject
 * @param property the name of the property to bind
 * @param flags flags for the binding
 */
- (void)bindWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property flags:(GSettingsBindFlags)flags;

/**
 * Create a binding between the @key in the @settings object
 * and the property @property of @object.
 * 
 * The binding uses the provided mapping functions to map between
 * settings and property values.
 * 
 * Note that the lifecycle of the binding is tied to @object,
 * and that you can have only one binding per object property.
 * If you bind the same property twice on the same object, the second
 * binding overrides the first one.
 *
 * @param key the key to bind
 * @param object a #GObject
 * @param property the name of the property to bind
 * @param flags flags for the binding
 * @param getMapping a function that gets called to convert values
 *     from @settings to @object, or %NULL to use the default GIO mapping
 * @param setMapping a function that gets called to convert values
 *     from @object to @settings, or %NULL to use the default GIO mapping
 * @param userData data that gets passed to @get_mapping and @set_mapping
 * @param destroy #GDestroyNotify function for @user_data
 */
- (void)bindWithMappingWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property flags:(GSettingsBindFlags)flags getMapping:(GSettingsBindGetMapping)getMapping setMapping:(GSettingsBindSetMapping)setMapping userData:(gpointer)userData destroy:(GDestroyNotify)destroy;

/**
 * Create a binding between the writability of @key in the
 * @settings object and the property @property of @object.
 * The property must be boolean; "sensitive" or "visible"
 * properties of widgets are the most likely candidates.
 * 
 * Writable bindings are always uni-directional; changes of the
 * writability of the setting will be propagated to the object
 * property, not the other way.
 * 
 * When the @inverted argument is %TRUE, the binding inverts the
 * value as it passes from the setting to the object, i.e. @property
 * will be set to %TRUE if the key is not writable.
 * 
 * Note that the lifecycle of the binding is tied to @object,
 * and that you can have only one binding per object property.
 * If you bind the same property twice on the same object, the second
 * binding overrides the first one.
 *
 * @param key the key to bind
 * @param object a #GObject
 * @param property the name of a boolean property to bind
 * @param inverted whether to 'invert' the value
 */
- (void)bindWritableWithKey:(OFString*)key object:(gpointer)object property:(OFString*)property inverted:(bool)inverted;

/**
 * Creates a #GAction corresponding to a given #GSettings key.
 * 
 * The action has the same name as the key.
 * 
 * The value of the key becomes the state of the action and the action
 * is enabled when the key is writable.  Changing the state of the
 * action results in the key being written to.  Changes to the value or
 * writability of the key cause appropriate change notifications to be
 * emitted for the action.
 * 
 * For boolean-valued keys, action activations take no parameter and
 * result in the toggling of the value.  For all other types,
 * activations take the new value for the key (which must have the
 * correct type).
 *
 * @param key the name of a key in @settings
 * @return a new #GAction
 */
- (GAction*)createAction:(OFString*)key;

/**
 * Changes the #GSettings object into 'delay-apply' mode. In this
 * mode, changes to @settings are not immediately propagated to the
 * backend, but kept locally until g_settings_apply() is called.
 *
 */
- (void)delay;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for booleans.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a boolean type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return a boolean
 */
- (bool)boolean:(OFString*)key;

/**
 * Creates a child settings object which has a base path of
 * `base-path/@name`, where `base-path` is the base path of
 * @settings.
 * 
 * The schema for the child settings object must have been declared
 * in the schema of @settings using a `<child>` element.
 * 
 * The created child settings object will inherit the #GSettings:delay-apply
 * mode from @settings.
 *
 * @param name the name of the child schema
 * @return a 'child' settings object
 */
- (OGSettings*)child:(OFString*)name;

/**
 * Gets the "default value" of a key.
 * 
 * This is the value that would be read if g_settings_reset() were to be
 * called on the key.
 * 
 * Note that this may be a different value than returned by
 * g_settings_schema_key_get_default_value() if the system administrator
 * has provided a default value.
 * 
 * Comparing the return values of g_settings_get_default_value() and
 * g_settings_get_value() is not sufficient for determining if a value
 * has been set because the user may have explicitly set the value to
 * something that happens to be equal to the default.  The difference
 * here is that if the default changes in the future, the user's key
 * will still be set.
 * 
 * This function may be useful for adding an indication to a UI of what
 * the default value was before the user set it.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings.
 *
 * @param key the key to get the default value for
 * @return the default value
 */
- (GVariant*)defaultValue:(OFString*)key;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for doubles.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a 'double' type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return a double
 */
- (gdouble)double:(OFString*)key;

/**
 * Gets the value that is stored in @settings for @key and converts it
 * to the enum value that it represents.
 * 
 * In order to use this function the type of the value must be a string
 * and it must be marked in the schema file as an enumerated type.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings or is not marked as an enumerated type.
 * 
 * If the value stored in the configuration database is not a valid
 * value for the enumerated type then this function will return the
 * default value.
 *
 * @param key the key to get the value for
 * @return the enum value
 */
- (gint)enum:(OFString*)key;

/**
 * Gets the value that is stored in @settings for @key and converts it
 * to the flags value that it represents.
 * 
 * In order to use this function the type of the value must be an array
 * of strings and it must be marked in the schema file as a flags type.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings or is not marked as a flags type.
 * 
 * If the value stored in the configuration database is not a valid
 * value for the flags type then this function will return the default
 * value.
 *
 * @param key the key to get the value for
 * @return the flags value
 */
- (guint)flags:(OFString*)key;

/**
 * Returns whether the #GSettings object has any unapplied
 * changes.  This can only be the case if it is in 'delayed-apply' mode.
 *
 * @return %TRUE if @settings has unapplied changes
 */
- (bool)hasUnapplied;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for 32-bit integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a int32 type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return an integer
 */
- (gint)int:(OFString*)key;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for 64-bit integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a int64 type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return a 64-bit integer
 */
- (gint64)int64:(OFString*)key;

/**
 * Gets the value that is stored at @key in @settings, subject to
 * application-level validation/mapping.
 * 
 * You should use this function when the application needs to perform
 * some processing on the value of the key (for example, parsing).  The
 * @mapping function performs that processing.  If the function
 * indicates that the processing was unsuccessful (due to a parse error,
 * for example) then the mapping is tried again with another value.
 * 
 * This allows a robust 'fall back to defaults' behaviour to be
 * implemented somewhat automatically.
 * 
 * The first value that is tried is the user's setting for the key.  If
 * the mapping function fails to map this value, other values may be
 * tried in an unspecified order (system or site defaults, translated
 * schema default values, untranslated schema default values, etc).
 * 
 * If the mapping function fails for all possible values, one additional
 * attempt is made: the mapping function is called with a %NULL value.
 * If the mapping function still indicates failure at this point then
 * the application will be aborted.
 * 
 * The result parameter for the @mapping function is pointed to a
 * #gpointer which is initially set to %NULL.  The same pointer is given
 * to each invocation of @mapping.  The final value of that #gpointer is
 * what is returned by this function.  %NULL is valid; it is returned
 * just as any other value would be.
 *
 * @param key the key to get the value for
 * @param mapping the function to map the value in the
 *           settings database to the value used by the application
 * @param userData user data for @mapping
 * @return the result, which may be %NULL
 */
- (gpointer)mappedWithKey:(OFString*)key mapping:(GSettingsGetMapping)mapping userData:(gpointer)userData;

/**
 * Queries the range of a key.
 *
 * @param key the key to query the range of
 * @return
 */
- (GVariant*)range:(OFString*)key;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for strings.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a string type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return a newly-allocated string
 */
- (OFString*)string:(OFString*)key;

/**
 * A convenience variant of g_settings_get() for string arrays.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having an array of strings type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return a
 * newly-allocated, %NULL-terminated array of strings, the value that
 * is stored at @key in @settings.
 */
- (gchar**)strv:(OFString*)key;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for 32-bit unsigned
 * integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a uint32 type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return an unsigned integer
 */
- (guint)uint:(OFString*)key;

/**
 * Gets the value that is stored at @key in @settings.
 * 
 * A convenience variant of g_settings_get() for 64-bit unsigned
 * integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a uint64 type in the schema for @settings.
 *
 * @param key the key to get the value for
 * @return a 64-bit unsigned integer
 */
- (guint64)uint64:(OFString*)key;

/**
 * Checks the "user value" of a key, if there is one.
 * 
 * The user value of a key is the last value that was set by the user.
 * 
 * After calling g_settings_reset() this function should always return
 * %NULL (assuming something is not wrong with the system
 * configuration).
 * 
 * It is possible that g_settings_get_value() will return a different
 * value than this function.  This can happen in the case that the user
 * set a value for a key that was subsequently locked down by the system
 * administrator -- this function will return the user's old value.
 * 
 * This function may be useful for adding a "reset" option to a UI or
 * for providing indication that a particular value has been changed.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings.
 *
 * @param key the key to get the user value for
 * @return the user's value, if set
 */
- (GVariant*)userValue:(OFString*)key;

/**
 * Gets the value that is stored in @settings for @key.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings.
 *
 * @param key the key to get the value for
 * @return a new #GVariant
 */
- (GVariant*)value:(OFString*)key;

/**
 * Finds out if a key can be written or not
 *
 * @param name the name of a key
 * @return %TRUE if the key @name is writable
 */
- (bool)isWritable:(OFString*)name;

/**
 * Gets the list of children on @settings.
 * 
 * The list is exactly the list of strings for which it is not an error
 * to call g_settings_get_child().
 * 
 * There is little reason to call this function from "normal" code, since
 * you should already know what children are in your schema. This function
 * may still be useful there for introspection reasons, however.
 * 
 * You should free the return value with g_strfreev() when you are done
 * with it.
 *
 * @return a list of the children
 *    on @settings, in no defined order
 */
- (gchar**)listChildren;

/**
 * Introspects the list of keys on @settings.
 * 
 * You should probably not be calling this function from "normal" code
 * (since you should already know what keys are in your schema).  This
 * function is intended for introspection reasons.
 * 
 * You should free the return value with g_strfreev() when you are done
 * with it.
 *
 * @return a list
 *    of the keys on @settings, in no defined order
 */
- (gchar**)listKeys;

/**
 * Checks if the given @value is of the correct type and within the
 * permitted range for @key.
 *
 * @param key the key to check
 * @param value the value to check
 * @return %TRUE if @value is valid for @key
 */
- (bool)rangeCheckWithKey:(OFString*)key value:(GVariant*)value;

/**
 * Resets @key to its default value.
 * 
 * This call resets the key, as much as possible, to its default value.
 * That might be the value specified in the schema or the one set by the
 * administrator.
 *
 * @param key the name of a key
 */
- (void)reset:(OFString*)key;

/**
 * Reverts all non-applied changes to the settings.  This function
 * does nothing unless @settings is in 'delay-apply' mode; see
 * g_settings_delay().  In the normal case settings are always applied
 * immediately.
 * 
 * Change notifications will be emitted for affected keys.
 *
 */
- (void)revert;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for booleans.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a boolean type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setBooleanWithKey:(OFString*)key value:(bool)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for doubles.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a 'double' type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setDoubleWithKey:(OFString*)key value:(gdouble)value;

/**
 * Looks up the enumerated type nick for @value and writes it to @key,
 * within @settings.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings or is not marked as an enumerated type, or for
 * @value not to be a valid value for the named type.
 * 
 * After performing the write, accessing @key directly with
 * g_settings_get_string() will return the 'nick' associated with
 * @value.
 *
 * @param key a key, within @settings
 * @param value an enumerated value
 * @return %TRUE, if the set succeeds
 */
- (bool)setEnumWithKey:(OFString*)key value:(gint)value;

/**
 * Looks up the flags type nicks for the bits specified by @value, puts
 * them in an array of strings and writes the array to @key, within
 * @settings.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings or is not marked as a flags type, or for @value
 * to contain any bits that are not value for the named type.
 * 
 * After performing the write, accessing @key directly with
 * g_settings_get_strv() will return an array of 'nicks'; one for each
 * bit in @value.
 *
 * @param key a key, within @settings
 * @param value a flags value
 * @return %TRUE, if the set succeeds
 */
- (bool)setFlagsWithKey:(OFString*)key value:(guint)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for 32-bit integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a int32 type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setIntWithKey:(OFString*)key value:(gint)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for 64-bit integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a int64 type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setInt64WithKey:(OFString*)key value:(gint64)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for strings.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a string type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setStringWithKey:(OFString*)key value:(OFString*)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for string arrays.  If
 * @value is %NULL, then @key is set to be the empty array.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having an array of strings type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to, or %NULL
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setStrvWithKey:(OFString*)key value:(const gchar* const*)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for 32-bit unsigned
 * integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a uint32 type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setUintWithKey:(OFString*)key value:(guint)value;

/**
 * Sets @key in @settings to @value.
 * 
 * A convenience variant of g_settings_set() for 64-bit unsigned
 * integers.
 * 
 * It is a programmer error to give a @key that isn't specified as
 * having a uint64 type in the schema for @settings.
 *
 * @param key the name of the key to set
 * @param value the value to set it to
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setUint64WithKey:(OFString*)key value:(guint64)value;

/**
 * Sets @key in @settings to @value.
 * 
 * It is a programmer error to give a @key that isn't contained in the
 * schema for @settings or for @value to have the incorrect type, per
 * the schema.
 * 
 * If @value is floating then this function consumes the reference.
 *
 * @param key the name of the key to set
 * @param value a #GVariant of the correct type
 * @return %TRUE if setting the key succeeded,
 *     %FALSE if the key was not writable
 */
- (bool)setValueWithKey:(OFString*)key value:(GVariant*)value;

@end