# Travel Radar ✈️

> An iOS application that helps **Russian travelers** quickly find entry requirements, visa information, and travel tips for different countries.

---

## Features

- **Interactive Map** — tap a country on the map to instantly view entry requirements
- **Country Info** — visa rules, border crossing details, required documents, and travel tips
- **10 Countries Supported** — UK, USA, France, Germany, Spain, Portugal, Ireland, Brazil, Turkey, UAE
- **Sign In with Email, Google, or Apple** — multiple authentication options via Firebase
- **Admin Panel** — built-in support chat between users and administrators
- **Settings** — update email, password, and personal info; account deletion

---

## Screenshots

| Map | Country Info | Settings |
|-----|-------------|----------|
| Interactive world map with country markers | Detailed entry requirements per country | Account management |

---

## Tech Stack

![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![SwiftUI](https://img.shields.io/badge/SwiftUI-blue?logo=swift)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-yellow?logo=firebase)
![MapKit](https://img.shields.io/badge/MapKit-Maps-green?logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-15-blue?logo=xcode)

| Technology | Purpose |
|-----------|---------|
| SwiftUI | UI framework |
| MapKit | Interactive world map |
| Firebase Auth | Email, Google, and Apple Sign-In |
| Firebase Firestore | Admin chat and user data storage |
| URLSession + Codable | Fetching country data from JSON API |

---

## Architecture

The project follows the **MVVM** pattern with a clear separation of concerns:

```
Travel Radar/
├── Views/
│   ├── RegistrationLogIn/   # Auth screens (login, register, choice)
│   ├── Countries/           # Per-country info screens (10 countries)
│   ├── CountriesList/       # Countries list view
│   ├── Main/                # Map and main app screen
│   ├── Settings/            # Account settings screens
│   ├── TabBar/              # Custom tab bar
│   └── Admin/               # Admin panel and support chat
├── ViewModels/              # MVVM ViewModels
├── NetworkServices/         # Networking, models, error handling
├── RegLogInServices/        # Firebase Auth, Google & Apple Sign-In
├── User/                    # User model and Firestore manager
└── Texts/                   # Reusable UI text and button components
```

---

## Getting Started

### Prerequisites

- Xcode 15+
- iOS 16+ device or simulator
- Firebase project

### Setup

1. Clone the repository
   ```bash
   git clone https://github.com/PIFFORS/Travel-Radar.git
   cd Travel-Radar
   ```

2. Add your own `GoogleService-Info.plist` from your Firebase project to:
   ```
   Travel Radar/RegLogInServices/GoogleService-Info.plist
   ```

3. Open `Travel Radar.xcodeproj` in Xcode

4. Build and run on a simulator or device

### Data Parsing Script

The `scripts/parsing_manager.py` script was used to automatically collect country entry requirement data using Google Custom Search and OpenAI GPT-4.

To run it, set the required environment variables:
```bash
export GOOGLE_API_KEY=your_key
export GOOGLE_SEARCH_ENGINE_ID=your_engine_id
export OPENAI_API_KEY=your_key
python scripts/parsing_manager.py
```

---

## Authors

- **Mikhail** ([@PIFFORS](https://github.com/PIFFORS))
- **Artyom** ([@leginar7](https://github.com/leginar7))

---

> Built as a school project in 2023–2024. First experience developing a full iOS application from scratch — including authentication, real-time database, external APIs, and automated data collection.
