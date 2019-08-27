import QtQuick 2.0
import WPN114.Network 1.1 as Network
import WPN114.Audio.Spatial 1.1 as Spatial
import WPN114.Time 1.1 as Time
import ".."

Item
{
    id: root

    property string
    path

    property bool
    running: false

    property bool
    notify: true

    property bool
    audio: true

    property bool
    endShutdown: true

    property int
    shutdown_after: 3000

    /*
        a scene consists in a bi/tridimensional audiospace and a scenario
        it has a 'next' and an 'end' signal
        'next' signal means that next scene (if there is one) can be safely started
        'end' signal means that there's no more audio about to come out of this scene
    */

    signal
    next();

    signal
    end();

    Network.Node
    {
        path: fmt("end");
        type: Network.Type.Impulse;
        onValueReceived: root.stop()
    }

    Network.Node
    {
        path: fmt("begin");
        type: Network.Type.Impulse;
        onValueReceived: root.start()
    }

    function fmt(str)
    {
        return path+"/"+str;
    }

    function name()
    {
        var name = path.split('/');
        return name[name.length-1];
    }

    function start() // ===================================== START_SCENE
    {
        if (running) return;
        if (!audiostream.active)
             audiostream.active = true;

        rooms.active = true;

        if (!timer.running)
            timer.start();

        scenario.start();
        running = true;

        if (notify) {
            net.clients.notifyScene(name());
            main_scenario.runningScene = this;
        }
    }

    function stop() // ====================================== STOP_SCENE
    {
        scenario.end();
    }

    function onEnd() // ===================================== ON_SCENE_END
    {
        var main = net.server.get(path);

        if (endShutdown) {
            // stop all samplers
            var stopnodes = main.collect( "stop" );
            stopnodes.forEach(function(node){
                node.value = 0;
            })

            // set rooms inactive a while later
            functions.setTimeout(function(){
                rooms.active = false;
            }, shutdown_after )
        }

        running = false
        end();
    }

    function reset() // ===================================== RESET_SCENE
    {
        rooms.active = false;
        var dbnodes = net.server.collectNodes("dBlevel");

        dbnodes.forEach(function(node){
            node.resetValue()
        });
    }

    property Spatial.Rooms
    rooms: Spatial.Rooms
    {
        setup:  roomsetup
        active: false
    }

    property Time.Node
    scenario

    Component.onCompleted:
    {
        scenario.end.connect(root.onEnd);

        if (audio) {
            rooms.parentStream = audiostream
            rooms.exposePath = fmt("audio/rooms")
        }
    }
}
