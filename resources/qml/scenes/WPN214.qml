import QtQuick 2.0
import WPN114.Time 1.1 as Time
import ".."
import "../engine"

Scene
{
    id: root

    property var
    fade_target: woodpath.jomon

    scenario: Time.Node
    {
        source: audiostream
        parentNode: parent.scenario
        duration: Time.Node.Infinite

        InteractionExecutor
        {
            id:         interaction_ending_ex
            target:     interaction_ending
            countdown:  sec( 10 )
            length:     min( 4.30 )

            onStart:    sampler.play();
        }

        Time.Automation
        {
            after: interaction_ending_ex;
            target: fade_target.rooms
            property: "level"
            duration: sec( 10 )

            from: fade_target.rooms.level; to: 0;

            onEnd:
            {
                if (fade_target === woodpath.jomon)
                     woodpath.jomon.cicadas.stop()
                else
                    if (fade_target === stonepath.ammon)
                     stonepath.ammon.wind.stop();

                functions.setTimeout(function(){
                    fade_target.rooms.active = false
                    scenario.end();
                }, 2000)
            }
        }
    }

    Interaction //----------------------------------------------------- INTERACTION
    {
        id: interaction_ending
        title: "Fin, crédits"
        module: "quarre/WPN214.qml"
        description: "Merci pour votre participation"
        broadcast: true
    }

    Audio.Sampler
    {
        id: sampler
        name: "wpn214"
        file: "audio/wpn214/wpn214.wav"
        stream: true
        mul: db(-3)
    }
}

