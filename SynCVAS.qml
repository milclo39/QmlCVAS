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
        Component.onCompleted: {
            eth1.setIpaddr("192.168.1.101")
            eth1.setPort("5136")
        }
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
        Component.onCompleted: {
            eth2.setIpaddr("192.168.1.100")
            eth2.setPort("5136")
        }
        onSigReadyRead: {    // 受信通知
            console.log("eth2: " + msg)
            switch(msg){
            default:
            }
        }
        onSigError: console.log("error eth2: " + msg)
    }

    Image{ id: bg; anchors.fill: parent; source: imagepath + "bg_01.png" }  // 背景
    Button01{
        x: 0; y: 0; width: 100; height: 100
        btnText: "ahoaho"
        onSigClicked: {
            eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
            eth1.write("\\55AA07\\00CO1HI")
            console.log("onClicked:" + e)
        }
	}
    Button01{
        x: 100; y: 0; width: 100; height: 100
        btnText: "tako"
        onSigClicked: {
            eth2.connectToHost(eth2.getIpaddr(), eth2.getPort())
            eth2.write("\\55AA07\\00CO1LO")
            console.log("onClicked:" + e)
        }
    }
    Slider01{
        x: 0; y: 100; width: 300; height: 50
        onSigPosChanged: {
            console.log("onSigPosChanged:" + e)
            eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
            eth1.write("\\55AA07\\00SC1" + e)
        }
        onSigMuteClick: {
            console.log("onSigMuteClick:" + e)
        }
	}
    Slider01{
        x: 0; y: 150; width: 300; height: 50
        onSigPosChanged: {
            console.log("onSigPosChanged:" + e)
            eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
            eth1.write("\\55AA07\\00SC1" + e)
        }
        onSigMuteClick: {
            console.log("onSigMuteClick:" + e)
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
