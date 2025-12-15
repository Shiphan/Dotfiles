import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 0

  Text {
    color: "white"
    text: Time.clockEmoji
  }
  Text {
    color: "white"
    text: Time.time
  }
}
