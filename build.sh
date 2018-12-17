  if [[ ! -d "audio" ]]; then
      echo "Downloading server's audio files..."
      wget https://wpn214.com/download/quarre/audio.zip
      echo "Unpacking audio files..."
      tar xf audio.zip
      echo "Cleaning up"
fi

echo "Building project"
mkdir -p build
cd build

qmake "CONFIG+=release" ..
make -j8

echo "Installing project"
make install

UNAME=$(uname)

if [ "$UNAME" == "Darwin" ]; then
    echo "running macOS .app deployment"
    macdeployqt ../install/quarre-server.app -qmldir=../quarre-server/resources/qml -verbose=2
fi

