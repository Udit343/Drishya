import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let videoId: String

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator {
        var loadedVideoId: String?
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .black
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard !videoId.isEmpty,
              context.coordinator.loadedVideoId != videoId,
              let url = URL(string: "https://www.youtube.com/embed/\(videoId)?playsinline=1")
        else { return }

        context.coordinator.loadedVideoId = videoId

        let bundleId = Bundle.main.bundleIdentifier ?? "com.drishya.app"
        var request = URLRequest(url: url)
        request.setValue("https://\(bundleId)", forHTTPHeaderField: "Referer")

      //  print("Loading:", url, "Referer: https://\(bundleId)")
        webView.load(request)
    }
}
