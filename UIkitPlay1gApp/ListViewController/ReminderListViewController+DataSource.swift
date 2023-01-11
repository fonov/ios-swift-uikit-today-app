//
//  ReminderListViewController+Data.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 11.01.23.
//

import UIKit

extension ReminderListViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
    let reminder = Reminder.sampleData[indexPath.item]
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = reminder.title
    //    contentConfiguration.textProperties.color = .darkGray
    contentConfiguration.secondaryText = reminder.dueDate.dateAndTimeText
    contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)

    cell.contentConfiguration = contentConfiguration

    var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
    doneButtonConfiguration.tintColor = .tintColor

    cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]

    var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
    //    backgroundConfig.cornerRadius = 8
    backgroundConfig.backgroundColor = .systemGray6

    cell.backgroundConfiguration = backgroundConfig
  }

  func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
    let symbolName = reminder.isComplete ? "circle.fill" : "circle"
    let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
    let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
    let button = UIButton()
    button.setImage(image, for: .normal)
    return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
  }
}
