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

class AvatarView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {

  private val textView = TextView(context).apply {
    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
    gravity = Gravity.CENTER
    textSize = 24f
    setTextColor(Color.WHITE)
    typeface = Typeface.DEFAULT_BOLD
  }

  init {
    addView(textView)
  }

  fun setName(name: String) {
    val initials = extractInitials(name)
    val bgColor = generateColor(name)
    textView.text = initials
    background = createCircleDrawable(bgColor)
  }

  private fun extractInitials(name: String): String {
    return name.trim()
      .split("\\s+".toRegex())
      .filter { it.isNotEmpty() }
      .take(2)
      .joinToString("") { it[0].uppercaseChar().toString() }
  }

  private fun generateColor(name: String): Int {
    val hue = (abs(name.hashCode()) % 360).toFloat()
    return Color.HSVToColor(floatArrayOf(hue, 0.6f, 0.75f))
  }

  private fun createCircleDrawable(color: Int): GradientDrawable {
    return GradientDrawable().apply {
      shape = GradientDrawable.OVAL
      setColor(color)
    }
  }
}
