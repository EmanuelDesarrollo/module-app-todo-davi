# module-app-todo-davi

Módulo nativo de Expo que expone el componente **AvatarView**: una vista circular que genera automáticamente las iniciales de un nombre y un color de fondo único calculado a partir del hash del mismo. Desarrollado para la **KATA Desarrollador Agile Mobile**.

**Repositorio:** [https://github.com/EmanuelDesarrollo/module-app-todo-davi](https://github.com/EmanuelDesarrollo/module-app-todo-davi)

---

## 📦 Versión y Autoría

| Campo   | Valor                                      |
|---------|--------------------------------------------|
| Versión | `0.1.0`                                    |
| Autor   | Emanuel Buendia                            |

---

## 🛠 Stack Tecnológico

| Capa          | Tecnología                         |
|---------------|------------------------------------|
| Lenguaje JS   | TypeScript (tipado estricto)       |
| Framework     | Expo Modules API (`expo-module-scripts`) |
| Android       | Kotlin + Expo Modules SDK          |
| iOS           | Swift + Expo Modules SDK           |
| React Native  | 0.82.1                             |
| Expo          | ^55.0.1                            |

---

## 🗂 Estructura del Proyecto

```
module-app-todo-davi/
├── src/                          # Código TypeScript del módulo (capa JS/TS)
│   ├── index.ts                  # Punto de entrada: re-exporta AvatarView y tipos
│   ├── AvatarView.tsx            # Wrapper React que conecta la vista nativa vía requireNativeView
│   └── ModuleAppTodoDavi.types.ts # Tipos compartidos (AvatarViewProps)
│
├── ios/                          # Implementación nativa iOS (Swift)
│   ├── AvatarView.swift          # Vista UIKit: círculo + iniciales con Auto Layout
│   ├── AvatarModule.swift        # Definición del módulo Expo: expone la prop "name"
│   └── ModuleAppTodoDaviModule.swift # Módulo principal del paquete
│
├── android/                      # Implementación nativa Android (Kotlin)
│   └── src/main/java/expo/modules/moduleapptododavi/
│       ├── AvatarView.kt         # Vista Android: círculo GradientDrawable + iniciales
│       ├── AvatarModule.kt       # Definición del módulo Expo: expone la prop "name"
│       └── ModuleAppTodoDaviModule.kt # Módulo principal del paquete
│
├── build/                        # Artefactos compilados (generado automáticamente)
├── example/                      # App de ejemplo para probar el módulo
├── expo-module.config.json       # Configuración del módulo Expo
├── package.json
└── tsconfig.json
```

---

## 📱 Componente AvatarView

### ¿Qué hace?

Renderiza un círculo de color con las iniciales de un nombre. El color es determinista: el mismo nombre siempre produce el mismo color en Android e iOS porque ambas plataformas replican el algoritmo `String.hashCode()` de Java.

### Props

| Prop    | Tipo     | Requerido | Descripción                                  |
|---------|----------|-----------|----------------------------------------------|
| `name`  | `string` | ✅         | Nombre completo del que se extraen las iniciales |
| `style` | `ViewStyle` | ❌      | Estilos adicionales de React Native          |

### Uso

```tsx
import { AvatarView } from 'module-app-todo-davi';

<AvatarView
  name="David García"
  style={{ width: 48, height: 48 }}
/>
// Resultado: círculo de color con el texto "DG"
```

### Lógica de iniciales

- Se dividen las palabras del nombre por espacios.
- Se toman las primeras dos palabras no vacías.
- Se concatena la primera letra de cada una en mayúscula.
- Ejemplos: `"David García"` → `"DG"`, `"Ana"` → `"A"`.

### Lógica de color

- Se calcula el hash del nombre (algoritmo Java `String.hashCode()`).
- `hue = abs(hash) % 360` → tono entre 0° y 359°.
- Se construye un color HSV/HSB con saturación `0.6` y brillo `0.75`.
- Garantiza consistencia visual entre plataformas.

### Implementación por plataforma

| Plataforma | Clase              | Tecnología de UI                              |
|------------|--------------------|-----------------------------------------------|
| Android    | `AvatarView.kt`    | `TextView` + `GradientDrawable` (forma OVAL)  |
| iOS        | `AvatarView.swift` | `UIView` + `UILabel` + Auto Layout + `cornerRadius` |

---

## 🚀 Instalación y Ejecución

### Instalar dependencias

```bash
npm install
# o
yarn install
```

### iOS — instalar Pods

```bash
cd example/ios && pod install && cd ../..
```

### Compilar el módulo (TypeScript → JS)

```bash
npm run build
```

### Ejecutar la app de ejemplo

```bash
# Android
npm run open:android   # Abre en Android Studio

# iOS
npm run open:ios       # Abre en Xcode
```

### Otros comandos

```bash
npm run lint      # Linter
npm test          # Pruebas unitarias
npm run clean     # Limpia artefactos de build
```

---

## 🤖 Uso de IA

Este proyecto contó con el apoyo de **GitHub Copilot** (modelo Claude Sonnet 4.6) en las siguientes áreas:

### Construcción del módulo nativo AvatarView

Se utilizó GitHub Copilot como asistente durante el desarrollo del componente nativo `AvatarView` en ambas plataformas:

- **Android (`AvatarView.kt`):** Apoyo en el diseño de la lógica de extracción de iniciales, la generación de color determinista con el algoritmo HSV y la creación del `GradientDrawable` circular. Se verificó que la integración con `ExpoView` y la API de módulos de Expo Kotlin fuera correcta.
- **iOS (`AvatarView.swift`):** Apoyo en la implementación con `UIKit` y Auto Layout, el uso de `clipsToBounds` + `cornerRadius` para la forma circular, y la replicación exacta del algoritmo `String.hashCode()` de Java mediante operadores de desbordamiento controlado (`&*`, `&+`) para garantizar colores idénticos entre plataformas.
- **Capa TypeScript (`AvatarView.tsx`, `types.ts`):** Apoyo en conectar la vista nativa a React Native a través de `requireNativeView` y en definir los tipos de props con TypeScript estricto.

### Documentación del código

GitHub Copilot generó los comentarios explicativos en español para los archivos nativos:

- [android/…/AvatarView.kt](android/src/main/java/expo/modules/moduleapptododavi/AvatarView.kt) — comentarios KDoc en cada clase, propiedad y función.
- [ios/AvatarView.swift](ios/AvatarView.swift) — comentarios de documentación Swift en cada método.

### Supervisión y criterio técnico

Toda la lógica fue revisada y validada manualmente: la coherencia del algoritmo de hash entre plataformas, el comportamiento del layout nativo y la integración con el sistema de módulos de Expo.
