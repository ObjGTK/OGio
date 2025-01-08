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
 * Stores information about a file system object referenced by a [iface@Gio.File].
 * 
 * Functionality for manipulating basic metadata for files. `GFileInfo`
 * implements methods for getting information that all files should
 * contain, and allows for manipulation of extended attributes.
 * 
 * See [file-attributes.html](file attributes) for more information on how GIO
 * handles file attributes.
 * 
 * To obtain a `GFileInfo` for a [iface@Gio.File], use
 * [method@Gio.File.query_info] (or its async variant). To obtain a `GFileInfo`
 * for a file input or output stream, use [method@Gio.FileInputStream.query_info]
 * or [method@Gio.FileOutputStream.query_info] (or their async variants).
 * 
 * To change the actual attributes of a file, you should then set the
 * attribute in the `GFileInfo` and call [method@Gio.File.set_attributes_from_info]
 * or [method@Gio.File.set_attributes_async] on a `GFile`.
 * 
 * However, not all attributes can be changed in the file. For instance,
 * the actual size of a file cannot be changed via [method@Gio.FileInfo.set_size].
 * You may call [method@Gio.File.query_settable_attributes] and
 * [method@Gio.File.query_writable_namespaces] to discover the settable attributes
 * of a particular file at runtime.
 * 
 * The direct accessors, such as [method@Gio.FileInfo.get_name], are slightly more
 * optimized than the generic attribute accessors, such as
 * [method@Gio.FileInfo.get_attribute_byte_string].This optimization will matter
 * only if calling the API in a tight loop.
 * 
 * It is an error to call these accessors without specifying their required file
 * attributes when creating the `GFileInfo`. Use
 * [method@Gio.FileInfo.has_attribute] or [method@Gio.FileInfo.list_attributes]
 * to check what attributes are specified for a `GFileInfo`.
 * 
 * [struct@Gio.FileAttributeMatcher] allows for searching through a `GFileInfo`
 * for attributes.
 *
 */
@interface OGFileInfo : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)init;

/**
 * Methods
 */

- (GFileInfo*)castedGObject;

/**
 * Clears the status information from @info.
 *
 */
- (void)clearStatus;

/**
 * First clears all of the [GFileAttribute][gio-GFileAttribute] of @dest_info,
 * and then copies all of the file attributes from @src_info to @dest_info.
 *
 * @param destInfo destination to copy attributes to.
 */
- (void)copyInto:(OGFileInfo*)destInfo;

/**
 * Duplicates a file info structure.
 *
 * @return a duplicate #GFileInfo of @other.
 */
- (OGFileInfo*)dup;

/**
 * Gets the access time of the current @info and returns it as a
 * #GDateTime.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_TIME_ACCESS. If %G_FILE_ATTRIBUTE_TIME_ACCESS_USEC is
 * provided, the resulting #GDateTime will additionally have microsecond
 * precision.
 * 
 * If nanosecond precision is needed, %G_FILE_ATTRIBUTE_TIME_ACCESS_NSEC must
 * be queried separately using g_file_info_get_attribute_uint32().
 *
 * @return access time, or %NULL if unknown
 */
- (GDateTime*)accessDateTime;

/**
 * Gets the value of an attribute, formatted as a string.
 * This escapes things as needed to make the string valid
 * UTF-8.
 *
 * @param attribute a file attribute key.
 * @return a UTF-8 string associated with the given @attribute, or
 *    %NULL if the attribute wasn’t set.
 *    When you're done with the string it must be freed with g_free().
 */
- (char*)attributeAsString:(OFString*)attribute;

/**
 * Gets the value of a boolean attribute. If the attribute does not
 * contain a boolean value, %FALSE will be returned.
 *
 * @param attribute a file attribute key.
 * @return the boolean value contained within the attribute.
 */
- (bool)attributeBoolean:(OFString*)attribute;

/**
 * Gets the value of a byte string attribute. If the attribute does
 * not contain a byte string, %NULL will be returned.
 *
 * @param attribute a file attribute key.
 * @return the contents of the @attribute value as a byte string, or
 * %NULL otherwise.
 */
- (OFString*)attributeByteString:(OFString*)attribute;

