import QtQuick 2.0
import Network 1.0

Item {
    anchors.fill: parent
    signal message(string msg)
    property string filepath: if("windows" === Qt.platform.os) "file:"
                              else "file:///sdcard/"
    property string imagepath: filepath + "images/"
    Component.onCompleted: {// 起動
        console.log("initialized")
    }
    Network {
        id: eth1
        onSigReadyRead: {    // 受信通知
            console.log("eth1: " + msg)
            switch(msg){
            default:
            }
        }
        onSigError: console.log("error eth1: " + msg)
    }
    Network {
        id: eth2
        onSigReadyRead: {    // 受信通知
            console.log("eth2: " + msg)
            switch(msg){
            default:
            }
        }
        onSigError: console.log("error eth2: " + msg)
    }

    Image{ id: bg; anchors.fill: parent; source: imagepath + "bg_01.png" }  // 背景
    Rectangle{
        id: btn1
        x: 0; y: 0; width: 96; height: 96
        color: "transparent"
        Image{
            anchors.fill: parent
            source: if(parent.state === "on") imagepath + "btnbl_05.png"
                    else imagepath + "btndk_05.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                eth1.connectToHost("localhost", "5136")
                eth1.write("\\55AA07\\00CO1HI")
                eth2.connectToHost("localhost", "1024")
                eth2.write("ahoahoahoaho")
                console.log("onClicked")
            }
            onPressed: {parent.state = "on"; parent.scale = 1.2}
            onReleased: {parent.state = "off"; parent.scale = 1.0}
        }
    }
    Rectangle{
        id: btn2
        x: 200; y: 0; width: 96; height: 96
        color: "transparent"
        Image{
            anchors.fill: parent
            source: if(parent.state === "on") imagepath + "btnbl_01.png"
                    else imagepath + "btndk_01.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                tmr1.start()
            }
            onPressed: {parent.state = "on"; parent.scale = 1.2}
            onReleased: {parent.state = "off"; parent.scale = 1.0}
        }
    }
    Timer{
        id: tmr1
        interval: 3000
        repeat: true
        onTriggered: {
            eth2.connectToHost("localhost", "1024")
            eth2.write("ahoahoahoaho")
            console.log("onTriggered")
        }
    }
}
