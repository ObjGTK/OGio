/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGVfs.h"

@implementation OGVfs

+ (OGVfs*)default
{
	GVfs* gobjectValue = G_VFS(g_vfs_get_default());

	OGVfs* returnValue = [OGVfs wrapperFor:gobjectValue];
	return returnValue;
}

+ (OGVfs*)local
{
	GVfs* gobjectValue = G_VFS(g_vfs_get_local());

	OGVfs* returnValue = [OGVfs wrapperFor:gobjectValue];
	return returnValue;
}

- (GVfs*)castedGObject
{
	return G_VFS([self gObject]);
}

- (GFile*)fileForPath:(OFString*)path
{
	GFile* returnValue = g_vfs_get_file_for_path([self castedGObject], [path UTF8String]);

	return returnValue;
}

- (GFile*)fileForUri:(OFString*)uri
{
	GFile* returnValue = g_vfs_get_file_for_uri([self castedGObject], [uri UTF8String]);

	return returnValue;
}

- (const gchar* const*)supportedUriSchemes
{
	const gchar* const* returnValue = g_vfs_get_supported_uri_schemes([self castedGObject]);

	return returnValue;
}

- (bool)isActive
{
	bool returnValue = g_vfs_is_active([self castedGObject]);

	return returnValue;
}

- (GFile*)parseName:(OFString*)parseName
{
	GFile* returnValue = g_vfs_parse_name([self castedGObject], [parseName UTF8String]);

	return returnValue;
}

- (bool)registerUriSchemeWithScheme:(OFString*)scheme uriFunc:(GVfsFileLookupFunc)uriFunc uriData:(gpointer)uriData uriDestroy:(GDestroyNotify)uriDestroy parseNameFunc:(GVfsFileLookupFunc)parseNameFunc parseNameData:(gpointer)parseNameData parseNameDestroy:(GDestroyNotify)parseNameDestroy
{
	bool returnValue = g_vfs_register_uri_scheme([self castedGObject], [scheme UTF8String], uriFunc, uriData, uriDestroy, parseNameFunc, parseNameData, parseNameDestroy);

	return returnValue;
}

- (bool)unregisterUriScheme:(OFString*)scheme
{
	bool returnValue = g_vfs_unregister_uri_scheme([self castedGObject], [scheme UTF8String]);

	return returnValue;
}


@end