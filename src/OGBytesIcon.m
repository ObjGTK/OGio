/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGBytesIcon.h"

@implementation OGBytesIcon

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_BYTES_ICON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_BYTES_ICON);
	return gObjectClass;
}

+ (instancetype)bytesIconWithBytes:(GBytes*)bytes
{
	GBytesIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_bytes_icon_new(bytes), G_TYPE_BYTES_ICON, GBytesIcon);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGBytesIcon* wrapperObject;
	@try {
		wrapperObject = [[OGBytesIcon alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GBytesIcon*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_BYTES_ICON, GBytesIcon);
}

- (GBytes*)bytes
{
	GBytes* returnValue = (GBytes*)g_bytes_icon_get_bytes((GBytesIcon*)[self castedGObject]);

	return returnValue;
}


@end