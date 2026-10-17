# Personal Finance · Flutter Client

**A mobile interface for transactions, budgets, exchange rates, reports and savings goals.**

Flutter · Dart · HTTP · fl_chart · SharedPreferences

This repository contains the Flutter client. It expects a separate API; it is not a standalone finance backend.

## Source tour

| Area | Source |
| --- | --- |
| Transaction requests and balance calculation | [API service](lib/services/api_service.dart) |
| Savings-goal requests | [Goal service](lib/services/hedef_service.dart) |
| Budget and reports | [Screens](lib/screens) |
| Transaction entry and summary cards | [Widgets](lib/widgets) |

## Run locally

Use a Flutter SDK with Dart compatible with `^3.7.0`.

```bash
git clone https://github.com/bora399/finance_app-1.git
cd finance_app-1
flutter pub get
flutter run
```

Before exercising network features, supply the companion API and update the service base URLs to an address reachable from your device/emulator. The current transaction service contains a hard-coded LAN address. This repository does not include that backend or its setup instructions.

The transaction client calls `/verileri-getir`, `/kurlar`, and `/islemler` below its `/api` base URL. Check the goal service for its additional contract. Network-dependent screens require matching responses.

## Current scope

Screens and client requests demonstrate mobile UI composition and API integration. Production authentication, financial accuracy, and offline behavior are not established by this repository alone. Add a mock dataset, environment-based API configuration, error-state tests, and real screenshots to make the project easier to evaluate.