/**
 * Gets the attribute type, value and status for an attribute key.
 *
 * @param attribute a file attribute key
 * @param type return location for the attribute type, or %NULL
 * @param valuePp return location for the
 *    attribute value, or %NULL; the attribute value will not be %NULL
 * @param status return location for the attribute status, or %NULL
 * @return %TRUE if @info has an attribute named @attribute,
 *      %FALSE otherwise.
 */
- (bool)attributeDataWithAttribute:(OFString*)attribute type:(GFileAttributeType*)type valuePp:(gpointer*)valuePp status:(GFileAttributeStatus*)status;

/**
 * Gets the value of a byte string attribute as a file path.
 * 
 * If the attribute does not contain a byte string, `NULL` will be returned.
 * 
 * This function is meant to be used by language bindings that have specific
 * handling for Unix paths.
 *
 * @param attribute a file attribute key.
 * @return the contents of the @attribute value as
 * a file path, or %NULL otherwise.
 */
- (OFString*)attributeFilePath:(OFString*)attribute;

/**
 * Gets a signed 32-bit integer contained within the attribute. If the
 * attribute does not contain a signed 32-bit integer, or is invalid,
 * 0 will be returned.
 *
 * @param attribute a file attribute key.
 * @return a signed 32-bit integer from the attribute.
 */
- (gint32)attributeInt32:(OFString*)attribute;

/**
 * Gets a signed 64-bit integer contained within the attribute. If the
 * attribute does not contain a signed 64-bit integer, or is invalid,
 * 0 will be returned.
 *
 * @param attribute a file attribute key.
 * @return a signed 64-bit integer from the attribute.
 */
- (gint64)attributeInt64:(OFString*)attribute;

/**
 * Gets the value of a #GObject attribute. If the attribute does
 * not contain a #GObject, %NULL will be returned.
 *
 * @param attribute a file attribute key.
 * @return a #GObject associated with the given @attribute,
 * or %NULL otherwise.
 */
- (GObject*)attributeObject:(OFString*)attribute;

/**
 * Gets the attribute status for an attribute key.
 *
 * @param attribute a file attribute key
 * @return a #GFileAttributeStatus for the given @attribute, or
 *    %G_FILE_ATTRIBUTE_STATUS_UNSET if the key is invalid.
 */
- (GFileAttributeStatus)attributeStatus:(OFString*)attribute;

/**
 * Gets the value of a string attribute. If the attribute does
 * not contain a string, %NULL will be returned.
 *
 * @param attribute a file attribute key.
 * @return the contents of the @attribute value as a UTF-8 string,
 * or %NULL otherwise.
 */
- (OFString*)attributeString:(OFString*)attribute;

/**
 * Gets the value of a stringv attribute. If the attribute does
 * not contain a stringv, %NULL will be returned.
 *
 * @param attribute a file attribute key.
 * @return the contents of the @attribute value as a stringv,
 * or %NULL otherwise. Do not free. These returned strings are UTF-8.
 */
- (char**)attributeStringv:(OFString*)attribute;

/**
 * Gets the attribute type for an attribute key.
 *
 * @param attribute a file attribute key.
 * @return a #GFileAttributeType for the given @attribute, or
 * %G_FILE_ATTRIBUTE_TYPE_INVALID if the key is not set.
 */
- (GFileAttributeType)attributeType:(OFString*)attribute;

/**
 * Gets an unsigned 32-bit integer contained within the attribute. If the
 * attribute does not contain an unsigned 32-bit integer, or is invalid,
 * 0 will be returned.
 *
 * @param attribute a file attribute key.
 * @return an unsigned 32-bit integer from the attribute.
 */
- (guint32)attributeUint32:(OFString*)attribute;

/**
 * Gets a unsigned 64-bit integer contained within the attribute. If the
 * attribute does not contain an unsigned 64-bit integer, or is invalid,
 * 0 will be returned.
 *
 * @param attribute a file attribute key.
 * @return a unsigned 64-bit integer from the attribute.
 */
- (guint64)attributeUint64:(OFString*)attribute;

/**
 * Gets the file's content type.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE.
 *
 * @return a string containing the file's content type,
 * or %NULL if unknown.
 */
- (OFString*)contentType;

/**
 * Gets the creation time of the current @info and returns it as a
 * #GDateTime.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_TIME_CREATED. If %G_FILE_ATTRIBUTE_TIME_CREATED_USEC is
 * provided, the resulting #GDateTime will additionally have microsecond
 * precision.
 * 
 * If nanosecond precision is needed, %G_FILE_ATTRIBUTE_TIME_CREATED_NSEC must
 * be queried separately using g_file_info_get_attribute_uint32().
 *
 * @return creation time, or %NULL if unknown
 */
