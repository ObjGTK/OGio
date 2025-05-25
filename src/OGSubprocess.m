/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2025 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSubprocess.h"

#import "OGCancellable.h"
#import "OGInputStream.h"
#import "OGOutputStream.h"

@implementation OGSubprocess

static GTypeClass *gObjectClass = NULL;

+ (void)load
{
	GType gtypeToAssociate = G_TYPE_SUBPROCESS;

	if (gtypeToAssociate == 0)
		return;

	g_type_set_qdata(gtypeToAssociate, [super wrapperQuark], [self class]);
}

+ (GTypeClass*)gObjectClass
{
	if(gObjectClass != NULL)
		return gObjectClass;

	gObjectClass = g_type_class_ref(G_TYPE_SUBPROCESS);
	return gObjectClass;
}

+ (instancetype)subprocessvWithArgv:(const gchar* const*)argv flags:(GSubprocessFlags)flags
{
	GError* err = NULL;

	GSubprocess* gobjectValue = G_TYPE_CHECK_INSTANCE_CAST(g_subprocess_newv(argv, flags, &err), G_TYPE_SUBPROCESS, GSubprocess);

	if OF_UNLIKELY(!gobjectValue)
		@throw [OGObjectGObjectToWrapCreationFailedException exception];

	[OGErrorException throwForError:err unrefGObject:gobjectValue];

	OGSubprocess* wrapperObject;
	@try {
		wrapperObject = [[OGSubprocess alloc] initWithGObject:gobjectValue];
	} @catch (id e) {
		g_object_unref(gobjectValue);
		[wrapperObject release];
		@throw e;
	}

	g_object_unref(gobjectValue);
	return [wrapperObject autorelease];
}

- (GSubprocess*)castedGObject
{
	return G_TYPE_CHECK_INSTANCE_CAST([self gObject], G_TYPE_SUBPROCESS, GSubprocess);
}

- (bool)communicateWithStdinBuf:(GBytes*)stdinBuf cancellable:(OGCancellable*)cancellable stdoutBuf:(GBytes**)stdoutBuf stderrBuf:(GBytes**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_communicate((GSubprocess*)[self castedGObject], stdinBuf, [cancellable castedGObject], stdoutBuf, stderrBuf, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)communicateAsyncWithStdinBuf:(GBytes*)stdinBuf cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_communicate_async((GSubprocess*)[self castedGObject], stdinBuf, [cancellable castedGObject], callback, userData);
}

- (bool)communicateFinishWithResult:(GAsyncResult*)result stdoutBuf:(GBytes**)stdoutBuf stderrBuf:(GBytes**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_communicate_finish((GSubprocess*)[self castedGObject], result, stdoutBuf, stderrBuf, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)communicateUtf8WithStdinBuf:(OFString*)stdinBuf cancellable:(OGCancellable*)cancellable stdoutBuf:(char**)stdoutBuf stderrBuf:(char**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_communicate_utf8((GSubprocess*)[self castedGObject], [stdinBuf UTF8String], [cancellable castedGObject], stdoutBuf, stderrBuf, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)communicateUtf8AsyncWithStdinBuf:(OFString*)stdinBuf cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_communicate_utf8_async((GSubprocess*)[self castedGObject], [stdinBuf UTF8String], [cancellable castedGObject], callback, userData);
}

- (bool)communicateUtf8FinishWithResult:(GAsyncResult*)result stdoutBuf:(char**)stdoutBuf stderrBuf:(char**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_communicate_utf8_finish((GSubprocess*)[self castedGObject], result, stdoutBuf, stderrBuf, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)forceExit
{
	g_subprocess_force_exit((GSubprocess*)[self castedGObject]);
}

- (gint)exitStatus
{
	gint returnValue = (gint)g_subprocess_get_exit_status((GSubprocess*)[self castedGObject]);

	return returnValue;
}

- (OFString*)identifier
{
	const gchar* gobjectValue = g_subprocess_get_identifier((GSubprocess*)[self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)ifExited
{
	bool returnValue = (bool)g_subprocess_get_if_exited((GSubprocess*)[self castedGObject]);

	return returnValue;
}

- (bool)ifSignaled
{
	bool returnValue = (bool)g_subprocess_get_if_signaled((GSubprocess*)[self castedGObject]);

	return returnValue;
}

- (gint)status
{
	gint returnValue = (gint)g_subprocess_get_status((GSubprocess*)[self castedGObject]);

	return returnValue;
}

- (OGInputStream*)stderrPipe
{
	GInputStream* gobjectValue = g_subprocess_get_stderr_pipe((GSubprocess*)[self castedGObject]);

	OGInputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGOutputStream*)stdinPipe
{
	GOutputStream* gobjectValue = g_subprocess_get_stdin_pipe((GSubprocess*)[self castedGObject]);

	OGOutputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (OGInputStream*)stdoutPipe
{
	GInputStream* gobjectValue = g_subprocess_get_stdout_pipe((GSubprocess*)[self castedGObject]);

	OGInputStream* returnValue = OGWrapperClassAndObjectForGObject(gobjectValue);
	return returnValue;
}

- (bool)successful
{
	bool returnValue = (bool)g_subprocess_get_successful((GSubprocess*)[self castedGObject]);

	return returnValue;
}

- (gint)termSig
{
	gint returnValue = (gint)g_subprocess_get_term_sig((GSubprocess*)[self castedGObject]);

	return returnValue;
}

- (void)sendSignalWithSignalNum:(gint)signalNum
{
	g_subprocess_send_signal((GSubprocess*)[self castedGObject], signalNum);
}

- (bool)waitWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_wait((GSubprocess*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)waitAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_wait_async((GSubprocess*)[self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)waitCheckWithCancellable:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_wait_check((GSubprocess*)[self castedGObject], [cancellable castedGObject], &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (void)waitCheckAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_wait_check_async((GSubprocess*)[self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)waitCheckFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_wait_check_finish((GSubprocess*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}

- (bool)waitFinishWithResult:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = (bool)g_subprocess_wait_finish((GSubprocess*)[self castedGObject], result, &err);

	[OGErrorException throwForError:err];

	return returnValue;
}


@end