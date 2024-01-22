/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gdesktopappinfo.h>
#include <gio/gunixmounts.h>
#include <gio/gunixoutputstream.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixfdmessage.h>
#include <gio/gio.h>

#import <OGObject/OGObject.h>

@class OGTlsConnection;
@class OGCancellable;
@class OGTlsPassword;

/**
 * #GTlsInteraction provides a mechanism for the TLS connection and database
 * code to interact with the user. It can be used to ask the user for passwords.
 * 
 * To use a #GTlsInteraction with a TLS connection use
 * g_tls_connection_set_interaction().
 * 
 * Callers should instantiate a derived class that implements the various
 * interaction methods to show the required dialogs.
 * 
 * Callers should use the 'invoke' functions like
 * g_tls_interaction_invoke_ask_password() to run interaction methods. These
 * functions make sure that the interaction is invoked in the main loop
 * and not in the current thread, if the current thread is not running the
 * main loop.
 * 
 * Derived classes can choose to implement whichever interactions methods they'd
 * like to support by overriding those virtual methods in their class
 * initialization function. Any interactions not implemented will return
 * %G_TLS_INTERACTION_UNHANDLED. If a derived class implements an async method,
 * it must also implement the corresponding finish method.
 *
 */
@interface OGTlsInteraction : OGObject
{

}


/**
 * Methods
 */

- (GTlsInteraction*)castedGObject;

/**
 * Run synchronous interaction to ask the user for a password. In general,
 * g_tls_interaction_invoke_ask_password() should be used instead of this
 * function.
 * 
 * Derived subclasses usually implement a password prompt, although they may
 * also choose to provide a password from elsewhere. The @password value will
 * be filled in and then @callback will be called. Alternatively the user may
 * abort this password request, which will usually abort the TLS connection.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
 * not support immediate cancellation.
 *
 * @param password a #GTlsPassword object
 * @param cancellable an optional #GCancellable cancellation object
 * @return The status of the ask password interaction.
 */
- (GTlsInteractionResult)askPasswordWithPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable;

/**
 * Run asynchronous interaction to ask the user for a password. In general,
 * g_tls_interaction_invoke_ask_password() should be used instead of this
 * function.
 * 
 * Derived subclasses usually implement a password prompt, although they may
 * also choose to provide a password from elsewhere. The @password value will
 * be filled in and then @callback will be called. Alternatively the user may
 * abort this password request, which will usually abort the TLS connection.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
 * not support immediate cancellation.
 * 
 * Certain implementations may not support immediate cancellation.
 *
 * @param password a #GTlsPassword object
 * @param cancellable an optional #GCancellable cancellation object
 * @param callback will be called when the interaction completes
 * @param userData data to pass to the @callback
 */
- (void)askPasswordAsyncWithPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Complete an ask password user interaction request. This should be once
 * the g_tls_interaction_ask_password_async() completion callback is called.
 * 
 * If %G_TLS_INTERACTION_HANDLED is returned, then the #GTlsPassword passed
 * to g_tls_interaction_ask_password() will have its password filled in.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code.
 *
 * @param result the result passed to the callback
 * @return The status of the ask password interaction.
 */
- (GTlsInteractionResult)askPasswordFinish:(GAsyncResult*)result;

/**
 * Invoke the interaction to ask the user for a password. It invokes this
 * interaction in the main loop, specifically the #GMainContext returned by
 * g_main_context_get_thread_default() when the interaction is created. This
 * is called by called by #GTlsConnection or #GTlsDatabase to ask the user
 * for a password.
 * 
 * Derived subclasses usually implement a password prompt, although they may
 * also choose to provide a password from elsewhere. The @password value will
 * be filled in and then @callback will be called. Alternatively the user may
 * abort this password request, which will usually abort the TLS connection.
 * 
 * The implementation can either be a synchronous (eg: modal dialog) or an
 * asynchronous one (eg: modeless dialog). This function will take care of
 * calling which ever one correctly.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
 * not support immediate cancellation.
 *
 * @param password a #GTlsPassword object
 * @param cancellable an optional #GCancellable cancellation object
 * @return The status of the ask password interaction.
 */
