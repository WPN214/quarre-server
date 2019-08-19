import QtQuick 2.0
import "../engine"

Item
{
    id: root

    property int
    xroads_result: 0

    //---------------------------------------------------------------------------------------------
    property Interaction
    tutorial: Interaction
    //---------------------------------------------------------------------------------------------
    {
        title: "Didacticiel"
        module: "quarre/Tutorial.qml"
        broadcast: true
        description: "Présentation du fonctionnement global de l'application"
    }

    //---------------------------------------------------------------------------------------------
    property Interaction
    xroads: Interaction
    //---------------------------------------------------------------------------------------------
    {
        title: "Croisée des chemins"
        module: "quarre/Vote.qml"
        broadcast: true
        description: "Sélectionnez l'un des symboles présentés ci-dessous. Ce choix influencera le déroulement du scénario."

        onInteractionBegin:
        {
            owners.forEach(function(owner) {
                if (owner.connected)
                    owner.remote.listen("/modules/crossroads/selection");
            });
        }

        onInteractionEnd:
        {
            // parse selection for each connected client
            var res0 = 0, res1 = 0, res2 = 0, total = 0;

            owners.forEach(function(owner) {
                if (owner.connected) {
                    var res = owner.remote.value("/modules/crossroads/selection");

                    switch(res) {
                    case 0: res0++; break;
                    case 1: res1++; break;
                    case 2: res2++;
                    }

                    owner.remote.ignore("/modules/crossroads/selection");
                }
            });

            if (res1 > res0 && res1 > res2)
                total = 0;
            else
                if (res2 > res0 && res2 > res1)
                total = 1;
            else
                total = Math.floor(Math.random()*2);

            root.xroads_result = total;
        }
    }
}
