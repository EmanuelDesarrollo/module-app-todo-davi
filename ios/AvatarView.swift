import ExpoModulesCore
import UIKit

public class AvatarView: ExpoView {

  private let circle = UIView()
  private let label = UILabel()

  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    setupView()
  }

  private func setupView() {
    // Use an inner view for the colored circle so RN layout doesn't override it
    circle.translatesAutoresizingMaskIntoConstraints = false
    circle.clipsToBounds = true
    addSubview(circle)
    NSLayoutConstraint.activate([
      circle.topAnchor.constraint(equalTo: topAnchor),
      circle.bottomAnchor.constraint(equalTo: bottomAnchor),
      circle.leadingAnchor.constraint(equalTo: leadingAnchor),
      circle.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])

    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.translatesAutoresizingMaskIntoConstraints = false
    circle.addSubview(label)
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
    ])
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    circle.layer.cornerRadius = min(bounds.width, bounds.height) / 2
  }

  var name: String = "" {
    didSet {
      label.text = extractInitials(from: name)
      circle.backgroundColor = generateColor(from: name)
    }
  }

  private func extractInitials(from name: String) -> String {
    let words = name.trimmingCharacters(in: .whitespaces)
      .components(separatedBy: .whitespaces)
      .filter { !$0.isEmpty }
    return words.prefix(2)
      .compactMap { $0.first.map { String($0).uppercased() } }
      .joined()
  }

  // Stable hash matching Java's String.hashCode() used in Android
  private func javaStringHashCode(_ string: String) -> Int {
    var hash: Int32 = 0
    for scalar in string.unicodeScalars {
      hash = 31 &* hash &+ Int32(bitPattern: scalar.value)
    }
    return Int(hash)
  }

  private func generateColor(from name: String) -> UIColor {
    let hue = CGFloat(abs(javaStringHashCode(name)) % 360) / 360.0
    return UIColor(hue: hue, saturation: 0.6, brightness: 0.75, alpha: 1.0)
  }
}
