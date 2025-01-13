/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSubprocessLauncher.h"

#import "OGSubprocess.h"

@implementation OGSubprocessLauncher

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SUBPROCESS_LAUNCHER;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (instancetype)subprocessLauncherWithFlags:(GSubprocessFlags)flags
{
	GSubprocessLauncher* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_subprocess_launcher_new(flags), GSubprocessLauncher, GSubprocessLauncher);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	OGSubprocessLauncher* wrapperObject;
	@try {
		wrapperObject = [[OGSubprocessLauncher alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSubprocessLauncher*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], GSubprocessLauncher, GSubprocessLauncher);
}

- (void)close
{
	g_subprocess_launcher_close([self castedGObject]);
}

- (OFString*)envWithVariable:(OFString*)variable
{
	const gchar* gobjectValue = g_subprocess_launcher_getenv([self castedGObject], [variable UTF8String]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (void)setChildSetup:(GSpawnChildSetupFunc)childSetup userData:(gpointer)userData destroyNotify:(GDestroyNotify)destroyNotify
{
	g_subprocess_launcher_set_child_setup([self castedGObject], childSetup, userData, destroyNotify);
}

- (void)setCwd:(OFString*)cwd
{
	g_subprocess_launcher_set_cwd([self castedGObject], [cwd UTF8String]);
}

- (void)setEnviron:(gchar**)env
{
	g_subprocess_launcher_set_environ([self castedGObject], env);
}

- (void)setFlags:(GSubprocessFlags)flags
{
	g_subprocess_launcher_set_flags([self castedGObject], flags);
}

- (void)setStderrFilePath:(OFString*)path
{
	g_subprocess_launcher_set_stderr_file_path([self castedGObject], [path UTF8String]);
}

- (void)setStdinFilePath:(OFString*)path
{
	g_subprocess_launcher_set_stdin_file_path([self castedGObject], [path UTF8String]);
}

- (void)setStdoutFilePath:(OFString*)path
{
	g_subprocess_launcher_set_stdout_file_path([self castedGObject], [path UTF8String]);
}

- (void)setenvWithVariable:(OFString*)variable value:(OFString*)value overwrite:(bool)overwrite
{
	g_subprocess_launcher_setenv([self castedGObject], [variable UTF8String], [value UTF8String], overwrite);
}

- (OGSubprocess*)spawnvWithArgv:(const gchar* const*)argv
{
	GError* err = NULL;

	GSubprocess* gobjectValue = g_subprocess_launcher_spawnv([self castedGObject], argv, &err);

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSubprocess* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	g_object_unref(gobjectValue);

	return returnValue;
}

- (void)takeFdWithSourceFd:(gint)sourceFd targetFd:(gint)targetFd
{
	g_subprocess_launcher_take_fd([self castedGObject], sourceFd, targetFd);
}

- (void)takeStderrFd:(gint)fd
{
	g_subprocess_launcher_take_stderr_fd([self castedGObject], fd);
}

- (void)takeStdinFd:(gint)fd
{
	g_subprocess_launcher_take_stdin_fd([self castedGObject], fd);
}

- (void)takeStdoutFd:(gint)fd
{
	g_subprocess_launcher_take_stdout_fd([self castedGObject], fd);
}

- (void)unsetenvWithVariable:(OFString*)variable
{
	g_subprocess_launcher_unsetenv([self castedGObject], [variable UTF8String]);
}


@end