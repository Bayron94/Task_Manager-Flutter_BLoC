
# **Task Manager App**

Task Manager es una aplicación móvil desarrollada con Flutter que permite a los usuarios gestionar sus tareas diarias de manera eficiente. Incluye funcionalidades como agregar, eliminar, y marcar tareas como completadas, con soporte para filtros y persistencia de datos.

---

## **Características**

- 📋 **Gestión de Tareas**:
  - Listar las tareas.
  - Agregar nuevas tareas con título y descripción.
  - Eliminar tareas con confirmación de acción.
  - Marcar tareas como completadas.

- 🔍 **Filtros**:
  - Ver todas las tareas.
  - Filtrar tareas completadas.
  - Filtrar tareas no completadas.

- 🛠 **Persistencia de Datos**:
  - Las tareas se guardan localmente utilizando Hive, incluso al cerrar la aplicación.

- 🎨 **Interfaz Personalizada**:
  - Basada en los principios de Material Design.
  - Diseño modular y reutilizable con widgets desacoplados.

- 🚀 **Arquitectura Escalable**:
  - Basada en Clean Architecture.
  - Uso de BLoC (Business Logic Component) para la gestión de estados.
  - Modularidad y separación de responsabilidades.

---

## **Tecnologías Utilizadas**

- **Framework**: Flutter
- **Gestión de Estado**: Flutter Bloc
- **Persistencia de Datos**: Hive
- **Manejo de Errores**: Dartz (para manejar `Either<Failure, Success>`)
- **Inyección de Dependencias**: get_it
- **Toast y Notificaciones**: FlutterToast
- **Pruebas**: Unit Testing con Mockito (pendiente de implementación)

---

## **Estructura del Proyecto**

***
lib/
│
├── core/
│   ├── global_listeners.dart        *# Configuración de listeners globales*
│   ├── theme.dart                   *# Tema de la aplicación*
│   ├── errors/                      *# Definición de errores comunes*
│   ├── dependency_injection.dart    *# Configuración de inyección de dependencias*
│
├── features/
│   └── task/
│       ├── data/
│       │   ├── datasources/         *# Manejo de Hive para persistencia*
│       │   ├── models/              *# Modelos de datos para Hive y conversiones*
│       │   ├── repositories/        *# Implementaciones de repositorios*
│       │
│       ├── domain/
│       │   ├── entities/            *# Entidades del dominio*
│       │   ├── repositories/        *# Interfaces de repositorios del dominio*
│       │   ├── usecases/            *# Casos de uso: Crear, Eliminar, etc.*
│       │
│       ├── presentation/
│       |   ├── blocs/               *# Gestión de estados con Bloc*
│       |   ├── screens/             *# Pantallas principales*
│       |   ├── widgets/             *# Widgets reutilizables (Dialog, Chips, etc.)*
|       |   
│       ├── shared/                  *# Elementos compartidos*
│
└── main.dart                        *# Punto de entrada de la aplicación*
***

---

## **Requisitos Previos**

- Flutter SDK instalado ([Instrucciones](https://docs.flutter.dev/get-started/install)).
- Dispositivo físico o emulador configurado.

---

## **Configuración e Instalación**

1. **Clona el repositorio**:
   ***
   git clone [git@github.com:Bayron94/Task_Manager-Flutter_BLoC.git](https://github.com/Bayron94/Task_Manager-Flutter_BLoC.git)
   cd task-manager
   ***

2. **Instala las dependencias**:
   ***
   flutter pub get
   ***

3. **Ejecuta la aplicación**:
   - En un dispositivo físico o emulador:
     ***
     flutter run
     ***

4. **Construcción del APK** (opcional):
   ***
   flutter build apk --release
   ***

---

## **Componentes Clave**

### **Bloc (TaskBloc)**
- Centraliza toda la lógica de negocio.
- Maneja los eventos:
  - `LoadTasks`: Cargar todas las tareas desde Hive.
  - `AddTask`: Agregar una nueva tarea.
  - `UpdateTask`: Marcar una tarea como completada.
  - `DeleteTask`: Eliminar una tarea.
  - `ChangeFilter`: Aplicar filtros.

### **Listeners Globales**
- Configurados en `global_listeners.dart`.
- Muestra mensajes (`Toast`) o interacciones globales según el estado del Bloc.

### **Widgets Reutilizables**
- `TaskFilterChips`: Muestra los filtros de tareas como chips interactivos.
- `TaskItem`: Representa una tarea individual.
- `CustomDialog`: Diálogo reutilizable para confirmaciones.
- `CreateTaskBottomSheet`: Hoja modal para agregar nuevas tareas.

---

## **Próximas Mejoras**

- 🔍 Implementación de búsquedas.
- 🧪 Cobertura completa de pruebas unitarias.
- 📤 Sincronización con API remota.

---

## **Contribuciones**

¡Las contribuciones son bienvenidas! Si tienes ideas o mejoras, por favor abre un `pull request` o reporta un problema en el repositorio.

---

## **Contacto**

Desarrollador: Bayron Ordoñez  
Email: [bayron.ordonez94@gmail.com](mailto:bayron.ordonez94@gmail.com)

---
