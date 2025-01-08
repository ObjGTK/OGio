/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBytesIcon.h"

@implementation OGBytesIcon

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_BYTES_ICON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithBytes:(GBytes*)bytes
{
	GBytesIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_bytes_icon_new(bytes), GBytesIcon, GBytesIcon);

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

- (GBytesIcon*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GBytesIcon, GBytesIcon);
}

- (GBytes*)bytes
{
	GBytes* returnValue = (GBytes*)g_bytes_icon_get_bytes([self castedGObject]);

	return returnValue;
}


@end