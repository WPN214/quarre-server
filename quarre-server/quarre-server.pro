QT += quick quickwidgets widgets
CONFIG += c++11 qtquickcompiler

SOURCES += main.cpp
RESOURCES += resources/qml/qml.qrc
RESOURCES += resources/qml/modules/modules.qrc
RESOURCES += resources/images/images.qrc

#QMAKE_POST_LINK += $$quote(cp ../audio $${DESTDIR}$$escape_expand(\n\t))

QML_IMPORT_PATH = ../modules

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