- (GDateTime*)creationDateTime;

/**
 * Returns the #GDateTime representing the deletion date of the file, as
 * available in %G_FILE_ATTRIBUTE_TRASH_DELETION_DATE. If the
 * %G_FILE_ATTRIBUTE_TRASH_DELETION_DATE attribute is unset, %NULL is returned.
 *
 * @return a #GDateTime, or %NULL.
 */
- (GDateTime*)deletionDate;

/**
 * Gets a display name for a file. This is guaranteed to always be set.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME.
 *
 * @return a string containing the display name.
 */
- (OFString*)displayName;

/**
 * Gets the edit name for a file.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_EDIT_NAME.
 *
 * @return a string containing the edit name.
 */
- (OFString*)editName;

/**
 * Gets the [entity tag](iface.File.html#entity-tags) for a given
 * #GFileInfo. See %G_FILE_ATTRIBUTE_ETAG_VALUE.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_ETAG_VALUE.
 *
 * @return a string containing the value of the "etag:value" attribute.
 */
- (OFString*)etag;

/**
 * Gets a file's type (whether it is a regular file, symlink, etc).
 * This is different from the file's content type, see g_file_info_get_content_type().
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_TYPE.
 *
 * @return a #GFileType for the given file.
 */
- (GFileType)fileType;

/**
 * Gets the icon for a file.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_ICON.
 *
 * @return #GIcon for the given @info.
 */
- (GIcon*)icon;

/**
 * Checks if a file is a backup file.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_IS_BACKUP.
 *
 * @return %TRUE if file is a backup file, %FALSE otherwise.
 */
- (bool)isBackup;

/**
 * Checks if a file is hidden.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN.
 *
 * @return %TRUE if the file is a hidden file, %FALSE otherwise.
 */
- (bool)isHidden;

/**
 * Checks if a file is a symlink.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK.
 *
 * @return %TRUE if the given @info is a symlink.
 */
- (bool)isSymlink;

/**
 * Gets the modification time of the current @info and returns it as a
 * #GDateTime.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_TIME_MODIFIED. If %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC is
 * provided, the resulting #GDateTime will additionally have microsecond
 * precision.
 * 
 * If nanosecond precision is needed, %G_FILE_ATTRIBUTE_TIME_MODIFIED_NSEC must
 * be queried separately using g_file_info_get_attribute_uint32().
 *
 * @return modification time, or %NULL if unknown
 */
- (GDateTime*)modificationDateTime;

/**
 * Gets the modification time of the current @info and sets it
 * in @result.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_TIME_MODIFIED. If %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC is
 * provided it will be used too.
 *
 * @param result a #GTimeVal.
 */
- (void)modificationTime:(GTimeVal*)result;

/**
 * Gets the name for a file. This is guaranteed to always be set.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_NAME.
 *
 * @return a string containing the file name.
 */
- (OFString*)name;

/**
 * Gets the file's size (in bytes). The size is retrieved through the value of
 * the %G_FILE_ATTRIBUTE_STANDARD_SIZE attribute and is converted
 * from #guint64 to #goffset before returning the result.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_SIZE.
 *
 * @return a #goffset containing the file's size (in bytes).
 */
- (goffset)size;

/**
 * Gets the value of the sort_order attribute from the #GFileInfo.
 * See %G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER.
 *
 * @return a #gint32 containing the value of the "standard::sort_order" attribute.
 */
- (gint32)sortOrder;

/**
 * Gets the symbolic icon for a file.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON.
 *
 * @return #GIcon for the given @info.
 */
- (GIcon*)symbolicIcon;

/**
 * Gets the symlink target for a given #GFileInfo.
 * 
 * It is an error to call this if the #GFileInfo does not contain
 * %G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET.
 *
 * @return a string containing the symlink target.
 */
- (OFString*)symlinkTarget;

/**
 * Checks if a file info structure has an attribute named @attribute.
 *
 * @param attribute a file attribute key.
 * @return %TRUE if @info has an attribute named @attribute,
 *     %FALSE otherwise.
 */
