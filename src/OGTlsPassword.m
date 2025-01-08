/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGTlsPassword.h"

@implementation OGTlsPassword

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_TLS_PASSWORD;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)initWithFlags:(GTlsPasswordFlags)flags description:(OFString*)description
{
	GTlsPassword* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_tls_password_new(flags, [description UTF8String]), GTlsPassword, GTlsPassword);

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

- (GTlsPassword*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GTlsPassword, GTlsPassword);
}

- (OFString*)description
{
	const gchar* gobjectValue = g_tls_password_get_description([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (GTlsPasswordFlags)flags
{
	GTlsPasswordFlags returnValue = (GTlsPasswordFlags)g_tls_password_get_flags([self castedGObject]);

	return returnValue;
}

- (const guchar*)value:(gsize*)length
{
	const guchar* returnValue = (const guchar*)g_tls_password_get_value([self castedGObject], length);

	return returnValue;
}

- (OFString*)warning
{
	const gchar* gobjectValue = g_tls_password_get_warning([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setDescription:(OFString*)description
{
	g_tls_password_set_description([self castedGObject], [description UTF8String]);
}

- (void)setFlags:(GTlsPasswordFlags)flags
{
	g_tls_password_set_flags([self castedGObject], flags);
}

- (void)setValueWithValue:(const guchar*)value length:(gssize)length
{
	g_tls_password_set_value([self castedGObject], value, length);
}

- (void)setValueFullWithValue:(guchar*)value length:(gssize)length destroy:(GDestroyNotify)destroy
{
	g_tls_password_set_value_full([self castedGObject], value, length, destroy);
}

- (void)setWarning:(OFString*)warning
{
	g_tls_password_set_warning([self castedGObject], [warning UTF8String]);
}


@end