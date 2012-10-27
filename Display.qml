// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

BorderImage {
    id: image

    property alias text : displayText.text
    property alias currentOperation : operationText

    border { left: 10; top: 10; right: 10; bottom: 10 }

    Text {
        id: displayText
        anchors {
            right: parent.right; verticalCenter: parent.verticalCenter; verticalCenterOffset: -1
            rightMargin: 6; left: operationText.right
        }
        font.pixelSize: parent.height * .6; text: "0"; horizontalAlignment: Text.AlignRight; elide: Text.ElideRight
        color: "#343434"; smooth: true; font.bold: true
    }
    Text {
        id: operationText
        font.bold: true; font.pixelSize: parent.height * .7
        color: "#343434"; smooth: true
        anchors { left: parent.left; leftMargin: 6; verticalCenterOffset: -3; verticalCenter: parent.verticalCenter }
    }
}
