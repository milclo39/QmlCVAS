import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 800; height: 480
    Loader {
        id: loader
        anchors.fill: parent
        source: if("windows" === Qt.platform.os) "file:SynCVAS.qml"
                else "file:///sdcard/SynCVAS.qml"
    }
    Connections {
        target: loader.item
        onMessage: console.log(msg)
    }
}
