package expo.modules.moduleapptododavi

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.view.Gravity
import android.widget.TextView
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.views.ExpoView
import kotlin.math.abs

/**
 * Vista nativa de Android que muestra un avatar circular con las iniciales de un nombre.
 * Extiende ExpoView para integrarse con el sistema de módulos de Expo/React Native.
 *
 * @param context  Contexto de Android necesario para crear las vistas nativas.
 * @param appContext  Contexto de la aplicación Expo que gestiona el ciclo de vida del módulo.
 */
class AvatarView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {

  /**
   * TextView interno que muestra las iniciales del nombre.
   * Se configura para ocupar todo el espacio disponible,
   * centrar el texto, usar tamaño 24sp, color blanco y negrita.
   */
  private val textView = TextView(context).apply {
    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
    gravity = Gravity.CENTER
    textSize = 24f      
    setTextColor(Color.WHITE)
    typeface = Typeface.DEFAULT_BOLD 
  }

  /**
   * Bloque de inicialización: se ejecuta al crear la vista.
   * Añade el TextView como hijo para que sea renderizado dentro del avatar.
   */
  init {
    addView(textView)
  }

  /**
   * Punto de entrada principal para configurar el avatar a partir de un nombre.
   * Extrae las iniciales, genera el color de fondo y aplica ambos a la vista.
   *
   * @param name  Nombre completo del usuario (ej. "David García").
   */
  fun setName(name: String) {
    val initials = extractInitials(name)
    val bgColor = generateColor(name)
    textView.text = initials
    background = createCircleDrawable(bgColor)
  }

  /**
   * Extrae hasta dos iniciales del nombre recibido.
   * Divide el nombre por espacios, toma las dos primeras palabras
   * no vacías y devuelve su primera letra en mayúscula.
   *
   * Ejemplo: "David García" → "DG"
   *
   * @param name  Nombre del que se extraen las iniciales.
   * @return  Cadena con una o dos letras en mayúscula.
   */
  private fun extractInitials(name: String): String {
    return name.trim()
      .split("\\s+".toRegex()) // Divide por uno o más espacios en blanco
      .filter { it.isNotEmpty() } // Descarta elementos vacíos resultantes del split
      .take(2)                    // Toma máximo las dos primeras palabras
      .joinToString("") { it[0].uppercaseChar().toString() } // Primera letra de cada palabra en mayúscula
  }

  /**
   * Genera un color HSV determinista basado en el hash del nombre.
   * Usa el valor absoluto del hashCode para calcular un tono (hue) entre 0 y 359 grados,
   * manteniendo una saturación y valor fijos para que los colores sean siempre vivos y legibles.
   *
   * @param name  Nombre usado como semilla para el cálculo del color.
   * @return  Color en formato ARGB (entero de 32 bits).
   */
  private fun generateColor(name: String): Int {
    // El operador % 360 garantiza que el tono esté dentro del rango válido [0, 360)
    val hue = (abs(name.hashCode()) % 360).toFloat()
    // Saturación 0.6 → colores moderadamente vivos; Valor 0.75 → brillo medio-alto
    return Color.HSVToColor(floatArrayOf(hue, 0.6f, 0.75f))
  }

  /**
   * Crea un drawable circular (forma OVAL) con el color de fondo indicado.
   * Este drawable se asigna como fondo de la vista para lograr el efecto de avatar redondo.
   *
   * @param color  Color de relleno del círculo en formato ARGB.
   * @return  GradientDrawable configurado como círculo relleno del color dado.
   */
  private fun createCircleDrawable(color: Int): GradientDrawable {
    return GradientDrawable().apply {
      shape = GradientDrawable.OVAL 
      setColor(color)
    }
  }
}
