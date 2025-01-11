/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuAttributeIter.h"

@implementation OGMenuAttributeIter

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MENU_ATTRIBUTE_ITER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GMenuAttributeIter*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GMenuAttributeIter, GMenuAttributeIter);
}

- (OFString*)name
{
	const gchar* gobjectValue = g_menu_attribute_iter_get_name([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)nextWithOutName:(const gchar**)outName value:(GVariant**)value
{
	bool returnValue = (bool)g_menu_attribute_iter_get_next([self castedGObject], outName, value);

	return returnValue;
}

- (GVariant*)value
{
	GVariant* returnValue = (GVariant*)g_menu_attribute_iter_get_value([self castedGObject]);

	return returnValue;
}

- (bool)next
{
	bool returnValue = (bool)g_menu_attribute_iter_next([self castedGObject]);

	return returnValue;
}


@end