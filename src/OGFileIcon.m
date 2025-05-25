/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileIcon.h"

@implementation OGFileIcon

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILE_ICON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_FILE_ICON);
	return gObjectClass;
}

+ (instancetype)fileIconWithFile:(GFile*)file
{
	GFileIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_file_icon_new(file), G_TYPE_FILE_ICON, GFileIcon);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGFileIcon* wrapperObject;
	@try {
		wrapperObject = [[OGFileIcon alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GFileIcon*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_FILE_ICON, GFileIcon);
}

- (GFile*)file
{
	GFile* returnValue = (GFile*)g_file_icon_get_file([self castedGObject]);

	return returnValue;
}


@end