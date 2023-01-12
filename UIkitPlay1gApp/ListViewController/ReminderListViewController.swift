//
//  ViewController.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 10.01.23.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

  var dataSource: DataSource!
  var reminders: [Reminder] = Reminder.sampleData

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    let listLayout = listLayout()
    collectionView.collectionViewLayout = listLayout

    let cellRegistration = UICollectionView.CellRegistration(handler: self.cellRegistrationHandler)

    dataSource = DataSource(collectionView: collectionView) { (cell: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
      return self.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }

    var snapshot = Snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(reminders.map { $0.id })
    dataSource.apply(snapshot)

    collectionView.dataSource = dataSource
  }

  func listLayout() -> UICollectionViewLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    listConfiguration.showsSeparators = false
    listConfiguration.backgroundColor = .clear
    return UICollectionViewCompositionalLayout.list(using: listConfiguration)
  }
}

