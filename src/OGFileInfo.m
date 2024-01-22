/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileInfo.h"

@implementation OGFileInfo

- (instancetype)init
{
	GFileInfo* gobjectValue = G_FILE_INFO(g_file_info_new());

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

- (GFileInfo*)castedGObject
{
	return G_FILE_INFO([self gObject]);
}

- (void)clearStatus
{
	g_file_info_clear_status([self castedGObject]);
}

- (void)copyInto:(OGFileInfo*)destInfo
{
	g_file_info_copy_into([self castedGObject], [destInfo castedGObject]);
}

- (OGFileInfo*)dup
{
	GFileInfo* gobjectValue = G_FILE_INFO(g_file_info_dup([self castedGObject]));

	OGFileInfo* returnValue = [OGFileInfo wrapperFor:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (GDateTime*)accessDateTime
{
	GDateTime* returnValue = g_file_info_get_access_date_time([self castedGObject]);

	return returnValue;
}

- (char*)attributeAsString:(OFString*)attribute
{
	char* gobjectValue = g_file_info_get_attribute_as_string([self castedGObject], [attribute UTF8String]);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (bool)attributeBoolean:(OFString*)attribute
{
	bool returnValue = g_file_info_get_attribute_boolean([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (OFString*)attributeByteString:(OFString*)attribute
{
	const char* gobjectValue = g_file_info_get_attribute_byte_string([self castedGObject], [attribute UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)attributeDataWithAttribute:(OFString*)attribute type:(GFileAttributeType*)type valuePp:(gpointer*)valuePp status:(GFileAttributeStatus*)status
{
	bool returnValue = g_file_info_get_attribute_data([self castedGObject], [attribute UTF8String], type, valuePp, status);

	return returnValue;
}

- (OFString*)attributeFilePath:(OFString*)attribute
{
	const char* gobjectValue = g_file_info_get_attribute_file_path([self castedGObject], [attribute UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (gint32)attributeInt32:(OFString*)attribute
{
	gint32 returnValue = g_file_info_get_attribute_int32([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (gint64)attributeInt64:(OFString*)attribute
{
	gint64 returnValue = g_file_info_get_attribute_int64([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (GObject*)attributeObject:(OFString*)attribute
{
	GObject* returnValue = g_file_info_get_attribute_object([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (GFileAttributeStatus)attributeStatus:(OFString*)attribute
{
	GFileAttributeStatus returnValue = g_file_info_get_attribute_status([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (OFString*)attributeString:(OFString*)attribute
{
	const char* gobjectValue = g_file_info_get_attribute_string([self castedGObject], [attribute UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (char**)attributeStringv:(OFString*)attribute
{
	char** returnValue = g_file_info_get_attribute_stringv([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (GFileAttributeType)attributeType:(OFString*)attribute
{
	GFileAttributeType returnValue = g_file_info_get_attribute_type([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (guint32)attributeUint32:(OFString*)attribute
{
	guint32 returnValue = g_file_info_get_attribute_uint32([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (guint64)attributeUint64:(OFString*)attribute
{
	guint64 returnValue = g_file_info_get_attribute_uint64([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (OFString*)contentType
{
	const char* gobjectValue = g_file_info_get_content_type([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GDateTime*)creationDateTime
{
	GDateTime* returnValue = g_file_info_get_creation_date_time([self castedGObject]);

	return returnValue;
}

- (GDateTime*)deletionDate
{
	GDateTime* returnValue = g_file_info_get_deletion_date([self castedGObject]);

	return returnValue;
}

- (OFString*)displayName
{
	const char* gobjectValue = g_file_info_get_display_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)editName
{
	const char* gobjectValue = g_file_info_get_edit_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (OFString*)etag
{
	const char* gobjectValue = g_file_info_get_etag([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GFileType)fileType
{
	GFileType returnValue = g_file_info_get_file_type([self castedGObject]);

	return returnValue;
}

- (GIcon*)icon
{
	GIcon* returnValue = g_file_info_get_icon([self castedGObject]);

	return returnValue;
}

- (bool)isBackup
{
	bool returnValue = g_file_info_get_is_backup([self castedGObject]);

	return returnValue;
}

- (bool)isHidden
{
	bool returnValue = g_file_info_get_is_hidden([self castedGObject]);

	return returnValue;
}

- (bool)isSymlink
{
	bool returnValue = g_file_info_get_is_symlink([self castedGObject]);

	return returnValue;
}

- (GDateTime*)modificationDateTime
{
	GDateTime* returnValue = g_file_info_get_modification_date_time([self castedGObject]);

	return returnValue;
}

- (void)modificationTime:(GTimeVal*)result
{
	g_file_info_get_modification_time([self castedGObject], result);
}

- (OFString*)name
{
	const char* gobjectValue = g_file_info_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (goffset)size
{
	goffset returnValue = g_file_info_get_size([self castedGObject]);

	return returnValue;
}

- (gint32)sortOrder
{
	gint32 returnValue = g_file_info_get_sort_order([self castedGObject]);

	return returnValue;
}

- (GIcon*)symbolicIcon
{
	GIcon* returnValue = g_file_info_get_symbolic_icon([self castedGObject]);

	return returnValue;
}

- (OFString*)symlinkTarget
{
	const char* gobjectValue = g_file_info_get_symlink_target([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)hasAttribute:(OFString*)attribute
{
	bool returnValue = g_file_info_has_attribute([self castedGObject], [attribute UTF8String]);

	return returnValue;
}

- (bool)hasNamespace:(OFString*)nameSpace
{
	bool returnValue = g_file_info_has_namespace([self castedGObject], [nameSpace UTF8String]);

	return returnValue;
}

- (char**)listAttributes:(OFString*)nameSpace
{
	char** returnValue = g_file_info_list_attributes([self castedGObject], [nameSpace UTF8String]);

	return returnValue;
}

- (void)removeAttribute:(OFString*)attribute
{
	g_file_info_remove_attribute([self castedGObject], [attribute UTF8String]);
}

- (void)setAccessDateTime:(GDateTime*)atime
{
	g_file_info_set_access_date_time([self castedGObject], atime);
}

- (void)setAttributeWithAttribute:(OFString*)attribute type:(GFileAttributeType)type valueP:(gpointer)valueP
{
	g_file_info_set_attribute([self castedGObject], [attribute UTF8String], type, valueP);
}

- (void)setAttributeBooleanWithAttribute:(OFString*)attribute attrValue:(bool)attrValue
{
	g_file_info_set_attribute_boolean([self castedGObject], [attribute UTF8String], attrValue);
}

- (void)setAttributeByteStringWithAttribute:(OFString*)attribute attrValue:(OFString*)attrValue
{
	g_file_info_set_attribute_byte_string([self castedGObject], [attribute UTF8String], [attrValue UTF8String]);
}

- (void)setAttributeFilePathWithAttribute:(OFString*)attribute attrValue:(OFString*)attrValue
{
	g_file_info_set_attribute_file_path([self castedGObject], [attribute UTF8String], [attrValue UTF8String]);
}

- (void)setAttributeInt32WithAttribute:(OFString*)attribute attrValue:(gint32)attrValue
{
	g_file_info_set_attribute_int32([self castedGObject], [attribute UTF8String], attrValue);
}

- (void)setAttributeInt64WithAttribute:(OFString*)attribute attrValue:(gint64)attrValue
{
	g_file_info_set_attribute_int64([self castedGObject], [attribute UTF8String], attrValue);
}

- (void)setAttributeMask:(GFileAttributeMatcher*)mask
{
	g_file_info_set_attribute_mask([self castedGObject], mask);
}

- (void)setAttributeObjectWithAttribute:(OFString*)attribute attrValue:(GObject*)attrValue
{
	g_file_info_set_attribute_object([self castedGObject], [attribute UTF8String], attrValue);
}

- (bool)setAttributeStatusWithAttribute:(OFString*)attribute status:(GFileAttributeStatus)status
{
	bool returnValue = g_file_info_set_attribute_status([self castedGObject], [attribute UTF8String], status);

	return returnValue;
}

- (void)setAttributeStringWithAttribute:(OFString*)attribute attrValue:(OFString*)attrValue
{
	g_file_info_set_attribute_string([self castedGObject], [attribute UTF8String], [attrValue UTF8String]);
}

- (void)setAttributeStringvWithAttribute:(OFString*)attribute attrValue:(char**)attrValue
{
	g_file_info_set_attribute_stringv([self castedGObject], [attribute UTF8String], attrValue);
}

- (void)setAttributeUint32WithAttribute:(OFString*)attribute attrValue:(guint32)attrValue
{
	g_file_info_set_attribute_uint32([self castedGObject], [attribute UTF8String], attrValue);
}

- (void)setAttributeUint64WithAttribute:(OFString*)attribute attrValue:(guint64)attrValue
{
	g_file_info_set_attribute_uint64([self castedGObject], [attribute UTF8String], attrValue);
}

- (void)setContentType:(OFString*)contentType
{
	g_file_info_set_content_type([self castedGObject], [contentType UTF8String]);
}

- (void)setCreationDateTime:(GDateTime*)creationTime
{
	g_file_info_set_creation_date_time([self castedGObject], creationTime);
}

- (void)setDisplayName:(OFString*)displayName
{
	g_file_info_set_display_name([self castedGObject], [displayName UTF8String]);
}

- (void)setEditName:(OFString*)editName
{
	g_file_info_set_edit_name([self castedGObject], [editName UTF8String]);
}

- (void)setFileType:(GFileType)type
{
	g_file_info_set_file_type([self castedGObject], type);
}

- (void)setIcon:(GIcon*)icon
{
	g_file_info_set_icon([self castedGObject], icon);
}

- (void)setIsHidden:(bool)isHidden
{
	g_file_info_set_is_hidden([self castedGObject], isHidden);
}

- (void)setIsSymlink:(bool)isSymlink
{
	g_file_info_set_is_symlink([self castedGObject], isSymlink);
}

- (void)setModificationDateTime:(GDateTime*)mtime
{
	g_file_info_set_modification_date_time([self castedGObject], mtime);
}

- (void)setModificationTime:(GTimeVal*)mtime
{
	g_file_info_set_modification_time([self castedGObject], mtime);
}

- (void)setName:(OFString*)name
{
	g_file_info_set_name([self castedGObject], [name UTF8String]);
}

- (void)setSize:(goffset)size
{
	g_file_info_set_size([self castedGObject], size);
}

- (void)setSortOrder:(gint32)sortOrder
{
	g_file_info_set_sort_order([self castedGObject], sortOrder);
}

- (void)setSymbolicIcon:(GIcon*)icon
{
	g_file_info_set_symbolic_icon([self castedGObject], icon);
}

- (void)setSymlinkTarget:(OFString*)symlinkTarget
{
	g_file_info_set_symlink_target([self castedGObject], [symlinkTarget UTF8String]);
}

- (void)unsetAttributeMask
{
	g_file_info_unset_attribute_mask([self castedGObject]);
}


@end