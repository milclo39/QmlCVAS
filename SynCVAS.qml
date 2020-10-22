import QtQuick 2.0
import Network 1.0
import QtQuick.Layouts 1.3

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

    Image{ id: bg; anchors.fill: parent; source: imagepath + "bg_01.png" }  // 背景
    ColumnLayout{
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "up.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth1.write("\\55AA07\\00CO1HI")
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "left.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth1.write("\\55AA07\\00CO1HI")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 100; height: 100
                btnText: "ENTER"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "right.png"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "down.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth1.write("\\55AA07\\00CO1HI")
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                btnIcon: imagepath + "rew.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth1.write("\\55AA07\\00CO1HI")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 168
                btnIcon: imagepath + "play.png"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "ff.png"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                btnIcon: imagepath + "r-skip.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth1.write("\\55AA07\\00CO1HI")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "pause.png"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "stop.png"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "f-skip.png"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 168
                btnText: "BACK"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth1.write("\\55AA07\\00CO1HI")
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 168
                btnText: "MENU"
                onSigClicked: {
                    eth2.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    eth2.write("\\55AA07\\00CO1LO")
                    console.log("onClicked:" + e)
                }
            }
        }
        /*
        Slider01{
            anchors.horizontalCenter: parent.horizontalCenter
            onSigPosChanged: {
                console.log("onSigPosChanged:" + e)
                eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                eth1.write("\\55AA07\\00SC1" + e)
            }
            onSigMuteClick: {
                console.log("onSigMuteClick:" + e)
            }
        }
        */
    }
    Timer{
        id: tmr1
        interval: 3000
        repeat: true
        onTriggered: {
            eth1.connectToHost("localhost", "1024")
            eth1.write("ahoahoahoaho")
            console.log("onTriggered")
        }
    }
}
