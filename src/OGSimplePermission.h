/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGPermission.h"

/**
 * #GSimplePermission is a trivial implementation of #GPermission that
 * represents a permission that is either always or never allowed.  The
 * value is given at construction and doesn't change.
 * 
 * Calling request or release will result in errors.
 *
 */
@interface OGSimplePermission : OGPermission
{

}


/**
 * Constructors
 */
- (instancetype)init:(bool)allowed;

/**
 * Methods
 */

- (GSimplePermission*)castedGObject;

@end