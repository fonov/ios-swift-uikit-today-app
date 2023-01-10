//
//  ViewController.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 10.01.23.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

  var dataSource: DataSource!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    let listLayout = listLayout()
    collectionView.collectionViewLayout = listLayout

    let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
      let reminder = Reminder.sampleData[indexPath.item]
      var contentConfiguration = cell.defaultContentConfiguration()
      contentConfiguration.text = reminder.title
      cell.contentConfiguration = contentConfiguration
    }

    dataSource = DataSource(collectionView: collectionView) { (cell: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
      return self.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }

    var snapshot = Snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(Reminder.sampleData.map { $0.title })
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

