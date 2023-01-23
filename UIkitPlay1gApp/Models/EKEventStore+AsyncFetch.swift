//
//  EKEventStore+AsyncFetch.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 23.01.23.
//

import Foundation
import EventKit

extension EKEventStore {
  func fetchReminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
    try await withCheckedThrowingContinuation { continuation in
      fetchReminders(matching: predicate) { reminders in
        if let reminders {
          continuation.resume(returning: reminders)
        } else {
          continuation.resume(throwing: TodayError.failedReadingReminders)
        }
      }
    }
  }
}
