import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData

      screen: modelData
      anchors {
        top: true
        left: true
        right: true
      }
      color: "transparent"
      implicitHeight: content.implicitHeight

      RowLayout {
        id: content
        anchors.fill: parent

        RowLayout {
          anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
          }

          Box {
            Text {
              color: "white"
              text: UPower.displayDevice.percentage * 100
            }
          }
          Box {
            Clock { }
          }
          Box {
            RowLayout {
              Repeater {
                model: SystemTray.items

                Text {
                  required property SystemTrayItem modelData

                  color: "white"
                  text: modelData.icon
                }
              }
            }
          }
        }
        RowLayout {
          anchors.centerIn: parent

          Box {
            HyprlandWorkspaces { }
          }
        }
        RowLayout {
          anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
          }

          Box {
            Text {
              color: "white"
              font.family: "Material Symbols Rounded"
              text: PowerProfiles.profile == PowerProfile.PowerSaver ? "" :
                PowerProfiles.profile == PowerProfile.Balanced ? "" :
                PowerProfiles.profile == PowerProfile.Performance ? "" : ""
            }
          }
        }
      }
    }
  }
}
