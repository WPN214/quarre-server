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

