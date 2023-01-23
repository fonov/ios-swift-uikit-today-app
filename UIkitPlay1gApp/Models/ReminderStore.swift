//
//  ReminderStore.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 23.01.23.
//

import Foundation
import EventKit

class ReminderStore {
  static let shared = ReminderStore()

  private let ekStore = EKEventStore()

  var isAvailable: Bool {
    EKEventStore.authorizationStatus(for: .reminder) == .authorized
  }

  func readAll() async throws -> [Reminder] {
    guard isAvailable else {
      throw TodayError.accessDenied
    }

    let predicate = ekStore.predicateForReminders(in: nil)
  }
}
