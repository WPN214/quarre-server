#include <QApplication>
#include <QQuickWidget>
#include <QQmlComponent>
#include <QQuickItem>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);   

    QQuickWidget view;
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
