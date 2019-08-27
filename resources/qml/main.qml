import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114.Audio 1.1 as Audio
import WPN114.Audio.Spatial 1.1 as Spatial

import "scenes"
import "views"
import "engine"
import "network"

// TODO: volume and spatialization presets
// TODO: FLAC audio
// TODO: tempoclock
// TODO: MIDIFile reader

Rectangle
{
    id:         application
    visible:    true
    width:      640
    height:     480

    // ================================================================================== CORE

    NetworkManager   { id: net  }
    Functions        { id: functions }
    Scenario         { id: main_scenario }
    MainView         { id: mainview }

    // spatial setup here missing

    //---------------------------------------------------------------------------------------------
    Spatial.SpeakerSetup
    //---------------------------------------------------------------------------------------------
    {
        id: speaker_setup

        Spatial.SpeakerRing {
            nspeakers: 8
            phase: 1/16
        }
    }

    //---------------------------------------------------------------------------------------------
    Audio.Graph
    //---------------------------------------------------------------------------------------------
    {
        rate: 44100; vector: 512
        external.name: "quarre-server"
        external.backend: Audio.Backend.Jack

        //-----------------------------------------------------------------------------------------
        Audio.Output
        //-----------------------------------------------------------------------------------------
        {
            id: main_out
            name: "audio_out"
            nchannels: speaker_setup.nspeakers()

            //-------------------------------------------------------------------------------------
            Audio.PeakRMS
            //-------------------------------------------------------------------------------------
            {
                id: master
                refresh: 15 // Hz

                onRms:
                    mainview.vumeters.processRms(value)

                onPeak:
                    mainview.vumeters.processPeak(value)
            }
        }

    }
}
