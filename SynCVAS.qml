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
            eth1.setIpaddr("192.168.1.100")
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
        anchors.horizontalCenter: parent.horizontalCenter
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "icon_menu_up.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(0))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "icon_menu_left.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(1))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "icon_menu_enter.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(2))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "icon_menu_right.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(3))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "icon_menu_down.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(4))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                btnIcon: imagepath + "icon_media_rew.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(5))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 168
                btnIcon: imagepath + "icon_media_play.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(6))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "icon_media_ff.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(7))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                btnIcon: imagepath + "icon_media_return.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(8))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "icon_media_pause.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(9))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "icon_media_stop.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(10))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                btnIcon: imagepath + "icon_media_next.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(11))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
        }
        RowLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button01{
                width: 168
                btnIcon: imagepath + "icon_menu_back.png"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(12))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 168
                btnText: "MENU"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(13))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
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
