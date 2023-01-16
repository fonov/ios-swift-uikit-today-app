//
//  DatePickerContentView.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 15.01.23.
//

import UIKit

class DatePickerContentView: UIView, UIContentView {
  struct Configuration: UIContentConfiguration {
    var date: Date = .now
    var onChange: (Date) -> Void = { _ in }

    func makeContentView() -> UIView & UIContentView {
      return DatePickerContentView(self)
    }
  }

  let dateView = UIDatePicker()
  var configuration: UIContentConfiguration {
    didSet {
      configuration(configuration: configuration)
    }
  }

  override var intrinsicContentSize: CGSize {
    CGSize(width: 0, height: 44)
  }

  init(_ configuration: UIContentConfiguration) {
    self.configuration = configuration
    super.init(frame: .zero)
    addPinnedSubview(dateView)
    dateView.preferredDatePickerStyle = .inline
    dateView.addTarget(self, action: #selector(didPick(_:)), for: .valueChanged)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configuration(configuration: UIContentConfiguration) {
    guard let configuration = configuration as? Configuration  else { return }
    dateView.date = configuration.date
  }

  @objc
  func didPick(_ sender: UIDatePicker) {
    guard let configuration = configuration as? DatePickerContentView.Configuration  else { return }
    configuration.onChange(sender.date)
  }
}

extension UICollectionViewListCell {
  func datePickerConfiguration() -> DatePickerContentView.Configuration {
    DatePickerContentView.Configuration()
  }
}

