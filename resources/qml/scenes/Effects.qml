import QtQuick 2.0
import WPN114.Audio 1.1 as Audio
import WPN114.Network 1.1 as Network
import WPN114.FFTEffects 1.1 as FFT

Item
{
    property alias
    reverb: reverb

    property alias
    lavaur: reverb_lavaur

    property alias
    amplitube: amplitube

    property alias
    rooms: effects_rooms

    Audio.Rooms
    {
        id: effects_rooms
        name: "rooms"
        setup: roomsetup
        audio_out.assign: master;

        FFT.Convolver //============================================== 921
        {
            id: reverb
            name: "921"
            ir: "audio/impulse-responses/921MST.wav"
            spatial.height: 1
            spatial.width: 1
        }

        FFT.Convolver //============================================== LAVAUR
        {
            id: reverb_lavaur
            name: "lavaur"
            ir: "audio/impulse-responses/LAVAUR22ST.wav"
            active: false
            spatial.height: 1
            spatial.width: 1
        }

        FFT.Convolver //============================================== AMPLITUBE
        {
            id: amplitube
            name: "amplitube"
            ir: "audio/impulse-responses/AMPDEFAULT.wav"
            active: false
            spatial.height: 1
            spatial.width: 1
        }
    }
}
