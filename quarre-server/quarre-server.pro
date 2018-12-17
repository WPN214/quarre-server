QT += quick quickwidgets widgets
CONFIG += c++11 qtquickcompiler

SOURCES += main.cpp
RESOURCES += resources/qml/qml.qrc
RESOURCES += resources/qml/modules/modules.qrc
RESOURCES += resources/images/images.qrc
QML_IMPORT_PATH = ../modules

target.path = ../install
INSTALLS += target

macx {
    #QMAKE_POST_LINK += macdeployqt ../install/quarre-server.app -qmldir=resources/qml -verbose=2
    audio.path = ../install/quarre-server.app/Contents/MacOS/audio
    dependencies.path = ../install/quarre-server.app/Contents/Resources/qml
}

linux {
    audio.path = ../install
    dependencies.path = ../install
}

audio.files = ../audio/*
dependencies.files = ../modules/*

INSTALLS += audio
INSTALLS += dependencies
