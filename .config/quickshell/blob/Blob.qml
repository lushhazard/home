import Quickshell
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "blocks" as Blocks
import "root:/"

Scope {
    IpcHandler {
        target: "blob"

        function toggleVis(): void {
            blob.visible = !blob.visible;
        }
    }
    FloatingWindow {
        id: blob
        property var modelData
        implicitWidth: 400
        implicitHeight: 400
        visible: true
        title: "quickshell_blob"
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 12
            color: "#00000022"   // semi-transparent tint
            border.color: "#FF8800"
            border.width: 2
        }

        //this is all sound stuff, for my sound setup
        //
        // property var vcsink
        // property var mediasink
        // property var nullsink

        // PwObjectTracker {
        //     id: sinkBinder
        //     objects: [blob.vcsink, blob.mediasink, blob.nullsink]
        // }
        PwObjectTracker {
            id: defaultSinkTracker
            objects: [Pipewire.defaultAudioSink]
        }

        // Timer {
        //     interval: 1000
        //     running: true
        //     repeat: true
        //     onTriggered: {
        //         for (var i = 0; i < Pipewire.nodes.rowCount(); i++) {
        //             try {
        //                 var node = Pipewire.nodes.values[i];
        //                 var desc = node.description;
        //                 console.log(i + " " + desc);

        //                 if (desc.startsWith("vc-sink")) {
        //                     blob.vcsink = node;
        //                 } else if (desc.startsWith("media-sink")) {
        //                     blob.mediasink = node;
        //                 } else if (desc.startsWith("nullsink")) {
        //                     blob.nullsink = node;
        //                 }
        //                 if (blob.nullsink && blob.vcsink && blob.mediasink) {
        //                     console.log("all sinks ready, stopping sink timer...");
        //                     stop();
        //                 } else {
        //                     console.log("still waiting for sinks.. looping");
        //                 }
        //             } catch (e) {
        //                 console.log("Error iterating node: " + e);
        //             }
        //             ;
        //         }
        //     }
        // }

        ColumnLayout {
            spacing: 50
            anchors.fill: parent
            anchors.margins: 16

            // Left side
            RowLayout {
                spacing: 8
                Layout.fillWidth: true
                //Blocks.Icon {}
                Blocks.Workspaces {}
            }
            RowLayout {}

            // RowLayout {
            //     spacing: 8
            //     Layout.alignment: Qt.AlignHCenter
            //     Blocks.Sound {
            //         id: vcSound
            //         sink: blob.vcsink
            //         name: "vc"
            //     }
            //     Blocks.Sound {
            //         id: mediaSound
            //         sink: blob.mediasink
            //         name: "me"
            //     }
            //     Blocks.Sound {
            //         id: nullSound
            //         sink: blob.nullsink
            //         name: "nu"
            //     }
            // }
            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true

                Text {
                    text: "🔊"
                    color: "#FF8800"
                    font.pixelSize: 14
                }

                Slider {
                    id: volumeSlider
                    Layout.fillWidth: true
                    from: 0
                    to: 1
                    stepSize: 0.01
                    value: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0

                    onMoved: {
                        if (Pipewire.defaultAudioSink) {
                            Pipewire.defaultAudioSink.audio.volume = value;
                        }
                    }
                }

                Text {
                    text: Pipewire.defaultAudioSink ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "–"
                    color: "#FF8800"
                    font.pixelSize: 12
                    width: 36
                }
            }

            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignHCenter
                Blocks.SystemTray {}
            }

            RowLayout {}

            RowLayout {
                spacing: 0
                Layout.fillWidth: true
                Blocks.Date {}
                Item {
                    Layout.fillWidth: true
                }   // spacer pushes time to the right
                Blocks.Time {}
            }
        }

        //Timer {
        //    id: autoHideTimer
        //    interval: 10000   // 10s
        //    repeat: false
        //    running: blob.visible

        //    onTriggered: {
        //        blob.visible = false;
        //    }
        //}

        //onVisibleChanged: {
        //    if (visible) {
        //        autoHideTimer.restart();
        //    } else {
        //        autoHideTimer.stop();
        //    }
        //}
    }
}
