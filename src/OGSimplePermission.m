/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimplePermission.h"

@implementation OGSimplePermission

- (instancetype)init:(bool)allowed
{
	GSimplePermission* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_permission_new(allowed), GSimplePermission, GSimplePermission);

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

- (GSimplePermission*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSimplePermission, GSimplePermission);
}


@end