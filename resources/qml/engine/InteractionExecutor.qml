import QtQuick 2.0
import WPN114.Time 1.1 as Time

Time.Node
{
    id: root

    signal
    begin();

    property Interaction
    target

    property int
    countdown

    property int
    length

    duration:   length === -1 ? -1 : root.countdown+root.length
    onStart:    target.notify(countdown/1000, length === -1 ? -1 : length/1000);
    onEnd:      target.end();

    Time.Node
    {
        source: root.source
        date: root.countdown
        onStart: {
            target.begin();
            root.begin();
        }
    }
}
