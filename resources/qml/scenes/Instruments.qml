import QtQuick 2.10
import WPN114.Audio 1.1 as Audio
import WPN114.Audio.Plugins 1.1 as Plugins

Item
{
    id: root

    property alias
    rooms: instruments_rooms

    property alias
    kaivo_1: kaivo_1

    property alias
    kaivo_2: kaivo_2

    property alias
    k1_fork_921: k1_fork_921

    property alias
    k1_fork_lavaur: k1_fork_lavaur

    property alias
    k2_fork_921: k2_fork_921

    property alias
    k2_fork_lavaur: k2_fork_lavaur

    property alias
    k1_fork_amp: k1_fork_amp

    enum Presets
    {
        Autochurch,
        Churchbells,
        Yguitar,
        Jguitar,
        Tguitar,
        Markhor,
        Niwood,
        Spring,
        Vare,
        Rainbells,
        VareRhythm
    }

    //---------------------------------------------------------------------------------------------
    Audio.Rooms
    //---------------------------------------------------------------------------------------------
    {
        id: instruments_rooms
        name: "instruments"
        active: false
        setup: roomsetup
        audio_out.assign: master

        //-----------------------------------------------------------------------------------------
        Plugins.AudioPlugin
        //-----------------------------------------------------------------------------------------
        {
            id: kaivo_1
            name: "kaivo_1"
            path: "audio/plugins/Kaivo"
            active: false
            spatial.width: 1
            spatial.height: 1

            function setPreset(enm) {
                kaivo_1.programChange(0, enm);
            }

            Audio.Connection on audio_out {
                id: k1_fork_921
                dest: effects.reverb;
                prefader: true
            }

            Audio.Connection on audio_out {
                id: k1_fork_lavaur
                dest: effects.lavaur
                active: false
            }

            Audio.Connection on audio_out {
                id: k1_fork_amp
                dest: effects.amplitube
                prefader: true
                active: false
            }
        }


        //-----------------------------------------------------------------------------------------
        Plugins.AudioPlugin
        //-----------------------------------------------------------------------------------------
        {
            id: kaivo_2
            name: "kaivo_2"
            path: "audio/plugins/Kaivo"
            active: false
            spatial.width: 1
            spatial.height: 1

            function setPreset(enm) {
                kaivo_2.programChange(0, enm);
            }

            Audio.Connection on audio_out {
                id: k2_fork_921
                dest: effects.reverb
                prefader: true
            }

            Audio.Connection on audio_out {
                id: k2_fork_lavaur
                dest: effects.lavaur
                active: false
                prefader: true
            }
        }
    }
}
