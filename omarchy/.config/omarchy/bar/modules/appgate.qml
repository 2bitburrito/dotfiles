import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

BarIconButton {
  id: root

  property var settings: ({})
  property string moduleName: "appgate"
  property string connectionState: "stopped"
  readonly property string helper: Quickshell.env("HOME") + "/.config/omarchy/bar/scripts/appgate-control"
  readonly property string stateLabel: {
    switch (connectionState) {
    case "connected": return "Connected"
    case "connecting": return "Connecting"
    case "error": return "Driver error"
    case "running": return "Running"
    default: return "Stopped"
    }
  }

  tooltipText: "Appgate SDP: " + stateLabel
  dimmed: connectionState === "stopped"
  implicitWidth: 28
  implicitHeight: bar ? bar.barSize : 26

  iconComponent: Component {
    Item {
      Image {
        anchors.centerIn: parent
        width: 18
        height: 18
        source: "file:///usr/share/icons/hicolor/scalable/apps/appgate-icon.svg"
        fillMode: Image.PreserveAspectFit
        smooth: true
      }

      Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 7
        height: 7
        radius: width / 2
        color: {
          switch (root.connectionState) {
          case "connected": return "#35c759"
          case "connecting": return "#ffb020"
          case "error": return "#ff453a"
          case "running": return "#ffb020"
          default: return "#7d8590"
          }
        }
        border.width: 1
        border.color: "#ffffff"
      }
    }
  }

  onPressed: function(button) {
    if (button === Qt.LeftButton && bar) {
      bar.run(root.helper + " toggle")
      refreshDelay.restart()
    }
  }

  function refresh() {
    if (!statusProcess.running) statusProcess.running = true
  }

  Process {
    id: statusProcess
    command: [root.helper, "status"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        var next = String(text || "").trim()
        root.connectionState = next === "" ? "stopped" : next
      }
    }
  }

  Timer {
    interval: 3000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }

  Timer {
    id: refreshDelay
    interval: 800
    repeat: false
    onTriggered: root.refresh()
  }
}
