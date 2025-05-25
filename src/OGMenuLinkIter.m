/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGMenuLinkIter.h"

#import "OGMenuModel.h"

@implementation OGMenuLinkIter

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_MENU_LINK_ITER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_MENU_LINK_ITER);
	return gObjectClass;
}

- (GMenuLinkIter*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_MENU_LINK_ITER, GMenuLinkIter);
}

- (OFString*)name
{
	const gchar* gobjectValue = g_menu_link_iter_get_name((GMenuLinkIter*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)nextWithOutLink:(const gchar**)outLink value:(GMenuModel**)value
{
	bool returnValue = (bool)g_menu_link_iter_get_next((GMenuLinkIter*)[self castedGObject], outLink, value);

	return returnValue;
}

- (OGMenuModel*)value
{
	GMenuModel* gobjectValue = g_menu_link_iter_get_value((GMenuLinkIter*)[self castedGObject]);

	OGMenuModel* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (bool)next
{
	bool returnValue = (bool)g_menu_link_iter_next((GMenuLinkIter*)[self castedGObject]);

	return returnValue;
}


@end