import QtQuick 2.4
import LibQTelegram 1.0

Item
{
    property Message message

    id: messagebubble
    layer.enabled: true
    opacity: 0.80

    Rectangle
    {
        id: mainbubble
        color: message.isOut ? Theme.alternateMainColor : Theme.mainColor
        anchors.fill: parent
        radius: 12
        smooth: true
    }

    Rectangle
    {
        id: flatangle
        width: mainbubble.radius
        height: mainbubble.radius
        color: mainbubble.color

        anchors {
            top: !message.isOut ? undefined : parent.top
            right: !message.isOut ? undefined : parent.right
            bottom: message.isOut ? undefined: parent.bottom
            left: message.isOut ? undefined : parent.left
        }
    }
}
