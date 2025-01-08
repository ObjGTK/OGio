/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGCharsetConverter.h"

@implementation OGCharsetConverter

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_CHARSET_CONVERTER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithToCharset:(OFString*)toCharset fromCharset:(OFString*)fromCharset
{
	GError* err = NULL;

	GCharsetConverter* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_charset_converter_new([toCharset UTF8String], [fromCharset UTF8String], &err), GCharsetConverter, GCharsetConverter);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

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

- (GCharsetConverter*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GCharsetConverter, GCharsetConverter);
}

- (guint)numFallbacks
{
	guint returnValue = (guint)g_charset_converter_get_num_fallbacks([self castedGObject]);

	return returnValue;
}

- (bool)useFallback
{
	bool returnValue = (bool)g_charset_converter_get_use_fallback([self castedGObject]);

	return returnValue;
}

- (void)setUseFallback:(bool)useFallback
{
	g_charset_converter_set_use_fallback([self castedGObject], useFallback);
}


@end