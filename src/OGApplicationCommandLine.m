/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGApplicationCommandLine.h"

#import "OGInputStream.h"

@implementation OGApplicationCommandLine

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_APPLICATION_COMMAND_LINE;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

- (GApplicationCommandLine*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GApplicationCommandLine, GApplicationCommandLine);
}

- (GFile*)createFileForArg:(OFString*)arg
{
	GFile* returnValue = (GFile*)g_application_command_line_create_file_for_arg([self castedGObject], [arg UTF8String]);

	return returnValue;
}

- (void)done
{
	g_application_command_line_done([self castedGObject]);
}

- (gchar**)arguments:(int*)argc
{
	gchar** returnValue = (gchar**)g_application_command_line_get_arguments([self castedGObject], argc);

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
	const gchar* const* returnValue = (const gchar* const*)g_application_command_line_get_environ([self castedGObject]);

	return returnValue;
}

- (int)exitStatus
{
	int returnValue = (int)g_application_command_line_get_exit_status([self castedGObject]);

	return returnValue;
}

- (bool)isRemote
{
	bool returnValue = (bool)g_application_command_line_get_is_remote([self castedGObject]);

	return returnValue;
}

- (GVariantDict*)optionsDict
{
	GVariantDict* returnValue = (GVariantDict*)g_application_command_line_get_options_dict([self castedGObject]);

	return returnValue;
}

- (GVariant*)platformData
{
	GVariant* returnValue = (GVariant*)g_application_command_line_get_platform_data([self castedGObject]);

	return returnValue;
}

- (OGInputStream*)stdin
{
	GInputStream* gobjectValue = g_application_command_line_get_stdin([self castedGObject]);

	OGInputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (OFString*)env:(OFString*)name
{
	const gchar* gobjectValue = g_application_command_line_getenv([self castedGObject], [name UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)printLiteral:(OFString*)message
{
	g_application_command_line_print_literal([self castedGObject], [message UTF8String]);
}

- (void)printerrLiteral:(OFString*)message
{
	g_application_command_line_printerr_literal([self castedGObject], [message UTF8String]);
}

- (void)setExitStatus:(int)exitStatus
{
	g_application_command_line_set_exit_status([self castedGObject], exitStatus);
}


@end