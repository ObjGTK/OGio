/*
 * SPDX-FileCopyrightText: 2015-2017 Tyler Burton <software@tylerburton.ca>
 * SPDX-FileCopyrightText: 2015-2024 The ObjGTK authors, see AUTHORS file
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#include <gio/gunixmounts.h>
#include <gio/gdesktopappinfo.h>
#include <gio/gfiledescriptorbased.h>
#include <gio/gio.h>
#include <gio/gunixfdmessage.h>
#include <gio/gunixinputstream.h>
#include <gio/gunixoutputstream.h>

#import <OGObject/OGObject.h>

@class OGDBusConnection;

/**
 * A #GDBusObjectProxy is an object used to represent a remote object
 * with one or more D-Bus interfaces. Normally, you don't instantiate
 * a #GDBusObjectProxy yourself - typically #GDBusObjectManagerClient
 * is used to obtain it.
 *
 */
@interface OGDBusObjectProxy : OGObject
{

}


/**
 * Constructors
 */
- (instancetype)initWithConnection:(OGDBusConnection*)connection objectPath:(OFString*)objectPath;

/**
 * Methods
 */

- (GDBusObjectProxy*)castedGObject;

/**
 * Gets the connection that @proxy is for.
 *
 * @return A #GDBusConnection. Do not free, the
 *   object is owned by @proxy.
 */
- (OGDBusConnection*)connection;

@end