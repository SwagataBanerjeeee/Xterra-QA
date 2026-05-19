# Xterra — Flutter Mobile App

A production-ready Flutter application built with Clean Architecture, featuring phone-based authentication, responsive layouts, and a multi-environment API setup.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Features](#features)
- [Tech Stack & Dependencies](#tech-stack--dependencies)
- [Environment Configuration](#environment-configuration)
- [Authentication Flow](#authentication-flow)
- [State Management](#state-management)
- [Navigation & Routing](#navigation--routing)
- [Networking](#networking)
- [Local Storage](#local-storage)
- [UI & Theming](#ui--theming)
- [Dependency Injection](#dependency-injection)
- [Getting Started](#getting-started)
- [Known TODOs](#known-todos)

---

## Overview

Xterra is a Flutter application targeting iOS and Android. It is structured around Clean Architecture principles with a strict separation between data, domain, and presentation layers. The project uses Provider for state management, GoRouter for navigation, Dio for HTTP communication, and Hive for local persistence.

---

## Architecture

The app follows **Clean Architecture** with three distinct layers per feature:

```
Presentation Layer   →   Domain Layer   →   Data Layer
(Pages, Providers)       (Entities,         (Models, Remote/Local
                          UseCases,          DataSources,
                          Repositories)      Repository Impls)
```

### Layer Responsibilities

| Layer | Contents | Role |
|---|---|---|
| Presentation | Pages, Providers, Widgets | UI rendering, user interaction, state |
| Domain | Entities, UseCases, Repository interfaces | Business rules, pure Dart |
| Data | Models, DataSources, Repository impls | API calls, local storage, serialization |

Dependencies always point inward — the domain layer has zero dependencies on Flutter or external packages.

---

## Project Structure

```
lib/
├── main.dart                   # App entry point (dev flavor)
├── bootstrap.dart              # App initialization, DI setup, Hive init
│
├── core/
│   ├── config/                 # Environment configs (dev, UAT, prod)
│   ├── di/                     # GetIt injection container
│   ├── network/                # Dio client, AuthInterceptor
│   ├── storage/                # Hive storage service
│   ├── theme/                  # Light/dark themes, text styles
│   ├── router/                 # GoRouter configuration
│   ├── constants/              # App-wide string constants
│   └── utils/                  # Responsive helpers, extensions
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/    # AuthRemoteDatasource (Dio)
    │   │   ├── models/         # UserModel (JSON serialization)
    │   │   └── repositories/   # AuthRepositoryImpl
    │   ├── domain/
    │   │   ├── entities/       # UserEntity
    │   │   ├── repositories/   # AuthRepository (abstract)
    │   │   └── usecases/       # LoginUsecase, LogoutUsecase
    │   └── presentation/
    │       ├── pages/          # LoginPage
    │       ├── providers/      # AuthProvider
    │       └── widgets/        # CountryPickerSheet
    │
    └── home/
        ├── data/
        │   ├── datasources/    # HomeLocalDatasource (Hive), HomeRemoteDatasource
        │   ├── models/         # HomeModel
        │   └── repositories/   # HomeRepositoryImpl
        ├── domain/
        │   ├── entities/       # HomeEntity
        │   ├── repositories/   # HomeRepository (abstract)
        │   └── usecases/       # GetHomeDataUsecase
        └── presentation/
            ├── pages/          # HomePage
            ├── providers/      # HomeProvider
            └── widgets/        # MobileLayout, TabletLayout
```

---

## Features

### Authentication

- **Phone number login** with country code picker
- Country-specific minimum digit validation
- Searchable country picker modal (50+ countries) with flag emoji and dial code
- Access token + refresh token management
- Automatic silent token refresh on 401 responses with request queuing
- Token persistence via Hive
- Logout with full state and cache clear

### Home / Dashboard

- Responsive dual-layout system:
  - **Mobile** (< 600dp): single-column card list
  - **Tablet** (≥ 600dp): two-column layout with side panel
- Local data caching (Hive) with remote data source ready to wire up
- Loading, success, and error UI states
- Feature showcase cards

---

## Tech Stack & Dependencies

| Package | Version | Purpose |
|---|---|---|
| `go_router` | ^14.6.3 | Declarative navigation |
| `provider` | ^6.1.2 | State management |
| `get_it` | ^8.0.3 | Service locator / DI |
| `dio` | ^5.7.0 | HTTP client |
| `hive_flutter` | ^1.1.0 | Local key-value storage |
| `equatable` | ^2.0.7 | Value equality for entities/models |
| `flutter_screenutil` | ^5.9.3 | Responsive scaling (design ref: 402×874) |
| `flutter_svg` | ^2.0.10 | SVG asset rendering |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

**Dev dependencies:** `flutter_lints ^6.0.0`, `build_runner ^2.4.13`

**Minimum SDK:** Dart 3.7.0 / Flutter (stable)

---

## Environment Configuration

Three environments are supported, each with its own config file under `lib/core/config/`:

| Environment | Base URL |
|---|---|
| Development | `https://api-dev.xterra.com` |
| UAT | `https://api-uat.xterra.com` |
| Production | defined in `prod_config.dart` |

The active environment is selected at build time via the entry point (e.g., `main.dart` uses dev config). Config values are injected into the DI container and consumed by `DioClient`.

---

## Authentication Flow

### Login

```
User enters phone + country code
        ↓
Client-side digit count validation
        ↓
AuthProvider.login() → LoginUsecase
        ↓
AuthRepositoryImpl → AuthRemoteDatasource
        ↓
POST /auth/login  →  { accessToken, refreshToken, user }
        ↓
Tokens saved to Hive (token_box)
        ↓
UserEntity returned → AuthProvider updates state → UI navigates to /home
```

### Token Refresh (automatic)

```
Any request returns 401
        ↓
AuthInterceptor catches it
        ↓
Pending requests queued
        ↓
POST /auth/refresh with stored refreshToken
        ↓
New tokens saved → queued requests retried
        ↓
If refresh fails → tokens cleared → user redirected to login
```

### Logout

```
LogoutUsecase called
        ↓
Tokens cleared from Hive
        ↓
Home cache cleared
        ↓
AuthProvider state reset → UI navigates to /
```

---

## State Management

**Provider + ChangeNotifier** pattern is used throughout.

Each feature has a dedicated provider:

```dart
// Status enum pattern used across features
enum AuthStatus { initial, loading, success, failure }

class AuthProvider extends ChangeNotifier {
  AuthStatus status = AuthStatus.initial;
  UserEntity? user;
  String? errorMessage;
  // ...
}
```

Providers are registered as **factories** in the GetIt container so each widget tree gets a fresh instance when needed. Data sources and repositories are **lazy singletons**.

---

## Navigation & Routing

GoRouter is configured in `lib/core/router/app_router.dart`:

| Route | Page | Notes |
|---|---|---|
| `/` | `LoginPage` | Initial route |
| `/home` | `HomePage` | Post-login destination |

Debug diagnostics are enabled for development builds. The router instance is created once in `bootstrap.dart` and provided to `MaterialApp.router`.

---

## Networking

`DioClient` (`lib/core/network/dio_client.dart`) configures a shared Dio instance:

- **Connect timeout:** 30 seconds
- **Receive timeout:** 30 seconds
- **Default headers:** `Content-Type: application/json`
- **Base URL:** injected from environment config

`AuthInterceptor` attaches the stored access token to every outgoing request and handles 401 refresh automatically (see [Authentication Flow](#authentication-flow)).

### API Endpoints

| Method | Path | Purpose |
|---|---|---|
| `POST` | `/auth/login` | Authenticate with phone/email |
| `POST` | `/auth/refresh` | Exchange refresh token for new access token |

---

## Local Storage

Hive Flutter is initialized in `bootstrap.dart` with two named boxes:

| Box Name | Contents |
|---|---|
| `token_box` | `accessToken`, `refreshToken` (strings) |
| `cache_box` | Home data JSON strings for offline use |

`HiveStorageService` (`lib/core/storage/`) wraps box access with a typed interface used by both the auth and home data layers.

---

## UI & Theming

### Theme

- Material 3 design system
- Light and dark theme variants
- Custom color palette:
  - Primary / text: `#0A0A0A`
  - Brand blue: `#2563EB`
- Consistent `TextStyle` definitions and `InputDecoration` themes across the app

### Responsive Design

`flutter_screenutil` is initialized with design reference size **402 × 874** (iPhone 14 Pro).

The home screen additionally uses a **600dp width breakpoint** to switch between mobile and tablet layouts:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth >= 600) return const TabletLayout();
    return const MobileLayout();
  },
)
```

### Key UI Components

**LoginPage**
- Full-screen illustration (SVG) in the upper half
- Bottom sheet panel with rounded top corners
- Country code selector — opens `CountryPickerSheet`
- Phone number `TextField` with country-specific digit validation
- "Send OTP" primary action button
- "Continue with Email" secondary action

**CountryPickerSheet**
- Modal bottom sheet listing 50+ countries
- Real-time search by country name, dial code, or ISO code
- Flag emoji + country name + dial code display
- Checkmark indicator on selected country
- Empty state message when search yields no results

**HomePage**
- `MobileLayout`: vertical scrollable card list
- `TabletLayout`: two-column row (content left, side panel right)
- Colored feature info cards
- Inline loading spinner and error message states

---

## Dependency Injection

GetIt is the service locator. All registrations live in `lib/core/di/injection_container.dart` and are called once during `bootstrap.dart` initialization.

Registration strategy:

| Type | Strategy | Examples |
|---|---|---|
| Network client | Lazy singleton | `DioClient` |
| Storage service | Lazy singleton | `HiveStorageService` |
| Data sources | Lazy singleton | `AuthRemoteDatasource`, `HomeLocalDatasource` |
| Repositories | Lazy singleton | `AuthRepositoryImpl`, `HomeRepositoryImpl` |
| Use cases | Lazy singleton | `LoginUsecase`, `LogoutUsecase`, `GetHomeDataUsecase` |
| Providers | Factory | `AuthProvider`, `HomeProvider` |

---

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run on a connected device (dev environment)
flutter run

# Build for release
flutter build apk --release       # Android
flutter build ipa --release       # iOS
```

To switch environments, update the import in `main.dart` to point at the desired config class (dev / uat / prod).

---

## Known TODOs

The following items are marked as incomplete in the codebase:

- **OTP verification flow** — `LoginPage` sends OTP but the navigation to an OTP entry screen is not yet wired up
- **Email login flow** — "Continue with Email" button exists but the route/screen is not implemented
- **Home route** — `AppRouter` currently maps `/home` to `LoginPage` as a placeholder; needs to point to `HomePage`
- **HomeRemoteDatasource** — stubbed with dummy data; API integration is ready to complete once backend endpoint is defined
- **Production base URL** — verify `prod_config.dart` before a production build
# xterra
