import QtQuick 2.0
import Network 1.0

Rectangle{
    id: _root
    x: 0; y: 0; width: 80; height: 80
    color: "transparent"

    property string btnText: ""
    property string btnTextFont: ""
    property int btnTextSize: 24
    property string btnTextColor: "white"
    property int btnTextPos: 0
    property string btnImageOff: imagepath + "btndk_05.png"
    property string btnImageOn: imagepath + "btnbl_05.png"
    property string btnIcon: ""

    signal sigClicked(int e)

    Image{
        anchors.fill: parent
        anchors.margins: 10
        source: if(parent.state === "on") btnImageOn
                else btnImageOff
    }
    Image{
        anchors.fill: parent
        anchors.margins: 10
        source: btnIcon
    }
    Text{   // 文字
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: if(btnTextPos === 0) parent.verticalCenter
        anchors.bottom: if(btnTextPos === 2) parent.bottom
        text: btnText
        font.pixelSize: btnTextSize
        color: btnTextColor
    }
    MouseArea{
        id: area
        anchors.fill: parent
        onPressed: {
            sigClicked(0);
            parent.state = "on";
            parent.scale = 1.2
        }
        onReleased: {
            sigClicked(1);
            parent.state = "off";
            parent.scale = 1.0
        }
    }
}
