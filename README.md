# Drishya 🎬

A movie and TV streaming-style iOS app built with **SwiftUI**. Browse trending and top-rated content, search movies and TV shows, watch trailers inside the app, and save titles to watch later.

## Features

- **Home**: featured hero banner plus four rows: Trending Movies, Trending TV, Top Rated Movies and Top Rated TV
- **Detail screen**: in-app YouTube trailer, title and overview, with a Download button
- **Search**: live search with a movie/TV toggle, debounced so it doesn't spam the API; shows trending titles when the box is empty
- **Upcoming**: list of movies releasing soon
- **Downloads**: saved titles stored on device, swipe to delete, kept after relaunch

## Tech Stack

| Area | Technology |
|------|------------|
| UI | SwiftUI |
| Architecture | MVVM with the `@Observable` macro |
| Concurrency | Swift Concurrency (`async/await`, `async let`, `.task(id:)`) |
| Networking | `URLSession` with a generic `Decodable` fetcher |
| Persistence | SwiftData (`@Model`, `@Query`) |
| Trailers | YouTube Data API v3, played in a `WKWebView` |
| Images | `AsyncImage` |

## How It Works

```
SwiftUI Views  ->  ViewModel (@Observable)  ->  DataFatcher  ->  TMDB / YouTube APIs
      |
      +-------->  SwiftData (saved titles)
```

1. **Views** only display state and send user actions.
2. **ViewModels** hold the state (`notStarted`, `fetching`, `success`, `failed`) and decide what to fetch.
3. **DataFatcher** builds URLs, calls the APIs and decodes the JSON.
4. **SwiftData** stores downloaded titles on the device.

### Key Implementation Details

- **Parallel loading**: Home makes four API calls at the same time with `async let`, so load time is about the slowest single call instead of the sum of all four.
- **Debounced search**: `.task(id: searchText)` cancels the previous task on every keystroke. A 500 ms `Task.sleep` plus a `Task.isCancelled` check means typing "batman" sends one request, not six. This also avoids out-of-order responses.
- **State-driven UI**: an enum drives the loading spinner, content and error screens, so there are no conflicting booleans.
- **Smooth scrolling**: `LazyVStack`, `LazyHStack` and `LazyVGrid` create only visible views, and `AsyncImage` loads posters with placeholders.
- **Trailer player**: `WKWebView` wrapped in `UIViewRepresentable`. A `Coordinator` remembers the loaded video ID so SwiftUI redraws don't reload the video.
- **Generic networking**: one `fetchAndDecode<T: Decodable>` function handles status-code checks and JSON decoding (`convertFromSnakeCase`) for every endpoint.
- **Typed error handling**: custom `LocalizedError` enums (`NetworkError`, `APIConfigError`) are thrown up to the ViewModel, which shows a readable message instead of crashing.
- **Offline saves**: `Title` is a SwiftData `@Model` with a unique ID, so there are no duplicates, and `@Query` keeps the Downloads list in sync automatically.
- **Reusable UI**: `VerticalListView` is shared by the Upcoming and Downloads screens.

## Project Structure

```
Drishya/
├── DrishyaApp.swift          # App entry, SwiftData container
├── ContentView.swift         # Tab bar
├── Views/
│   ├── HomeView.swift
│   ├── SearchView.swift
│   ├── UpcomingView.swift
│   ├── DownloadView.swift
│   ├── TitleDetailView.swift
│   ├── HorizontalListView.swift
│   ├── VerticalListView.swift
│   └── YoutubePlayer.swift
├── ViewModels/
│   ├── ViewModel.swift
│   └── SearchViewModel.swift
├── Networking/
│   ├── DataFatcher.swift
│   └── Errors.swift
├── Models/
│   ├── Title.swift           # SwiftData model + TMDB decoding
│   └── YoutubeSearchResponse.swift
└── Constant.swift
```

## Acknowledgements

This product uses the TMDB API but is not endorsed or certified by TMDB.
