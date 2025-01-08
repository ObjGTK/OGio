/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilenameCompleter.h"

@implementation OGFilenameCompleter

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILENAME_COMPLETER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (instancetype)init
{
	GFilenameCompleter* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_filename_completer_new(), GFilenameCompleter, GFilenameCompleter);

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
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GFilenameCompleter, GFilenameCompleter);
}

- (char*)completionSuffix:(OFString*)initialText
{
	char* gobjectValue = g_filename_completer_get_completion_suffix([self castedGObject], [initialText UTF8String]);

	char* returnValue = gobjectValue;
	return returnValue;
}

- (char**)completions:(OFString*)initialText
{
	char** returnValue = (char**)g_filename_completer_get_completions([self castedGObject], [initialText UTF8String]);

	return returnValue;
}

- (void)setDirsOnly:(bool)dirsOnly
{
	g_filename_completer_set_dirs_only([self castedGObject], dirsOnly);
}


@end