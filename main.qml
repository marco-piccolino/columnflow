import QtQuick 2.4
import Material 0.1

Window {
    id: app

    ListModel {
        id: cardsModel
        ListElement {
            color: "blue"
            h: 128
        }
        ListElement {
            color: "green"
            h: 104
        }
        ListElement {
            color: "white"
            h: 256
        }
        ListElement {
            color: "purple"
            h: 104
        }
    }
    Flickable {
        id: flick

        property var model: flow.model
        property alias count: flow.count
        property alias delegate: flow.delegate
        property var getter

        height: parent.height
        width: parent.width > units.dp(600) ? units.dp(600) : parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        contentHeight: flow.contentHeight
        contentWidth: width

        onGetterChanged: flow.getter = getter

        onVisibleChanged: {
            if (visible) {  // only load model once CardView is visible
                flow.model = model
            }
        }

        Item {
            id: flowContainer
            anchors {
                margins: units.dp(8)
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                top: parent.top
            }
            width: parent.width

            ColumnFlow {
                id: flow
                columns: flick.width > units.dp(400) ? 2 : 1
                anchors.fill: parent
                flickable: flick

                model: cardsModel

                delegate: Item {
                    id: cardItem

                    property int index
                    property var model

                    height: model.h

                    Card {
                        width: parent.width - units.dp(16)
                        height: parent.height - units.dp(16)
                        anchors.centerIn: parent
                        backgroundColor: model.color
                    }
                }
            }
        }
    }
}
