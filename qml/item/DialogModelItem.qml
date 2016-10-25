import QtQuick 2.4
import LibQTelegram 1.0
import "../component/message"

MouseArea
{
    property var context
    property var tgDialog

    id: dialogmodelitem
    height: Theme.itemSizeSmall

    PeerImage
    {
        id: peerimage
        anchors { left: parent.left; top: parent.top }
        size: dialogmodelitem.height
        backgroundColor: Theme.mainColor
        foregroundColor: Theme.mainTextColor
        fontPixelSize: Theme.fontSizeLarge
        peer: model.item
    }

    Row
    {
        id: headerrow
        anchors { left: peerimage.right; top: parent.top; right: parent.right; leftMargin: Theme.paddingSmall }
        height: lbltitle.contentHeight

        Text
        {
            id: lbltitle
            text: model.title
            elide: Text.ElideRight
            width: parent.width - lblstatus.contentWidth - Theme.paddingSmall
        }

        MessageStatus
        {
            id: lblstatus
            horizontalAlignment: Text.AlignRight
            visible: !model.isTopMessageService
            ticksColor: Theme.mainColor
            messageDate: model.topMessageDate
            isMessageOut: model.isTopMessageOut
            isMessageUnread: model.isTopMessageUnread
            dateFirst: false
        }
    }

    Row
    {
        anchors { left: peerimage.right; top: headerrow.bottom; bottom: parent.bottom; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
        spacing: Theme.paddingSmall

        Text
        {
            id: lblfrom
            color: Theme.mainColor

            text: {
                if(model.topMessage)
                    return (model.topMessage.isOut ? qsTr("You") : model.topMessageFrom) + ":";

                return "";
            }

            visible: {
                if(model.draftMessage.length > 0 || model.isBroadcast || model.isTopMessageService)
                    return false;

                if(model.isChat || model.isMegaGroup)
                    return true;

                if(model.topMessage)
                    return model.isTopMessageOut;

                return false;
            }
        }

        Text
        {
            id: lbllastmessage
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            color: model.isTopMessageService ? Theme.mainColor : Theme.placeholderTextColor
            font { italic: model.isTopMessageService }

            width: {
                var w = parent.width - Theme.paddingSmall;

                if(lblfrom.visible)
                    w -= lblfrom.contentWidth;

                if(rectunreadcount.visible)
                    w -= rectunreadcount.width;

                return w;
            }

            text: {
                var msg = "";

                if(model.draftMessage.length > 0)
                    msg = qsTr("Draft: %1").arg(model.draftMessage);
                else
                    msg = model.topMessageText;

                return msg;
            }
        }

        Rectangle
        {
            id: rectunreadcount
            width: parent.height
            height: parent.height
            color: Theme.mainColor
            radius: width * 0.5
            visible: model.unreadCount > 0

            Text {
                text: model.unreadCount
                color: Theme.mainTextColor
                anchors.centerIn: parent
                font.pointSize: Theme.fontSizeSmall
            }
        }
    }
}
