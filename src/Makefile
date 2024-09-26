include ../extra.mk

SHARED_LIB = ${OGIO_SHARED_LIB}
STATIC_LIB = ${OGIO_STATIC_LIB}
FRAMEWORK = ${OGIO_FRAMEWORK}
LIB_MAJOR = 2
LIB_MINOR = 0

SRCS = OGAppInfoMonitor.m \
	OGAppLaunchContext.m \
	OGApplication.m \
	OGApplicationCommandLine.m \
	OGBufferedInputStream.m \
	OGBufferedOutputStream.m \
	OGBytesIcon.m \
	OGCancellable.m \
	OGCharsetConverter.m \
	OGConverterInputStream.m \
	OGConverterOutputStream.m \
	OGCredentials.m \
	OGDBusActionGroup.m \
	OGDBusAuthObserver.m \
	OGDBusConnection.m \
	OGDBusInterfaceSkeleton.m \
	OGDBusMenuModel.m \
	OGDBusMessage.m \
	OGDBusMethodInvocation.m \
	OGDBusObjectManagerClient.m \
	OGDBusObjectManagerServer.m \
	OGDBusObjectProxy.m \
	OGDBusObjectSkeleton.m \
	OGDBusProxy.m \
	OGDBusServer.m \
	OGDataInputStream.m \
	OGDataOutputStream.m \
	OGDebugControllerDBus.m \
	OGDesktopAppInfo.m \
	OGEmblem.m \
	OGEmblemedIcon.m \
	OGFileEnumerator.m \
	OGFileIOStream.m \
	OGFileIcon.m \
	OGFileInfo.m \
	OGFileInputStream.m \
	OGFileMonitor.m \
	OGFileOutputStream.m \
	OGFilenameCompleter.m \
	OGFilterInputStream.m \
	OGFilterOutputStream.m \
	OGIOStream.m \
	OGInetAddress.m \
	OGInetAddressMask.m \
	OGInetSocketAddress.m \
	OGInputStream.m \
	OGListStore.m \
	OGMemoryInputStream.m \
	OGMemoryOutputStream.m \
	OGMenu.m \
	OGMenuAttributeIter.m \
	OGMenuItem.m \
	OGMenuLinkIter.m \
	OGMenuModel.m \
	OGMountOperation.m \
	OGNativeSocketAddress.m \
	OGNativeVolumeMonitor.m \
	OGNetworkAddress.m \
	OGNetworkService.m \
	OGNotification.m \
	OGOutputStream.m \
	OGPermission.m \
	OGPropertyAction.m \
	OGProxyAddress.m \
	OGProxyAddressEnumerator.m \
	OGResolver.m \
	OGSettings.m \
	OGSettingsBackend.m \
	OGSimpleAction.m \
	OGSimpleActionGroup.m \
	OGSimpleAsyncResult.m \
	OGSimpleIOStream.m \
	OGSimplePermission.m \
	OGSimpleProxyResolver.m \
	OGSocket.m \
	OGSocketAddress.m \
	OGSocketAddressEnumerator.m \
	OGSocketClient.m \
	OGSocketConnection.m \
	OGSocketControlMessage.m \
	OGSocketListener.m \
	OGSocketService.m \
	OGSubprocess.m \
	OGSubprocessLauncher.m \
	OGTask.m \
	OGTcpConnection.m \
	OGTcpWrapperConnection.m \
	OGTestDBus.m \
	OGThemedIcon.m \
	OGThreadedResolver.m \
	OGThreadedSocketService.m \
	OGTlsCertificate.m \
	OGTlsConnection.m \
	OGTlsDatabase.m \
	OGTlsInteraction.m \
	OGTlsPassword.m \
	OGUnixConnection.m \
	OGUnixCredentialsMessage.m \
	OGUnixFDList.m \
	OGUnixFDMessage.m \
	OGUnixInputStream.m \
	OGUnixMountMonitor.m \
	OGUnixOutputStream.m \
	OGUnixSocketAddress.m \
	OGVfs.m \
	OGVolumeMonitor.m \
	OGZlibCompressor.m \
	OGZlibDecompressor.m \
	

INCLUDES = ${SRCS:.m=.h} \
	OGio-Umbrella.h

include ../buildsys.mk

LD = ${OBJC}
