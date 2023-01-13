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

    updateSnapshot()
    
    collectionView.dataSource = dataSource
  }

  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let id = reminders[indexPath.item].id
    showDetail(for: id)
    return false
  }

  func showDetail(for id: Reminder.ID) {
    let reminder = reminder(for: id)
    let viewController = ReminderViewController(reminder: reminder)
    navigationController?.pushViewController(viewController, animated: true)
  }

  func listLayout() -> UICollectionViewLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    listConfiguration.showsSeparators = false
    listConfiguration.backgroundColor = .clear
    return UICollectionViewCompositionalLayout.list(using: listConfiguration)
  }
}

