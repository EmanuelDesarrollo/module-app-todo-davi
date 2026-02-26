import ExpoModulesCore
import UIKit

/**
 * Vista nativa de iOS que muestra un avatar circular con las iniciales de un nombre.
 * Extiende ExpoView para integrarse con el sistema de módulos de Expo/React Native.
 */
public class AvatarView: ExpoView {

  /// UIView interna que actúa como el círculo de color de fondo del avatar.
  /// Se usa una subvista dedicada para que el sistema de layout de React Native
  /// no interfiera con el redondeo de esquinas.
  private let circle = UIView()

  /// UILabel que muestra las iniciales del nombre centradas dentro del círculo.
  private let label = UILabel()

  /// Inicializador requerido por ExpoView.
  /// Llama a setupView() para construir y configurar la jerarquía de vistas.
  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    setupView()
  }

  /// Construye y configura la jerarquía de vistas del avatar.
  /// Primero añade y ancla el círculo al contenedor, luego añade y centra
  /// el label de iniciales dentro del círculo.
  private func setupView() {
    // Desactiva las constraints automáticas de autoresizing para usar Auto Layout manual.
    // Se usa un inner view para el círculo de color para que el layout de RN no lo sobreescriba.
    circle.translatesAutoresizingMaskIntoConstraints = false
    // clipsToBounds = true asegura que el cornerRadius recorte el contenido dentro del círculo
    circle.clipsToBounds = true
    addSubview(circle)

    // Ancla el círculo a los cuatro bordes del contenedor para que ocupe todo el espacio
    NSLayoutConstraint.activate([
      circle.topAnchor.constraint(equalTo: topAnchor),
      circle.bottomAnchor.constraint(equalTo: bottomAnchor),
      circle.leadingAnchor.constraint(equalTo: leadingAnchor),
      circle.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])

    // Configura el label: texto centrado, color blanco y fuente negrita de 24pt
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.translatesAutoresizingMaskIntoConstraints = false
    circle.addSubview(label)

    // Centra el label horizontal y verticalmente dentro del círculo
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: circle.centerYAnchor)
    ])
  }

  /// Se llama cada vez que el sistema de layout recalcula el tamaño de la vista.
  /// Aquí se actualiza el cornerRadius para mantener la forma circular
  /// independientemente del tamaño asignado por React Native.
  override public func layoutSubviews() {
    super.layoutSubviews()
    // La mitad del lado menor garantiza un círculo perfecto aunque la vista sea rectangular
    circle.layer.cornerRadius = min(bounds.width, bounds.height) / 2
  }

  /// Propiedad observable que almacena el nombre del usuario.
  /// Cada vez que cambia (didSet), se actualizan las iniciales y el color de fondo.
  var name: String = "" {
    didSet {
      label.text = extractInitials(from: name)           // Actualiza el texto con las nuevas iniciales
      circle.backgroundColor = generateColor(from: name) // Actualiza el color del círculo
    }
  }

  /// Extrae hasta dos iniciales del nombre recibido.
  /// Divide el nombre por espacios, toma las dos primeras palabras no vacías
  /// y devuelve la primera letra de cada una en mayúscula.
  ///
  /// Ejemplo: "David García" → "DG"
  ///
  /// - Parameter name: Nombre completo del usuario.
  /// - Returns: Cadena con una o dos letras en mayúscula.
  private func extractInitials(from name: String) -> String {
    let words = name.trimmingCharacters(in: .whitespaces) // Elimina espacios al inicio y al final
      .components(separatedBy: .whitespaces)              // Divide en palabras por cualquier espacio
      .filter { !$0.isEmpty }                             // Descarta palabras vacías
    return words.prefix(2)                               // Toma máximo las dos primeras palabras
      .compactMap { $0.first.map { String($0).uppercased() } } // Primera letra de cada palabra en mayúscula
      .joined()                                          // Une las letras en una sola cadena
  }

  /// Implementación del algoritmo hashCode() de Java para cadenas.
  /// Garantiza que el color generado sea idéntico al producido en Android,
  /// ya que ambas plataformas usan el mismo hash como semilla.
  ///
  /// Fórmula: hash = 31 * hash + charCode  (con desbordamiento controlado &* y &+)
  ///
  /// - Parameter string: Cadena cuyo hash se calculará.
  /// - Returns: Valor entero equivalente al de Java String.hashCode().
  private func javaStringHashCode(_ string: String) -> Int {
    var hash: Int32 = 0
    for scalar in string.unicodeScalars {
      // &* y &+ permiten el desbordamiento aritmético intencional, igual que Java
      hash = 31 &* hash &+ Int32(bitPattern: scalar.value)
    }
    return Int(hash)
  }

  /// Genera un color HSV determinista basado en el hash del nombre.
  /// Usa el valor absoluto del hash para calcular un tono (hue) entre 0 y 1,
  /// con saturación y brillo fijos para que los colores sean siempre vivos y legibles.
  ///
  /// - Parameter name: Nombre usado como semilla para el cálculo del color.
  /// - Returns: UIColor generado a partir del tono calculado.
  private func generateColor(from name: String) -> UIColor {
    // % 360 acota el valor al rango [0, 360) y se divide entre 360 para normalizarlo a [0, 1)
    let hue = CGFloat(abs(javaStringHashCode(name)) % 360) / 360.0
    // Saturación 0.6 → colores moderadamente vivos; Brillo 0.75 → luminosidad media-alta
    return UIColor(hue: hue, saturation: 0.6, brightness: 0.75, alpha: 1.0)
  }
}
