import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import "../"
import "root:/"

BarBlock {
    id: root
    property var sink
    property var name

    PwObjectTracker {

        onObjectsChanged: {
            if (root.sink?.audio) {
                root.sink.audio.volumeChanged.disconnect(updateVolume); // safe to call even if not connected
                root.sink.audio.volumeChanged.connect(updateVolume);
                updateVolume(); // update immediately
            }
        }
    }

    function updateVolume() {
        if (typeof sink?.audio?.volume === "number") {
            const icon = sink.audio.muted ? "󰖁" : "󰕾";
            content.symbolText = `${icon} ${Math.round(sink.audio.volume * 100)}${name}`;
        }
    }

    content: BarText {
        symbolText: `${root.sink?.audio?.muted ? "󰖁" : "󰕾"} ${Math.round(root.sink?.audio?.volume * 100)}${root.name}`

        font.pixelSize: 16
    }

    // Interaction area on the block
    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onEntered: {
            positionPopup();
            volumePopup.visible = true;
        }
        onExited: {
            hideTimer.start();
        }

        onClicked: mouse => {
            if (!root.sink?.audio)
                return;
            if (mouse.button === Qt.LeftButton) {
                root.sink.audio.muted = !root.sink.audio.muted;
            } else if (mouse.button === Qt.RightButton) {
                pavucontrol.running = true;
            }
        }

        onWheel: function (event) {
            if (!root.sink?.audio)
                return;
            const delta = (event.angleDelta.y / 120) * 0.05;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta));
        }
    }

    Timer {
        id: hideTimer
        interval: 180
        repeat: false
        onTriggered: {
            // Use popupMouse.containsMouse, not volumePopup.containsMouse
            if (!popupMouse.containsMouse && !hoverArea.containsMouse) {
                volumePopup.visible = false;
            }
        }
    }

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
        running: false
    }

    // Hover popup (drops down from the block)
    PopupWindow {
        id: volumePopup
        visible: false
        implicitWidth: 40
        implicitHeight: 160

        anchor {
            window: root.QsWindow?.window
            edges: Edges.Top
            gravity: Edges.Bottom
        }

        MouseArea {
            id: popupMouse
            anchors.fill: parent
            hoverEnabled: true
            onEntered: hideTimer.stop()
            onExited: hideTimer.start()

            Rectangle {
                anchors.fill: parent
                color: "#111111"
                //border.color: "#FF8800"
                radius: 0

                Slider {
                    id: control
                    orientation: Qt.Vertical
                    anchors.centerIn: parent
                    from: 0
                    to: 1

                    value: typeof root.sink?.audio?.volume === "number" ? root.sink.audio.volume : 0

                    onMoved: {
                        if (root.sink?.audio) {
                            root.sink.audio.volume = value;
                        }
                    }

                    handle: Rectangle {
                        // Center handle horizontally
                        x: control.leftPadding + control.availableWidth / 2 - width / 2
                        // Position handle according to visualPosition (0 = bottom, 1 = top)
                        y: control.topPadding + (control.visualPosition) * (control.availableHeight - height)
                        implicitWidth: 20
                        implicitHeight: 20
                        radius: 13
                        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                        border.color: "#000000"
                        rotation: 180
                    }
                }
            }
        }

        //Behavior on visible {
        //    SequentialAnimation {
        //        NumberAnimation {
        //            target: volumePopup
        //            property: "opacity"
        //            to: visible ? 1 : 0
        //            duration: 100
        //        }
        //    }
        //}
    }

    function positionPopup() {
        if (!root.QsWindow?.window?.contentItem)
            return;

        // Map the block’s rect to the window's contentItem and anchor just below it.
        // If your bar is at the bottom, change the y offset to negative and swap edges/gravity above.
        const ci = root.QsWindow.window.contentItem;
        const r = ci.mapFromItem(root, 0, root.height + 6, root.width, volumePopup.implicitHeight);
        volumePopup.anchor.rect = r;
    }
}
