//
//  ReminderViewController+Section.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 13.01.23.
//

import UIKit

extension ReminderViewController {
  enum Section: Int, Hashable {
    case view
    case title
    case date
    case notes

    var name: String {
      switch self {
      case .view:
        return ""
      case .title:
        return NSLocalizedString("Title", comment: "Title section name")
      case .date:
        return NSLocalizedString("Date", comment: "Date section name")
      case .notes:
        return NSLocalizedString("Notes", comment: "Notes section name")
      }
    }
  }
}
