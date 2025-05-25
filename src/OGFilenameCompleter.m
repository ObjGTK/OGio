/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGFilenameCompleter.h"

@implementation OGFilenameCompleter

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_FILENAME_COMPLETER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_FILENAME_COMPLETER);
	return gObjectClass;
}

+ (instancetype)filenameCompleter
{
	GFilenameCompleter* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_filename_completer_new(), G_TYPE_FILENAME_COMPLETER, GFilenameCompleter);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGFilenameCompleter* wrapperObject;
	@try {
		wrapperObject = [[OGFilenameCompleter alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GFilenameCompleter*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_FILENAME_COMPLETER, GFilenameCompleter);
}

- (OFString*)completionSuffixWithInitialText:(OFString*)initialText
{
	char* gobjectValue = g_filename_completer_get_completion_suffix([self castedGObject], [initialText UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:true] : nil);
	return returnValue;
}

- (char**)completionsWithInitialText:(OFString*)initialText
{
	char** returnValue = (char**)g_filename_completer_get_completions([self castedGObject], [initialText UTF8String]);

	return returnValue;
}

- (void)setDirsOnly:(bool)dirsOnly
{
	g_filename_completer_set_dirs_only([self castedGObject], dirsOnly);
}


@end