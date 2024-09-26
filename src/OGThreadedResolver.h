/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGResolver.h"

/**
 * #GThreadedResolver is an implementation of #GResolver which calls the libc
 * lookup functions in threads to allow them to run asynchronously.
 *
 */
@interface OGThreadedResolver : OGResolver
{

}


/**
 * Methods
 */

- (GThreadedResolver*)castedGObject;

@end