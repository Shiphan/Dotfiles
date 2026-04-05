pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string clockEmoji: {
    ["󱑊 ", "󱐿 ", "󱑀 ", "󱑁 ", "󱑃 ", "󱑂 ", "󱑄 ", "󱑅 ", "󱑆 ", "󱑇 ", "󱑈 ", "󱑉 "][clock.hours % 12]
  }
  readonly property string time: {
    Qt.formatDateTime(clock.date, "M/d ddd h:mm AP")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
