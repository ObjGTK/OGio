/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGApplicationCommandLine.h"

#import "OGInputStream.h"

@implementation OGApplicationCommandLine

- (GApplicationCommandLine*)castedGObject
{
	return G_APPLICATION_COMMAND_LINE([self gObject]);
}

- (GFile*)createFileForArg:(OFString*)arg
{
	GFile* returnValue = g_application_command_line_create_file_for_arg([self castedGObject], [arg UTF8String]);

	return returnValue;
}

- (gchar**)arguments:(int*)argc
{
	gchar** returnValue = g_application_command_line_get_arguments([self castedGObject], argc);

	return returnValue;
}

- (OFString*)cwd
{
	const gchar* gobjectValue = g_application_command_line_get_cwd([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (const gchar* const*)environ
{
	const gchar* const* returnValue = g_application_command_line_get_environ([self castedGObject]);

	return returnValue;
}

- (int)exitStatus
{
	int returnValue = g_application_command_line_get_exit_status([self castedGObject]);

	return returnValue;
}

- (bool)isRemote
{
	bool returnValue = g_application_command_line_get_is_remote([self castedGObject]);

	return returnValue;
}

- (GVariantDict*)optionsDict
{
	GVariantDict* returnValue = g_application_command_line_get_options_dict([self castedGObject]);

	return returnValue;
}

- (GVariant*)platformData
{
	GVariant* returnValue = g_application_command_line_get_platform_data([self castedGObject]);

	return returnValue;
}

- (OGInputStream*)stdin
{
	GInputStream* gobjectValue = G_INPUT_STREAM(g_application_command_line_get_stdin([self castedGObject]));

	OGInputStream* returnValue = [OGInputStream withGObject:gobjectValue];
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OFString*)env:(OFString*)name
{
	const gchar* gobjectValue = g_application_command_line_getenv([self castedGObject], [name UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setExitStatus:(int)exitStatus
{
	g_application_command_line_set_exit_status([self castedGObject], exitStatus);
}


@end