// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5

import QtQuick 1.0
import "action.js" as Logic

Rectangle {
    id: page
    state:"login"
    width: 500; height: 200
    color: "lightgray"
    focus: true
    Component.onCompleted: Logic.init()

    Keys.onPressed: Logic.select(helloText, event.key)

    Rectangle {
        id: keyboardRectangle
        visible: true
        anchors.top: page.top
        anchors.bottom: page.bottom
        anchors.left: page.left
        anchors.right: page.right
        Keys.forwardTo: [page]


        Text {
            id: sampleText
            color: "#808080"
            text: "Texto de muestra"
            y: 10
            anchors.horizontalCenter: keyboardRectangle.horizontalCenter
            font.pointSize: 24; font.bold: true
        }


        TextEdit {
            id: helloText
            color: "#808080"
            text: ""
            y: 55
            anchors.horizontalCenter: keyboardRectangle.horizontalCenter
            font.pointSize: 24;
        }


        Timer {
            id: idtimeout;
            interval: 1000;
            running: false
            repeat: true
            onTriggered: { Logic.timeout() }
        }


        Grid {
            id: colorPicker
            x: 4; anchors.bottom: keyboardRectangle.bottom; anchors.bottomMargin: 4
            rows: 1; columns: 6; spacing: 3

            Cell { id: celda1; charText: "A";  cellColor: "red"; onClicked: helloText.color = cellColor }
            Cell { id: celda2; charText: "B";  cellColor: "green"; onClicked: helloText.color = cellColor }
            Cell { id: celda3; charText: "C";  cellColor: "blue"; onClicked: helloText.color = cellColor }

        }


        Rectangle {
            id:loginscreen
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            color:"yellow"


            TextEdit {

                state: "init"
                id: displayText
                focus:true
                anchors {
                    right: parent.right;
                    verticalCenter: parent.verticalCenter;
                    verticalCenterOffset: -1
                    rightMargin: 6; left: parent.left
                }
                text: "<Your name>";
                horizontalAlignment: Text.AlignRight;
                color: "#444444"; smooth: true;
                Keys.forwardTo: [page]

                }// TextEdit
            }// Rectangle

    }

}
