#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QJSEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QLocalServer>
#include <QLocalSocket>
#include <QQmlComponent>
#include <QQuickStyle>
#include <QQuickWindow>
#include <QPalette>

#include "cpp/run_guard.h"

// app id
static const QString kIpcServerName = "885c8b8c-4938-46cf-b9b4-26cff6b4f3ab"; // change the uuid

int main(int argc, char *argv[])
{
    ///////////////////////  run guard  /////////////////////////////////
    RunGuard guard( kIpcServerName );
    if ( !guard.tryToRun() ) {
        QLocalSocket socket;
        socket.connectToServer(kIpcServerName);

        if (socket.waitForConnected(200)) {
            socket.write("ACTIVATE");
            socket.flush();
            socket.waitForBytesWritten(100);
        }
        return 0;
    }
    ///////////////////////////////////


    QGuiApplication app(argc, argv);
    app.setApplicationName(PROJECT_NAME);
    app.setApplicationVersion(PROJECT_VERSION);
    app.setOrganizationDomain(ORGANIZATION_DOMAIN);
    app.setOrganizationName(ORGANIZATION_NAME);
    app.setWindowIcon(QIcon(":/assets/single-instance_32px.png"));
    // QQuickStyle::setStyle("FluentWinUI3");
    // QQuickStyle::setFallbackStyle("Material");

    QQmlApplicationEngine engine;
    QQuickWindow *rootWindow = nullptr;

    ///////////////////////  run guard  /////////////////////////////////
    QLocalServer server;
    QLocalServer::removeServer(kIpcServerName);
    server.listen(kIpcServerName);
    QObject::connect(&server, &QLocalServer::newConnection, [&]() {
        QLocalSocket *socket = server.nextPendingConnection();
        if (!socket)
            return;

        socket->waitForReadyRead(100);
        const QByteArray msg = socket->readAll();
        if (msg == "ACTIVATE") {
            if (rootWindow) {
                rootWindow->alert(0);
                rootWindow->requestActivate();
                rootWindow->raise();
                rootWindow->show();
            }
            QQmlComponent component(&engine);
            component.loadFromModule(ORGANIZATION_DOMAIN, "RunGuardWindow", QQmlComponent::PreferSynchronous);
            if (component.isReady()) {
                static QObject *runGuardWindow_obj = nullptr;
                if(!runGuardWindow_obj) {
                    runGuardWindow_obj = component.create();
                } else {
                    QMetaObject::invokeMethod(runGuardWindow_obj, "open", Qt::QueuedConnection);
                }
            } else {
                qWarning() << "Failed to load RunGuardWindow:" << component.errors();
            }
        }
        socket->disconnectFromServer();
    });
    /////////////////////////////////////////////////////////////


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [&rootWindow] (QObject *rootObject, QUrl) {
            rootWindow = qobject_cast<QQuickWindow*>(rootObject);
        },
        Qt::DirectConnection);
    engine.loadFromModule(ORGANIZATION_DOMAIN, "Main");

    if(rootWindow) {
        // Do not access RootWindow in Main.qml because it is defined only after Main.qml has finished loading.
        engine.rootContext()->setContextProperty("RootWindow", QVariant::fromValue(rootWindow));
    } else {
        qCritical() << "\nrootWindow Object Is Null...!!!!\n";
    }

    return app.exec();
}
