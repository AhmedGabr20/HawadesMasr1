# HawadesMasr (حوادث مصر) - Flutter

Production-oriented Flutter scaffold for incident reporting and investigation workflows.

## Architecture
- **Clean Architecture + MVVM**
- Layers: `presentation`, `domain`, `data`, `core`, `di`
- State management: **Riverpod**
- Navigation: **go_router** with deep-link support

## Implemented Modules
- Authentication (email/password, token persistence, 401 handling)
- Incident creation (form + GPS + reverse geocoding, local-first save)
- Incident list/details (timeline, map marker)
- Offline-first local storage using Hive (`synced` tracking)
- Background sync using WorkManager with exponential backoff
- Signed URL media upload flow with progress callback
- Investigator location push flow scaffolding (30-second expected interval)
- Firebase Messaging service scaffolding for push/deep-links
- RTL Arabic UI + dark mode

## Backend Endpoints Covered
- `POST /v1/auth/login`
- `POST /v1/incidents`
- `GET /v1/incidents`
- `GET /v1/incidents/{id}`
- `POST /v1/incidents/{id}/status`
- `POST /v1/incidents/{id}/assign`
- `POST /v1/uploads/signed-url`
- `POST /v1/investigators/location`

## Setup
1. Install Flutter stable (`flutter --version`).
2. Configure Firebase for Android and add `google-services.json`.
3. Replace Google Maps API key in `android/app/src/main/AndroidManifest.xml`.
4. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Android Permissions
Declared:
- Camera + audio recording
- Foreground/background location
- Internet
- Foreground service
- Notifications

## Notes
- Replace placeholder refresh-token logic with backend `/refresh` endpoint.
- Add CameraX-equivalent capture workflows via `camera` package integration in production screens.
- For release, wire secure keys through runtime/env injection.