- (bool)hasAttribute:(OFString*)attribute;

/**
 * Checks if a file info structure has an attribute in the
 * specified @name_space.
 *
 * @param nameSpace a file attribute namespace.
 * @return %TRUE if @info has an attribute in @name_space,
 *     %FALSE otherwise.
 */
- (bool)hasNamespace:(OFString*)nameSpace;

/**
 * Lists the file info structure's attributes.
 *
 * @param nameSpace a file attribute key's namespace, or %NULL to list
 *   all attributes.
 * @return a
 * null-terminated array of strings of all of the possible attribute
 * types for the given @name_space, or %NULL on error.
 */
- (char**)listAttributes:(OFString*)nameSpace;

/**
 * Removes all cases of @attribute from @info if it exists.
 *
 * @param attribute a file attribute key.
 */
- (void)removeAttribute:(OFString*)attribute;

/**
 * Sets the %G_FILE_ATTRIBUTE_TIME_ACCESS and
 * %G_FILE_ATTRIBUTE_TIME_ACCESS_USEC attributes in the file info to the
 * given date/time value.
 * 
 * %G_FILE_ATTRIBUTE_TIME_ACCESS_NSEC will be cleared.
 *
 * @param atime a #GDateTime.
 */
- (void)setAccessDateTime:(GDateTime*)atime;

/**
 * Sets the @attribute to contain the given value, if possible. To unset the
 * attribute, use %G_FILE_ATTRIBUTE_TYPE_INVALID for @type.
 *
 * @param attribute a file attribute key.
 * @param type a #GFileAttributeType
 * @param valueP pointer to the value
 */
- (void)setAttributeWithAttribute:(OFString*)attribute type:(GFileAttributeType)type valueP:(gpointer)valueP;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue a boolean value.
 */
- (void)setAttributeBooleanWithAttribute:(OFString*)attribute attrValue:(bool)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue a byte string.
 */
- (void)setAttributeByteStringWithAttribute:(OFString*)attribute attrValue:(OFString*)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 * 
 * This function is meant to be used by language bindings that have specific
 * handling for Unix paths.
 *
 * @param attribute a file attribute key.
 * @param attrValue a file path.
 */
- (void)setAttributeFilePathWithAttribute:(OFString*)attribute attrValue:(OFString*)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue a signed 32-bit integer
 */
- (void)setAttributeInt32WithAttribute:(OFString*)attribute attrValue:(gint32)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute attribute name to set.
 * @param attrValue int64 value to set attribute to.
 */
- (void)setAttributeInt64WithAttribute:(OFString*)attribute attrValue:(gint64)attrValue;

/**
 * Sets @mask on @info to match specific attribute types.
 *
 * @param mask a #GFileAttributeMatcher.
 */
- (void)setAttributeMask:(GFileAttributeMatcher*)mask;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue a #GObject.
 */
- (void)setAttributeObjectWithAttribute:(OFString*)attribute attrValue:(GObject*)attrValue;

/**
 * Sets the attribute status for an attribute key. This is only
 * needed by external code that implement g_file_set_attributes_from_info()
 * or similar functions.
 * 
 * The attribute must exist in @info for this to work. Otherwise %FALSE
 * is returned and @info is unchanged.
 *
 * @param attribute a file attribute key
 * @param status a #GFileAttributeStatus
 * @return %TRUE if the status was changed, %FALSE if the key was not set.
 */
- (bool)setAttributeStatusWithAttribute:(OFString*)attribute status:(GFileAttributeStatus)status;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue a UTF-8 string.
 */
- (void)setAttributeStringWithAttribute:(OFString*)attribute attrValue:(OFString*)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 * 
 * Sinze: 2.22
 *
 * @param attribute a file attribute key
 * @param attrValue a %NULL
 *   terminated array of UTF-8 strings.
 */
- (void)setAttributeStringvWithAttribute:(OFString*)attribute attrValue:(char**)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue an unsigned 32-bit integer.
 */
- (void)setAttributeUint32WithAttribute:(OFString*)attribute attrValue:(guint32)attrValue;

/**
 * Sets the @attribute to contain the given @attr_value,
 * if possible.
 *
 * @param attribute a file attribute key.
 * @param attrValue an unsigned 64-bit integer.
 */
- (void)setAttributeUint64WithAttribute:(OFString*)attribute attrValue:(guint64)attrValue;

