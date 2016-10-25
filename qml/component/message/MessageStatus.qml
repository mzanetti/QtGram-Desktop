import QtQuick 2.4

Text
{
    property color ticksColor
    property string messageDate
    property bool isMessageUnread
    property bool isMessageOut
    property bool dateFirst: true
    property bool dateOnly: false

    id: messagesstatus
    textFormat: Text.StyledText
    verticalAlignment: Text.AlignVCenter
    font.pointSize: Theme.fontSizeSmall

    text: {
        if(dateOnly)
            return messageDate;

        var status = "";

        if(dateFirst)
            status += messageDate + " ";

        if(isMessageOut) {
            status += "<font color=\"" + ticksColor + "\">";

            if(!isMessageUnread)
                status += " <b>✓✓</b> ";
            else
                status += " <b>✓</b> ";

            status += "</font>";
        }

        if(!dateFirst)
            status += " " + messageDate;

        return status;
    }
}
