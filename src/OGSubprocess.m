/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import "OGSubprocess.h"

#import "OGOutputStream.h"
#import "OGCancellable.h"
#import "OGInputStream.h"

@implementation OGSubprocess

- (instancetype)initvWithArgv:(const gchar* const*)argv flags:(GSubprocessFlags)flags
{
	GError* err = NULL;

	GSubprocess* gobjectValue = G_SUBPROCESS(g_subprocess_newv(argv, flags, &err));

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		if(gobjectValue != NULL)
			g_object_unref(gobjectValue);
		@throw exception;
	}

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

- (GSubprocess*)castedGObject
{
	return G_SUBPROCESS([self gObject]);
}

- (bool)communicateWithStdinBuf:(GBytes*)stdinBuf cancellable:(OGCancellable*)cancellable stdoutBuf:(GBytes**)stdoutBuf stderrBuf:(GBytes**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = g_subprocess_communicate([self castedGObject], stdinBuf, [cancellable castedGObject], stdoutBuf, stderrBuf, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)communicateAsyncWithStdinBuf:(GBytes*)stdinBuf cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_communicate_async([self castedGObject], stdinBuf, [cancellable castedGObject], callback, userData);
}

- (bool)communicateFinishWithResult:(GAsyncResult*)result stdoutBuf:(GBytes**)stdoutBuf stderrBuf:(GBytes**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = g_subprocess_communicate_finish([self castedGObject], result, stdoutBuf, stderrBuf, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)communicateUtf8WithStdinBuf:(OFString*)stdinBuf cancellable:(OGCancellable*)cancellable stdoutBuf:(char**)stdoutBuf stderrBuf:(char**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = g_subprocess_communicate_utf8([self castedGObject], [stdinBuf UTF8String], [cancellable castedGObject], stdoutBuf, stderrBuf, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)communicateUtf8AsyncWithStdinBuf:(OFString*)stdinBuf cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_communicate_utf8_async([self castedGObject], [stdinBuf UTF8String], [cancellable castedGObject], callback, userData);
}

- (bool)communicateUtf8FinishWithResult:(GAsyncResult*)result stdoutBuf:(char**)stdoutBuf stderrBuf:(char**)stderrBuf
{
	GError* err = NULL;

	bool returnValue = g_subprocess_communicate_utf8_finish([self castedGObject], result, stdoutBuf, stderrBuf, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)forceExit
{
	g_subprocess_force_exit([self castedGObject]);
}

- (gint)exitStatus
{
	gint returnValue = g_subprocess_get_exit_status([self castedGObject]);

	return returnValue;
}

- (OFString*)identifier
{
	const gchar* gobjectValue = g_subprocess_get_identifier([self castedGObject]);

	OFString* returnValue = ((gobjectValue != NULL) ? [OFString stringWithUTF8StringNoCopy:(char * _Nonnull)gobjectValue freeWhenDone:false] : nil);
	return returnValue;
}

- (bool)ifExited
{
	bool returnValue = g_subprocess_get_if_exited([self castedGObject]);

	return returnValue;
}

- (bool)ifSignaled
{
	bool returnValue = g_subprocess_get_if_signaled([self castedGObject]);

	return returnValue;
}

- (gint)status
{
	gint returnValue = g_subprocess_get_status([self castedGObject]);

	return returnValue;
}

- (OGInputStream*)stderrPipe
{
	GInputStream* gobjectValue = G_INPUT_STREAM(g_subprocess_get_stderr_pipe([self castedGObject]));

	OGInputStream* returnValue = [OGInputStream withGObject:gobjectValue];
	return returnValue;
}

- (OGOutputStream*)stdinPipe
{
	GOutputStream* gobjectValue = G_OUTPUT_STREAM(g_subprocess_get_stdin_pipe([self castedGObject]));

	OGOutputStream* returnValue = [OGOutputStream withGObject:gobjectValue];
	return returnValue;
}

- (OGInputStream*)stdoutPipe
{
	GInputStream* gobjectValue = G_INPUT_STREAM(g_subprocess_get_stdout_pipe([self castedGObject]));

	OGInputStream* returnValue = [OGInputStream withGObject:gobjectValue];
	return returnValue;
}

- (bool)successful
{
	bool returnValue = g_subprocess_get_successful([self castedGObject]);

	return returnValue;
}

- (gint)termSig
{
	gint returnValue = g_subprocess_get_term_sig([self castedGObject]);

	return returnValue;
}

- (void)sendSignal:(gint)signalNum
{
	g_subprocess_send_signal([self castedGObject], signalNum);
}

- (bool)wait:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_subprocess_wait([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)waitAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_wait_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)waitCheck:(OGCancellable*)cancellable
{
	GError* err = NULL;

	bool returnValue = g_subprocess_wait_check([self castedGObject], [cancellable castedGObject], &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (void)waitCheckAsyncWithCancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData
{
	g_subprocess_wait_check_async([self castedGObject], [cancellable castedGObject], callback, userData);
}

- (bool)waitCheckFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_subprocess_wait_check_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}

- (bool)waitFinish:(GAsyncResult*)result
{
	GError* err = NULL;

	bool returnValue = g_subprocess_wait_finish([self castedGObject], result, &err);

	if(err != NULL) {
		OGErrorException* exception = [OGErrorException exceptionWithGError:err];
		g_error_free(err);
		@throw exception;
	}

	return returnValue;
}


@end