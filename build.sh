  if [[ ! -d "audio" ]]; then
      echo "Downloading server's audio files..."
      wget https://wpn214.com/download/quarre/audio.zip
      echo "Unpacking audio files..."
      7z x  audio.zip
      echo "Cleaning up"
      rm -rf audio.zip
fi

echo "Building project"
mkdir -p build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release
make -j8

echo "Installing project"
make install

UNAME=$(uname)

if [ "$UNAME" == "Darwin" ]; then
    echo "running macOS .app deployment"
    macdeployqt ../install/quarre-server.app -qmldir=../quarre-server/resources/qml -verbose=2
fi

