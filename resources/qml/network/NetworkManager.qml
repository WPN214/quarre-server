import QtQuick 2.0
import WPN114.Network 1.1 as Network

Item
{
    property alias
    server: query_server

    property alias
    clients: client_manager

    Network.Server //================================================= MAIN_SERVER
    {
        id: query_server
        singleton: true
        name: "quarre-server"
        tcp: 5678
        udp: 1234

        Component.onCompleted:
        {
            mainview.tree.model = nodeTree();
        }
    }

    ClientManager //========================================================= REMOTES
    {
        id: client_manager
        maxClients: 4
    }

    Network.Folder //==================================================== MODULES
    {
        tree: module_server.tree()
        recursive: true
        path: "/modules"
        folder: "../modules"
        filters: ["*.qml"]
    }

    Network.Server //================================================ MODULE_SERVER
    {
        id: module_server
        name: "quarre-modules"
        tcp: 8576
        udp: 4132
    }
}
