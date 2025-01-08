/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFileIcon.h"

@implementation OGFileIcon

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILE_ICON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithFile:(GFile*)file
{
	GFileIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_file_icon_new(file), GFileIcon, GFileIcon);

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

- (GFileIcon*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GFileIcon, GFileIcon);
}

- (GFile*)file
{
	GFile* returnValue = (GFile*)g_file_icon_get_file([self castedGObject]);

	return returnValue;
}


@end