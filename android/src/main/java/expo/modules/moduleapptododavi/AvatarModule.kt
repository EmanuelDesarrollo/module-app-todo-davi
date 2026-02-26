package expo.modules.moduleapptododavi

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class AvatarModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("AvatarView")

    View(AvatarView::class) {
      Prop("name") { view: AvatarView, name: String ->
        view.setName(name)
      }
    }
  }
}
