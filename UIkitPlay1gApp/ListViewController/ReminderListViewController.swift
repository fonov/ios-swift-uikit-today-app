//
//  ViewController.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 10.01.23.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

  var dataSource: DataSource!
  var reminders: [Reminder] = []
  var filteredReminders: [Reminder] {
    return reminders
      .filter { listStyle.shouldInclude(date: $0.dueDate) }
      .sorted { $0.dueDate < $1.dueDate }
  }
  var listStyle: ReminderListStyle = .today
  let listStyleSegmentControl = UISegmentedControl(items: [
    ReminderListStyle.today.name,
    ReminderListStyle.future.name,
    ReminderListStyle.all.name,
  ])
  var headerView: ProgressHeaderView?
  var progress: CGFloat {
    let chunkSize = 1.0 / CGFloat(filteredReminders.count)
    let progress = filteredReminders.reduce(0) {
      let chunk = $1.isComplete ? chunkSize : 0
      return $0 + chunk
    }
    return progress
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    collectionView.backgroundColor = .systemGray2

    let listLayout = listLayout()
    collectionView.collectionViewLayout = listLayout

    let cellRegistration = UICollectionView.CellRegistration(handler: self.cellRegistrationHandler)

    dataSource = DataSource(collectionView: collectionView) { (cell: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
      return self.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    }

    let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler)
    dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
      return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
    addButton.accessibilityLabel = NSLocalizedString("Add reminder", comment: "Add button accessibility label")
    navigationItem.rightBarButtonItem = addButton

    listStyleSegmentControl.selectedSegmentIndex = listStyle.rawValue
    listStyleSegmentControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
    navigationItem.titleView = listStyleSegmentControl

    updateSnapshot()
    
    collectionView.dataSource = dataSource

    prepareReminderStore()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refreshBackground()
  }

  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let id = filteredReminders[indexPath.item].id
    showDetail(for: id)
    return false
  }

  override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    guard elementKind == ProgressHeaderView.elementKind, let progressView = view as? ProgressHeaderView else { return }
    progressView.progress = progress
  }

  func refreshBackground() {
    collectionView.backgroundView = nil
    let backgroundView = UIView()
    let gradientLayer = CAGradientLayer.gradientLayer(for: listStyle, in: collectionView.frame)
    backgroundView.layer.addSublayer(gradientLayer)
    collectionView.backgroundView = backgroundView
  }

  func showDetail(for id: Reminder.ID) {
    let reminder = reminder(for: id)
    let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
      self?.update(reminder, with: reminder.id)
      self?.updateSnapshot(reloading: [reminder.id])
    }
    navigationController?.pushViewController(viewController, animated: true)
  }

  func listLayout() -> UICollectionViewLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
    listConfiguration.headerMode = .supplementary
    listConfiguration.showsSeparators = false
    listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
    listConfiguration.backgroundColor = .clear
    return UICollectionViewCompositionalLayout.list(using: listConfiguration)
  }

  func makeSwipeActions(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    guard let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
    let deleteTitle = NSLocalizedString("Delete", comment: "Delete action title")
    let deleteAction = UIContextualAction(style: .destructive, title: deleteTitle) { [weak self] _, _, completion in
      self?.deleteReminder(with: id)
      self?.updateSnapshot()
      completion(false)
    }
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }

  func supplementaryRegistrationHandler(progressView: ProgressHeaderView, elementKind: String, indexPath: IndexPath) {
    headerView = progressView
  }

  func showError(_ error: Error) {
    let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
    let alert = UIAlertController(title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
    let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
    alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { [weak self] _ in
      self?.dismiss(animated: true)
    }))
    present(alert, animated: true, completion: nil)
  }
}

