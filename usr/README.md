# Mali AI

A modern, responsive, and cross-platform AI chat application powered by the Google Gemini API. Built entirely with Flutter, this web app provides an interactive user experience blending conversational AI with creative tools.

## Features

- **Core AI Chat:** Real-time chat powered by the Google Gemini API (`gemini-pro`).
- **Dark Modern UI:** Sleek, fast, and responsive user interface across Desktop and Mobile browsers.
- **Creator Verification:** Special hidden access code (`MaliAicreator2712%`) that activates Creator Mode and triggers customized, respectful AI interactions ("Welcome back, Malakai").
- **Image Mode Toggle:** Switch between classic chat and image generation (with an "Image generation coming soon" visual placeholder state).
- **Admin Commands:** Exclusive commands (`/clear`, `/system`, `/mode`) built securely into the Creator Mode.
- **Trending Sidebar:** Real-time simulated topics updated dynamically.

## Tech Stack

- **Flutter / Dart:** Cross-platform responsive UI framework.
- **Provider:** State management handling user sessions, chat logs, and API states.
- **HTTP / REST:** Direct fetch-style API calls to the official Generative Language API.

## Setup and Run Instructions

1. Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (version 3.7.2 or above).
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app directly on the web:
   ```bash
   flutter run -d web-server --web-port 8080
   ```
   Or launch in Chrome:
   ```bash
   flutter run -d chrome
   ```

## API Configuration
The API Key is bundled into the service securely. No additional `.env` setup is required to start interacting with the bot immediately.

---

## About CouldAI

[CouldAI](https://could.ai) is an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications. This app was generated with CouldAI.
