import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Network 1.0

Rectangle {
    x: 0; y: 0; width: 300; height: 50
    color: "gray"
    border.width: 1

    signal sigPosChanged(int e)
    signal sigMuteClick(int e)

    RowLayout{
        id: volumebar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter;
        Slider {
            id:slider
            Layout.fillWidth: true
            from: 0;to: 10;stepSize: 1;value: 5
            onPositionChanged: sigPosChanged(value)
            hoverEnabled: true
            handle: Rectangle { // スライダーつまみの色変えテク
              x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
              y: slider.topPadding + slider.availableHeight / 2 - height / 2
              implicitWidth: 26
              implicitHeight: 26
              radius: 13
              color: if(mutebtn.state !== "on") "deepskyblue"
                    else "lightgray"
              border.color: if(mutebtn.state !== "on") "darkblue"
                    else "lightgray"
            }
        }
        // ボリューム表示
        Text{text: slider.value}
        // ミュートボタン
        Rectangle {
            id: mutebtn
            color: "transparent"
            width: 32; height: 32
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if(mutebtn.state === "on"){
                        sigMuteClick(1)
                        slider.enabled = true
                        mutebtn.state = "off"
                    }
                    else{
                        sigMuteClick(0)
                        slider.enabled = false
                        mutebtn.state = "on"
                    }
                }
                Image{
                    anchors.fill: parent
                    source: if(mutebtn.state !== "on"){imagepath + "mt0.png"}
                            else{imagepath + "mt1.png"}
                }
                onHoveredChanged: {
                    parent.opacity = containsMouse? 0.6 : 1
                }
            }
            states: [
                State {name: "on"},
                State {name: "off"}
            ]
        }
    }
}
