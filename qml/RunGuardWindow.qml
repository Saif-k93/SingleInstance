import QtQuick

Item {
    id: root
    property QtObject dialog: null


    function open() {
        if(!dialog) {
            dialog = privateVars.createComponent("../qml/CDialog.qml", RootWindow ?? null, "CDialog.qml", {
                                                     title: qsTr("%1 Already Running").arg(Application.name),
                                                     text: qsTr("The application is already running."),
                                                     autoOpen: true
                                                 })
        } else {
            dialog.open()
        }
    }

    Component.onCompleted: {
        open()
    }

     QtObject {
        id: privateVars

        function createComponent(url, parent, comp_name, properties = {}) {
            var __component = Qt.createComponent(url,
                                                 Component.PreferSynchronous, parent)
            const finishCreation = function () {
                console.log(`Component Is Ready (${comp_name})`)
                var __object = __component.createObject(parent, properties)
                if (__object !== null) {
                    return __object
                } else {
                    console.warn(`Cannot Creating Object (${comp_name})..!`)
                }
            }
            if (__component.status !== Component.Ready) {
                console.warn(__component.errorString())
                __component.statusChanged.connect(() => {
                                                      if (__component.status === Component.Error) {
                                                          console.warn(
                                                              `Cannot Create Component (${comp_name})..!\n${__component.errorString(
                                                                  )}`)
                                                          return null
                                                      } else if (__component.status === Component.Loading) {
                                                          console.log(
                                                              `Loading The Component (${comp_name})`)
                                                      } else if (__component.status === Component.Ready) {
                                                          return finishCreation()
                                                      }
                                                  })
            } else {
                return finishCreation()
            }
        }
    }
}