- (GTlsInteractionResult)invokeAskPasswordWithPassword:(OGTlsPassword*)password cancellable:(OGCancellable*)cancellable;

/**
 * Invoke the interaction to ask the user to choose a certificate to
 * use with the connection. It invokes this interaction in the main
 * loop, specifically the #GMainContext returned by
 * g_main_context_get_thread_default() when the interaction is
 * created. This is called by called by #GTlsConnection when the peer
 * requests a certificate during the handshake.
 * 
 * Derived subclasses usually implement a certificate selector,
 * although they may also choose to provide a certificate from
 * elsewhere. Alternatively the user may abort this certificate
 * request, which may or may not abort the TLS connection.
 * 
 * The implementation can either be a synchronous (eg: modal dialog) or an
 * asynchronous one (eg: modeless dialog). This function will take care of
 * calling which ever one correctly.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
 * not support immediate cancellation.
 *
 * @param connection a #GTlsConnection object
 * @param flags flags providing more information about the request
 * @param cancellable an optional #GCancellable cancellation object
 * @return The status of the certificate request interaction.
 */
- (GTlsInteractionResult)invokeRequestCertificateWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable;

/**
 * Run synchronous interaction to ask the user to choose a certificate to use
 * with the connection. In general, g_tls_interaction_invoke_request_certificate()
 * should be used instead of this function.
 * 
 * Derived subclasses usually implement a certificate selector, although they may
 * also choose to provide a certificate from elsewhere. Alternatively the user may
 * abort this certificate request, which will usually abort the TLS connection.
 * 
 * If %G_TLS_INTERACTION_HANDLED is returned, then the #GTlsConnection
 * passed to g_tls_interaction_request_certificate() will have had its
 * #GTlsConnection:certificate filled in.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code. Certain implementations may
 * not support immediate cancellation.
 *
 * @param connection a #GTlsConnection object
 * @param flags flags providing more information about the request
 * @param cancellable an optional #GCancellable cancellation object
 * @return The status of the request certificate interaction.
 */
- (GTlsInteractionResult)requestCertificateWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable;

/**
 * Run asynchronous interaction to ask the user for a certificate to use with
 * the connection. In general, g_tls_interaction_invoke_request_certificate() should
 * be used instead of this function.
 * 
 * Derived subclasses usually implement a certificate selector, although they may
 * also choose to provide a certificate from elsewhere. @callback will be called
 * when the operation completes. Alternatively the user may abort this certificate
 * request, which will usually abort the TLS connection.
 *
 * @param connection a #GTlsConnection object
 * @param flags flags providing more information about the request
 * @param cancellable an optional #GCancellable cancellation object
 * @param callback will be called when the interaction completes
 * @param userData data to pass to the @callback
 */
- (void)requestCertificateAsyncWithConnection:(OGTlsConnection*)connection flags:(GTlsCertificateRequestFlags)flags cancellable:(OGCancellable*)cancellable callback:(GAsyncReadyCallback)callback userData:(gpointer)userData;

/**
 * Complete a request certificate user interaction request. This should be once
 * the g_tls_interaction_request_certificate_async() completion callback is called.
 * 
 * If %G_TLS_INTERACTION_HANDLED is returned, then the #GTlsConnection
 * passed to g_tls_interaction_request_certificate_async() will have had its
 * #GTlsConnection:certificate filled in.
 * 
 * If the interaction is cancelled by the cancellation object, or by the
 * user then %G_TLS_INTERACTION_FAILED will be returned with an error that
 * contains a %G_IO_ERROR_CANCELLED error code.
 *
 * @param result the result passed to the callback
 * @return The status of the request certificate interaction.
 */
- (GTlsInteractionResult)requestCertificateFinish:(GAsyncResult*)result;

@end