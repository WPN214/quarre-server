import QtQuick 2.0
import WPN114.Network 1.1 as Network
import WPN114.Time 1.0 as Time

Item
{
    id: root

    property int
    number: 0

    property int
    interaction_count: 0

    property bool
    connected: false

    property string
    status: "disconnected"

    property alias
    remote: remote

    Network.Node on interaction_count {
        tree: net.server.tree()
        path: "/clients/"+number+"/n_interactions"
    }

    Network.Node on status {
        tree: net.server.tree()
        path: "/clients/"+number+"/status"
    }

    function getInteractionMessage(interaction)
    {
        var interaction_arr = [];

        // arg0: title
        // arg1: description
        // arg2: module
        // arg3: length
        // arg4: countdown
        interaction_arr.push(interaction.title);
        interaction_arr.push(interaction.description);
        interaction_arr.push(interaction.module);
        interaction_arr.push(interaction.length);
        interaction_arr.push(interaction.countdown);

    return interaction_arr;
    }

    function notifyInteraction(interaction)
    {
        var interaction_arr = getInteractionMessage(interaction);
        remote.send("/interactions/next/incoming", interaction_arr, true);

        interaction.owners.push(root);
        root.interaction_count++;

        if  (status === "active")
             root.status = "active_incoming";
        else root.status = "incoming";
    }

    function beginInteraction(interaction)
    {
        var interaction_arr = getInteractionMessage(interaction);
        remote.send("/interactions/next/begin", interaction_arr, true);

        if (interaction.length === Time.TimeNode.Infinite)
             root.status = "active_infinite";
        else root.status = "active";
    }

    function endInteraction(interaction)
    {
        remote.send("/interactions/current/end", 0, true);

        if (status === "active_incoming")       status = "incoming";
        else if (status === "active")           status = "idle";
        else if (status === "active_infinite")  status = "idle";
        else if (status === "incoming")         status = "idle";
    }

    function getActiveCountdown()
    {
        return remote.value("/interactions/current/countdown");
    }

    WPN114.Client
    {
        // when connected, remote will download the different module files
        // then go into idle state
        id: remote

        onConnected:
        {
            root.status = "idle"
            root.connected = true

            remote.listen( "/interactions/next/countdown" );
            remote.listen( "/interactions/current/countdown" );

            if (main_scenario.running) {
                remote.send("/scenario/running", true, true);
                remote.send("/scenario/scene/name", main_scenario.runningScene.name(), true);
            }
        }

        onDisconnected: {
            root.status = "disconnected"
            root.connected = false;
        }
    }
}
