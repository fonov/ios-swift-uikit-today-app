//
//  ReminderViewController+CellConfiguration.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 13.01.23.
//

import UIKit

extension ReminderViewController {
  func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = text(for: row)
    contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
    contentConfiguration.image = row.image
    return contentConfiguration
  }

  func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = title
    return contentConfiguration
  }

  func titleConfiguration(for ceil: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
    var contentConfiguration = ceil.textFieldConfiguration()
    contentConfiguration.text = title
    return contentConfiguration
  }

  func notesConfiguration(for ceil: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
    var contentConfiguration = ceil.textViewConfiguration()
    contentConfiguration.text = notes
    return contentConfiguration
  }

  func dateConfiguration(for ceil: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
    var contentConfiguration = ceil.datePickerConfiguration()
    contentConfiguration.date = date
    return contentConfiguration
  }

  func text(for row: Row) -> String? {
    switch row {
    case .viewDate: return reminder.dueDate.dayText
    case .viewNotes: return reminder.notes
    case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
    case .viewTitle: return reminder.title
    default:
      return nil
    }
  }
}
