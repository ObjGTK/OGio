/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilenameCompleter.h"

@implementation OGFilenameCompleter

- (instancetype)init
{
	GFilenameCompleter* gobjectValue = G_FILENAME_COMPLETER(g_filename_completer_new());

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

- (GFilenameCompleter*)castedGObject
{
	return G_FILENAME_COMPLETER([self gObject]);
}

- (char*)completionSuffix:(OFString*)initialText
{
	char* gobjectValue = g_filename_completer_get_completion_suffix([self castedGObject], [initialText UTF8String]);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (char**)completions:(OFString*)initialText
{
	char** returnValue = g_filename_completer_get_completions([self castedGObject], [initialText UTF8String]);

	return returnValue;
}

- (void)setDirsOnly:(bool)dirsOnly
{
	g_filename_completer_set_dirs_only([self castedGObject], dirsOnly);
}


@end