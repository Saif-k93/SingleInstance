import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.impl as Impl
import QtQuick.Controls.Material as M
import QtQuick.Controls.Material.impl as MImpl
import QtQuick.Controls.FluentWinUI3 as F
import QtQuick.Controls.FluentWinUI3.impl as FImpl
import QtQuick.Layouts
import QtQuick.Effects

Window {
    id: root

    width: 410
    height: 300
    visible: true
    title: Application.name
    color: M.Material.background
    M.Material.accent: M.Material.theme === M.Material.Dark ? Qt.darker("green", 1.6) : Qt.lighter("blue", 1.45)

    ColumnLayout {
        id: rootItem
        anchors {
            fill: parent
            margins: 20
        }

        smooth: true
        antialiasing: true

        Label {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            padding: 15
            color: palette.text
            text: qsTr("This is a Single Instance App Example") + ` <font color='${palette.highlight}'> ` + qsTr("Try launching a new instance of the app.") + `</font>`
            wrapMode: Label.WordWrap
            font.pixelSize: 18

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                radius: 8
                color: palette.base

                layer.enabled: true
                layer.smooth: true
                layer.mipmap: true
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blur: 0.1
                    shadowEnabled: true
                    blurMax: 64
                    shadowBlur: 0.5
                    shadowColor: Qt.rgba(0.0, 0.0, 0.0, 0.8)
                    shadowOpacity: 0.7
                }
            }
        }
    }

}
