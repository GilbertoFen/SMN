# 🧠 MindCare — Hackaton iOS App

Aplicación iOS desarrollada en SwiftUI conectada a Firebase, orientada al bienestar mental. Permite a los usuarios encontrar psicólogos cercanos, agendar citas, registrar su estado emocional diario y ver estadísticas de su progreso.

---

## 🚀 Tecnologías

- **SwiftUI** — UI declarativa
- **Firebase Firestore** — Base de datos en tiempo real
- **Firebase Authentication** — Login y registro con email/contraseña
- **MapKit** — Mapa de psicólogos cercanos
- **Swift Charts** — Gráfica de estadísticas emocionales
- **Combine** — Manejo de estado reactivo

---

## 📁 Estructura del Proyecto

```
Hackaton/
├── App/
│   └── HackatonApp.swift          # Entry point, manejo de sesión
│
├── Auth/
│   ├── AuthDataSource.swift
│   ├── AuthRepository.swift
│   ├── AuthViewModel.swift
│   ├── LoginView.swift
│   └── RegisterView.swift
│
├── Psychologists/
│   ├── PsycologistModel.swift
│   ├── PsychologistDataSource.swift
│   ├── PsycologistRepository.swift
│   ├── PsycologistViewModel.swift
│   ├── PsycologistDetailView.swift
│   └── PsycologistDetailViewModel.swift
│
├── Appointments/
│   ├── AppointmentModel.swift
│   ├── AppointmentDataSource.swift
│   ├── AppointmentRepository.swift
│   ├── AppointmentViewModel.swift
│   ├── AppointmentsView.swift
│   ├── CalendarView.swift
│   ├── AppointmentRow.swift
│   └── AnimatedDropdownMenu.swift
│
├── Stats/
│   ├── StatModel.swift
│   ├── StatDataSource.swift
│   ├── StatRepository.swift
│   ├── StatViewModel.swift
│   └── StatsView.swift
│
├── Notes/
│   ├── NoteModel.swift
│   ├── NoteDataSource.swift
│   ├── NoteRepository.swift
│   └── NoteCardView.swift
│
├── Comments/
│   ├── CommentModel.swift
│   ├── CommentDataSource.swift
│   └── CommentRepository.swift
│
├── Home/
│   ├── HomeView.swift             # Vista principal
│   ├── HomeView2.swift            # Lista de psicólogos con swipe cards
│   └── MapView.swift
│
├── Profile/
│   ├── ProfileView.swift
│   └── ChangePasswordView.swift
│
├── Onboarding/
│   ├── tabviewOnboarding.swift
│   ├── Onboarding0.swift
│   ├── Onboarding.swift
│   └── DailyCheckIn.swift
│
├── Shared/
│   ├── tabviewapp.swift           # TabView principal
│   ├── Helpers.swift              # formatDateString, etc.
│   ├── ConditionModel.swift
│   ├── ConditionDetailView.swift
│   └── EmotionModel.swift
│
└── Collaborator/
    ├── CardView.swift
    ├── ModelData.swift
    ├── SwipeCardsView.swift
    ├── TravelCard.swift
    └── CardsView.swift
```

---

## 🔥 Firebase — Colecciones

### `psycologists`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| name | String | Nombre del psicólogo |
| age | Int | Edad |
| latitude | Double | Coordenada latitud |
| longitude | Double | Coordenada longitud |
| mode | Array\<String\> | `["online", "onsite"]` |
| price | Double | Precio por consulta en MXN |
| specialit | String | Especialidad |
| description | String | Descripción del psicólogo |
| photoName | String | Nombre del asset en el proyecto |

### `appointments`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| comment | String | Comentario de la cita |
| date | String | Fecha formato `yyyy-MM-dd` |
| hour | String | Hora formato `HH:mm` (24h) |
| id_psycologist | String | Nombre o ID del psicólogo |
| id_user | String | UID del usuario (Firebase Auth) |
| estado | String | `"pendiente"` o `"realizada"` |
| location | String | Ubicación de la cita |
| calificacion | Int | Calificación del 1 al 5 |

### `stats`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| emotion | String | `"Feliz"`, `"Triste"`, `"Enojado"`, `"Ansiedad"`, `"Calma"` |
| date | String | Fecha formato `yyyy-MM-dd` |
| id_user | String | UID del usuario |
| rating | Int | Del 1 al 10 |

### `notes`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| content | String | Contenido de la nota |
| date | String | Fecha formato `yyyy-MM-dd` |
| id_user | String | UID del usuario |
| rating | Double | Del 0.0 al 1.0 (≥ 0.5 = destacada) |

### `comments`
| Campo | Tipo | Descripción |
|-------|------|-------------|
| comment | String | Texto del comentario |
| id_psycologist | String | ID del psicólogo |
| id_user | String | UID del usuario |
| rating | Int | Calificación del 1 al 5 |

---

## 🧭 Flujo de la App

```
HackatonApp
    ├── isLoggedIn = false → LoginView → RegisterView
    └── isLoggedIn = true  → tabviewOnboarding
                                └── tabviewapp
                                    ├── 🏠 HomeView         — Próxima cita, emociones, mapa
                                    ├── 📋 CardView         — Trastornos (JSON local)
                                    ├── 👥 HomeView2        — Psicólogos con swipe cards
                                    ├── 📊 StatsView        — Gráfica emocional + notas
                                    ├── 📅 AppointmentsView — Calendario de citas
                                    └── 👤 ProfileView      — Configuración y logout
```

---

## 🏗 Arquitectura

El proyecto sigue el patrón **MVVM** con una capa de repositorio:

```
View → ViewModel → Repository → DataSource → Firebase
```

- **DataSource** — Comunicación directa con Firebase
- **Repository** — Abstracción entre DataSource y ViewModel
- **ViewModel** — Lógica de negocio y estado con `@Published`
- **View** — UI declarativa en SwiftUI

---

## ⚙️ Setup

### Requisitos
- Xcode 15+
- iOS 17+
- Cuenta de Firebase

### Instalación

1. Clona el repositorio
2. Abre `Hackaton.xcodeproj` en Xcode
3. Agrega tu `GoogleService-Info.plist` en la raíz del proyecto
4. En Firebase Console habilita:
   - **Firestore Database**
   - **Authentication → Email/Password**
5. Corre el proyecto en simulador o dispositivo

### Dependencias (Swift Package Manager)
- `firebase-ios-sdk` — FirebaseFirestore, FirebaseAuth, FirebaseFirestoreCombineSwift


