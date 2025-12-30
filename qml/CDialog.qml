import QtQuick
import QtQuick.Controls

Dialog {
    id: control
    property string text
    property bool autoOpen: false
    x: parent ? (parent.width / 2 - width / 2) : 0
    y: parent ? (parent.height / 2 - height / 2) : 0

    modal: true
    dim: true
    standardButtons: Dialog.Ok
    closePolicy: Popup.NoAutoClose

    Text {
        width: control.width - control.leftPadding - control.rightPadding
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        fontSizeMode: Text.Fit
        font.pixelSize: 15
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        text: control.text
    }

    Component.onCompleted: {
        if(control.autoOpen) {
            control.open()
        }
    }
}
