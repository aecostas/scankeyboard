import QtQuick 1.0

Item {
    id: container
    property alias charText: rectangleText.text
    property alias cellColor: rectangle.color
    signal clicked(color cellColor)
    width: 70; height: 50



    Rectangle {
        id: rectangle
        border.color: "white"
        anchors.fill: parent
        radius: 10;

        Text {
            id: rectangleText
            anchors.centerIn: parent; anchors.verticalCenterOffset: -1
                    font.pixelSize: parent.width > parent.height ? parent.height * .5 : parent.width * .5
                    style: Text.Sunken; color: "white"; styleColor: "black"; smooth: true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked(container.cellColor)
    }
}
