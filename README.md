# Flutter News Application

This is a Flutter-based news application that fetches news articles based on categories and displays them to users. The app supports both light and dark themes, and users can switch between them.

## Overview

This app uses the NewsAPI to fetch the latest articles for different categories. The app also uses the `Provider` package for state management and allows users to toggle between dark and light themes.

## Features

- Fetch and display top headlines based on a selected category.
- Support for light and dark themes.
- Search functionality to filter news articles.
- Infinite scrolling to load more articles as the user scrolls.

## Architecture

The app follows a **MVVM** (Model-View-ViewModel) architecture:

- **Model**: Represents the data structure (`Article`, `NewsProvider`).
- **View**: The UI components (`HomeScreen`, `CategoryScreen`, etc.).
- **ViewModel**: Handles the business logic (state management with `Provider`, theme toggling with `ThemeProvider`).

## Dependencies

This project uses the following dependencies:

- `flutter`: The Flutter SDK.
- `provider`: State management solution for Flutter apps.
- `http`: To make HTTP requests to fetch news data from the NewsAPI.
- `cupertino_icons`: For Cupertino-style icons.
- `flutter_svg`: Optional if you plan to use SVG images.

## Setup Instructions

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/flutter-news-app.git
cd flutter-news-app

