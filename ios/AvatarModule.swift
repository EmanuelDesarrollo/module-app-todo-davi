import ExpoModulesCore

public class AvatarModule: Module {
  public func definition() -> ModuleDefinition {
    Name("AvatarView")

    View(AvatarView.self) {
      Prop("name") { (view: AvatarView, name: String) in
        view.name = name
      }
    }
  }
}
