/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGUnixCredentialsMessage.h"

#import "OGCredentials.h"

@implementation OGUnixCredentialsMessage

+ (bool)isSupported
{
	bool returnValue = g_unix_credentials_message_is_supported();

	return returnValue;
}

- (instancetype)init
{
	GUnixCredentialsMessage* gobjectValue = G_UNIX_CREDENTIALS_MESSAGE(g_unix_credentials_message_new());

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

- (instancetype)initWithCredentials:(OGCredentials*)credentials
{
	GUnixCredentialsMessage* gobjectValue = G_UNIX_CREDENTIALS_MESSAGE(g_unix_credentials_message_new_with_credentials([credentials castedGObject]));

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

- (GUnixCredentialsMessage*)castedGObject
{
	return G_UNIX_CREDENTIALS_MESSAGE([self gObject]);
}

- (OGCredentials*)credentials
{
	GCredentials* gobjectValue = G_CREDENTIALS(g_unix_credentials_message_get_credentials([self castedGObject]));

	OGCredentials* returnValue = [OGCredentials wrapperFor:gobjectValue];
	return returnValue;
}


@end