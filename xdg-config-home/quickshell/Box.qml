import QtQuick

Rectangle {
  default property Item child

  radius: 5
  color: "black"

  implicitWidth: child.implicitWidth
  implicitHeight: child.implicitHeight

  children: [child]
}
