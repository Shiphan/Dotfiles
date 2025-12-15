import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
  Repeater {
    model: Hyprland.workspaces

    Text {
      required property HyprlandWorkspace modelData

      color: "white"

      text: modelData.focused ? `> ${modelData.name} <` : modelData.name
    }
  }
}