/**
 * Sets the content type attribute for a given #GFileInfo.
 * See %G_FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE.
 *
 * @param contentType a content type. See [GContentType][gio-GContentType]
 */
- (void)setContentType:(OFString*)contentType;

/**
 * Sets the %G_FILE_ATTRIBUTE_TIME_CREATED and
 * %G_FILE_ATTRIBUTE_TIME_CREATED_USEC attributes in the file info to the
 * given date/time value.
 * 
 * %G_FILE_ATTRIBUTE_TIME_CREATED_NSEC will be cleared.
 *
 * @param creationTime a #GDateTime.
 */
- (void)setCreationDateTime:(GDateTime*)creationTime;

/**
 * Sets the display name for the current #GFileInfo.
 * See %G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME.
 *
 * @param displayName a string containing a display name.
 */
- (void)setDisplayName:(OFString*)displayName;

/**
 * Sets the edit name for the current file.
 * See %G_FILE_ATTRIBUTE_STANDARD_EDIT_NAME.
 *
 * @param editName a string containing an edit name.
 */
- (void)setEditName:(OFString*)editName;

/**
 * Sets the file type in a #GFileInfo to @type.
 * See %G_FILE_ATTRIBUTE_STANDARD_TYPE.
 *
 * @param type a #GFileType.
 */
- (void)setFileType:(GFileType)type;

/**
 * Sets the icon for a given #GFileInfo.
 * See %G_FILE_ATTRIBUTE_STANDARD_ICON.
 *
 * @param icon a #GIcon.
 */
- (void)setIcon:(GIcon*)icon;

/**
 * Sets the "is_hidden" attribute in a #GFileInfo according to @is_hidden.
 * See %G_FILE_ATTRIBUTE_STANDARD_IS_HIDDEN.
 *
 * @param isHidden a #gboolean.
 */
- (void)setIsHidden:(bool)isHidden;

/**
 * Sets the "is_symlink" attribute in a #GFileInfo according to @is_symlink.
 * See %G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK.
 *
 * @param isSymlink a #gboolean.
 */
- (void)setIsSymlink:(bool)isSymlink;

/**
 * Sets the %G_FILE_ATTRIBUTE_TIME_MODIFIED and
 * %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC attributes in the file info to the
 * given date/time value.
 * 
 * %G_FILE_ATTRIBUTE_TIME_MODIFIED_NSEC will be cleared.
 *
 * @param mtime a #GDateTime.
 */
- (void)setModificationDateTime:(GDateTime*)mtime;

/**
 * Sets the %G_FILE_ATTRIBUTE_TIME_MODIFIED and
 * %G_FILE_ATTRIBUTE_TIME_MODIFIED_USEC attributes in the file info to the
 * given time value.
 * 
 * %G_FILE_ATTRIBUTE_TIME_MODIFIED_NSEC will be cleared.
 *
 * @param mtime a #GTimeVal.
 */
- (void)setModificationTime:(GTimeVal*)mtime;

/**
 * Sets the name attribute for the current #GFileInfo.
 * See %G_FILE_ATTRIBUTE_STANDARD_NAME.
 *
 * @param name a string containing a name.
 */
- (void)setName:(OFString*)name;

/**
 * Sets the %G_FILE_ATTRIBUTE_STANDARD_SIZE attribute in the file info
 * to the given size.
 *
 * @param size a #goffset containing the file's size.
 */
- (void)setSize:(goffset)size;

/**
 * Sets the sort order attribute in the file info structure. See
 * %G_FILE_ATTRIBUTE_STANDARD_SORT_ORDER.
 *
 * @param sortOrder a sort order integer.
 */
- (void)setSortOrder:(gint32)sortOrder;

/**
 * Sets the symbolic icon for a given #GFileInfo.
 * See %G_FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON.
 *
 * @param icon a #GIcon.
 */
- (void)setSymbolicIcon:(GIcon*)icon;

/**
 * Sets the %G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET attribute in the file info
 * to the given symlink target.
 *
 * @param symlinkTarget a static string containing a path to a symlink target.
 */
- (void)setSymlinkTarget:(OFString*)symlinkTarget;

/**
 * Unsets a mask set by g_file_info_set_attribute_mask(), if one
 * is set.
 *
 */
- (void)unsetAttributeMask;

@end