//
//  ReminderListStyle.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 17.01.23.
//

import Foundation

enum ReminderListStyle: Int {
  case today
  case future
  case all

  func shouldInclude(date: Date) -> Bool {
    let isInToday = Locale.current.calendar.isDateInToday(date)

    switch self {
    case .today:
      return isInToday
    case .future:
      return (date > Date.now) && !isInToday
    case .all:
      return true
    }
  }

  var name: String {
    switch self {
    case .today:
      return NSLocalizedString("Today", comment: "Today style name")
    case .future:
      return NSLocalizedString("Futute", comment: "Future style name")
    case .all:
      return NSLocalizedString("All", comment: "All style name")
    }
  }
}
