/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGThemedIcon.h"

@implementation OGThemedIcon

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_THEMED_ICON;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)themedIcon:(OFString*)iconname
{
	GThemedIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_themed_icon_new([iconname UTF8String]), GThemedIcon, GThemedIcon);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGThemedIcon* wrapperObject;
	@try {
		wrapperObject = [[OGThemedIcon alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)themedIconFromNamesWithIconnames:(char**)iconnames len:(int)len
{
	GThemedIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_themed_icon_new_from_names(iconnames, len), GThemedIcon, GThemedIcon);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGThemedIcon* wrapperObject;
	@try {
		wrapperObject = [[OGThemedIcon alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

+ (instancetype)themedIconWithDefaultFallbacks:(OFString*)iconname
{
	GThemedIcon* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_themed_icon_new_with_default_fallbacks([iconname UTF8String]), GThemedIcon, GThemedIcon);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGThemedIcon* wrapperObject;
	@try {
		wrapperObject = [[OGThemedIcon alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GThemedIcon*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GThemedIcon, GThemedIcon);
}

- (void)appendName:(OFString*)iconname
{
	g_themed_icon_append_name([self castedGObject], [iconname UTF8String]);
}

- (const gchar* const*)names
{
	const gchar* const* returnValue = (const gchar* const*)g_themed_icon_get_names([self castedGObject]);

	return returnValue;
}

- (void)prependName:(OFString*)iconname
{
	g_themed_icon_prepend_name([self castedGObject], [iconname UTF8String]);
}


@end