import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Network 1.0

Item {
    anchors.fill: parent
    signal message(string msg)
    property string filepath: if("windows" === Qt.platform.os) "file:"
                              else "file:///sdcard/"
    property string imagepath: filepath + "images/"
    property int flgLearn: 0
    property int idxSelect: 0

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
            if(msg.match("00IR1FLSOK")){
                eth1.write("\\55AA08\\00IR1SLS")
            }
            else if(msg.match("00IR1SLSOK")){
                eth1.write("\\55AA08\\00IR1SLR")
                flgLearn = 1
            }
            else if(flgLearn !== 0){
                if(msg.substring(8)==="OK"){return}
                setCmd(idxSelect, eth1.read())
                flgLearn = 0
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
                    idxSelect = 0
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 2
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 3
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                btnIcon: imagepath + "icon_menu_back.png"
                onSigClicked: {
                    idxSelect = 12
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 100; height: 100
                btnIcon: imagepath + "icon_menu_down.png"
                onSigClicked: {
                    idxSelect = 4
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
                    }
                    else{
                        eth1.write("\\55aa08\\00IR1SRT")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button01{
                width: 100; height: 100
                btnText: "MENU"
                onSigClicked: {
                    idxSelect = 13
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 5
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 6
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 7
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 8
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 9
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 10
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmd(idxSelect))
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
                    idxSelect = 11
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write(eth1.getCmdidxSelect)
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
            Button02{
                btnText: "1"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write("\\55aa07\\00CO1HI")
                    }
                    else{
                        eth1.write("\\55aa07\\00CO1LO")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button02{
                btnText: "2"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write("\\55aa07\\00CO2HI")
                    }
                    else{
                        eth1.write("\\55aa07\\00CO2LO")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button02{
                btnText: "3"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write("\\55aa07\\00CO3HI")
                    }
                    else{
                        eth1.write("\\55aa07\\00CO3LO")
                    }
                    console.log("onClicked:" + e)
                }
            }
            Button02{
                btnText: "4"
                onSigClicked: {
                    eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
                    if(!e){
                        eth1.write("\\55aa07\\00CO4HI")
                    }
                    else{
                        eth1.write("\\55aa07\\00CO4LO")
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
    Button{
        x: 0; y: 0; width: 50; height: 50
        text: "≡"
        onClicked: {
            eth1.connectToHost(eth1.getIpaddr(), eth1.getPort())
            if(parent.state !== "on"){
                eth1.write("\\55AA08\\00IR1FLS")
                parent.state = "on";
                text = "学"
                bg.source = imagepath + "bg_02.png"
            }
            else{
                eth1.write("\\55AA08\\00IR1ELM")
                parent.state = "off";
                text = "≡"
                bg.source  = imagepath + "bg_01.png"
                eth1.close()
            }
        }
    }
    Timer{
        id: tmr1
        interval: 3000
        repeat: true
        onTriggered: {
            console.log("onTriggered")
        }
    }
}
