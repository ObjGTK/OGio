/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGPermission.h"

/**
 * `GSimplePermission` is a trivial implementation of [class@Gio.Permission]
 * that represents a permission that is either always or never allowed.  The
 * value is given at construction and doesn’t change.
 * 
 * Calling [method@Gio.Permission.acquire] or [method@Gio.Permission.release]
 * on a `GSimplePermission` will result in errors.
 *
 */
@interface OGSimplePermission : OGPermission
{

}


/**
 * Constructors
 */
+ (instancetype)simplePermissionWithAllowed:(bool)allowed;

/**
 * Methods
 */

- (GSimplePermission*)castedGObject;

@end