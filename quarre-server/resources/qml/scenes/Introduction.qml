import QtQuick 2.0
import WPN114.Time 1.0 as WPN114
import WPN114.Audio.Sampling 1.0
import WPN114.Audio.Spatial 1.0
import ".."
import "../engine"

Scene
{
    id: root

    scenario: WPN114.TimeNode
    {
        source:     audiostream
        duration:   min( 4.42 )

        onStart:
        {
            digibirds.play      ( );
            swarms.play         ( );
            dragon_hi.play      ( );
            dragon_lo.play      ( );
            walking_1.play      ( );
            walking_2.play      ( );
            synth.play          ( );
            spring.play         ( );
            river.play          ( );
            verb.play           ( );

            rooms.dBlevel = -3
            net.clients.notifyStart( );
        }

        // Starting next scene at 3:00 (after the xroads interaction)
        WPN114.TimeNode { date: min( 3 ); onStart: root.next() }

        InteractionExecutor //======================================= TUTORIAL
        {
            id:         tutorial_event
            target:     interactions.tutorial

            date:       sec( 1 )
            countdown:  sec( 48 )
            length:     sec( 50 )
        }

        InteractionExecutor //======================================= XROADS
        {
            id:         crossroads_event
            target:     interactions.xroads

            date:       min( 1.45 )
            length:     sec( 30 )
            countdown:  sec( 30 )
        }
    }

    StereoSource //=========================================== DIGIBIRDS
    {
        parentStream: rooms
        xspread: 0.35
        diffuse: 0.49
        fixed: true

        StreamSampler { id: digibirds; path: "audio/introduction/digibirds.wav" }
    }

    StereoSource //=========================================== SWARMS
    {
        parentStream: rooms
        xspread: 0.27
        diffuse: 0.17
        fixed: true
        y: 0.9

        StreamSampler { id: swarms; path: "audio/introduction/swarms.wav" }
    }

    StereoSource //=========================================== DRAGON_HI
    {
        parentStream: rooms
        xspread: 0.28
        fixed: true
        y: 0.65

        StreamSampler { id: dragon_hi; dBlevel: 3; path: "audio/introduction/dragon-hi.wav" }
    }

    StereoSource //=========================================== DRAGON_LO
    {
        parentStream: rooms
        xspread: 0.28
        fixed: true
        y: 0.25

        StreamSampler { id: dragon_lo; dBlevel: 6.00; path: "audio/introduction/dragon-lo.wav" }
    }

    StereoSource //=========================================== WALKING_1
    {
        parentStream: rooms
        xspread: 0.2
        fixed: true

        StreamSampler { id: walking_1; path: "audio/introduction/walking-1.wav" }
    }

    StereoSource //=========================================== WALKING_2
    {
        parentStream: rooms
        xspread: 0.15
        fixed: true
        y: 0.43

        StreamSampler { id: walking_2; path: "audio/introduction/walking-2.wav" }
    }

    StereoSource //=========================================== SYNTH
    {
        parentStream: rooms
        xspread: 0.25
        fixed: true
        y: 0.85

        StreamSampler { id: synth; dBlevel: 6.00; path: "audio/introduction/synth.wav" }
    }

    StereoSource //=========================================== SPRING
    {
        yspread: 0.25
        diffuse: 0.7
        bias: 0.85
        fixed: true

        StreamSampler { id: spring; path: "audio/introduction/spring.wav" }
    }

    StereoSource //=========================================== RIVER
    {
        parentStream: rooms
        yspread: 0.25
        diffuse: 0.55
        fixed: true

        StreamSampler { id: river; path: "audio/introduction/river.wav" }
    }

    StereoSource //=========================================== VERB
    {
        parentStream: rooms
        xspread: 0.25
        diffuse: 0.6
        fixed: true

        StreamSampler { id: verb; path: "audio/introduction/verb.wav" }
    }
}
