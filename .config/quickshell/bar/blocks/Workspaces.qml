import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../utils" as Utils
import "root:/"

RowLayout {
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    Rectangle {
        id: workspaceBar
        Layout.preferredWidth: Math.max(50, 10 + Utils.HyprlandUtils.maxWorkspace * 16)
        Layout.preferredHeight: 16
        //radius: 7
        color: Theme.get.barBgColor

        Row {
            //anchors.centerIn: parent
            spacing: 0

            Repeater {
                model: Utils.HyprlandUtils.maxWorkspace || 1

                Item {
                    required property int index
                    property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)

                    width: workspaceText.width
                    height: workspaceText.height

                    Text {
                        id: workspaceText
                        text: focused ? (index % 2 === 0 ? "▼" : "▲") : (index % 2 === 0 ? "▽" : "△")
                        color: "white"
                        font.pixelSize: 13
                        font.bold: true
                    }

                    // underline for workspace
                    //
                    // Rectangle {
                    //     visible: focused
                    //     anchors {
                    //         left: workspaceText.left
                    //         right: workspaceText.right
                    //         top: workspaceText.bottom
                    //         topMargin: -3
                    //     }
                    //     height: 2
                    //     color: "white"
                    // }

                    DropShadow {
                        visible: focused
                        anchors.fill: workspaceText
                        horizontalOffset: 2
                        verticalOffset: 2
                        radius: 8.0
                        samples: 20
                        color: "#000000"
                        source: workspaceText
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Utils.HyprlandUtils.switchWorkspace(index + 1)
                    }
                }
            }
        }
    }
}
