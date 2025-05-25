/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSimplePermission.h"

@implementation OGSimplePermission

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SIMPLE_PERMISSION;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SIMPLE_PERMISSION);
	return gObjectClass;
}

+ (instancetype)simplePermissionWithAllowed:(bool)allowed
{
	GSimplePermission* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_simple_permission_new(allowed), G_TYPE_SIMPLE_PERMISSION, GSimplePermission);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSimplePermission* wrapperObject;
	@try {
		wrapperObject = [[OGSimplePermission alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSimplePermission*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SIMPLE_PERMISSION, GSimplePermission);
}


@end