//
//  ReminderViewContoller+Actions.swift
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
}
