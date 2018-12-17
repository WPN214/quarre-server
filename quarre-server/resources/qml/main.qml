import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2

import WPN114.Audio 1.0
import WPN114.Audio.Spatial 1.0 as Spatial
import WPN114.Audio.Utilities 1.0

import "scenes"
import "views"
import "engine"
import "network"
import "control"

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
    PresetsManager   { id: presets }
    Functions        { id: functions }
    Scenario         { id: main_scenario }
    MainView         { id: mainview }

    Spatial.RoomSetup //================================================================= ROOM_SETUP
    {
        id: roomsetup;

        Spatial.SpeakerRing
        {
            nspeakers: 8;
            horizontalInfluence: 0.707
            elevation: 0.5
            offset: -Math.PI/8;
            radius: 1
        }
    }

    AudioStream //=============================================================== AUDIO
    {
        id:             audiostream
        outDevice:      "Soundflower (64ch)"
        numOutputs:     8
        sampleRate:     44100
        blockSize:      512
        active:         false

        inserts:
        [
            PeakRMS
            {
                id:      vu_master
                source:  audiostream
                numInputs: 8
                numOutputs: 8
                active:  true

                onRms:   mainview.vumeters.processRms  ( value )
                onPeak:  mainview.vumeters.processPeak ( value )

                refreshRate: 15 // Hz
            }
        ]
    }
}
