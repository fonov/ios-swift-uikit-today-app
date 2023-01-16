//
//  ReminderViewController+Actions.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 12.01.23.
//

import UIKit

extension ReminderListViewController {
  @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
    guard let id = sender.id else { return }
    completeReminder(with: id)
  }

  @objc func didPressAddButton(_ sender: UIBarButtonItem) {
    let reminder = Reminder(title: "", dueDate: .now)
    let viewController = ReminderViewController(reminder: reminder, onChange: { [weak self] _ in })
    viewController.isAddingNewReminder = true
    viewController.setEditing(true, animated: false)
    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
    viewController.navigationItem.title = NSLocalizedString("Add reminder", comment: "Add reminder view  controller title")
    let navigationController = UINavigationController(rootViewController: viewController)
    present(navigationController, animated: true)
  }

  @objc func didCancelAdd(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
}
