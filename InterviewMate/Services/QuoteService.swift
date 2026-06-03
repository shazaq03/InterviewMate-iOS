import Foundation
import Combine

@MainActor
final class QuoteService: ObservableObject {
    @Published var quoteText = "Stay ready. Your next interview could be the one."
    @Published var quoteAuthor = "InterviewMate"
    @Published var isLoading = false

    struct QuoteResponse: Codable { let content: String; let author: String }

    func loadQuote() async {
        isLoading = true
        defer { isLoading = false }
        guard let url = URL(string: "https://api.quotable.io/random?tags=inspirational") else { setFallbackQuote(); return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(QuoteResponse.self, from: data)
            quoteText = decoded.content
            quoteAuthor = decoded.author
        } catch { setFallbackQuote() }
    }

    private func setFallbackQuote() {
        let fallbackQuotes = [
            ("Preparation turns opportunity into success.", "InterviewMate"),
            ("Small daily progress creates big career momentum.", "InterviewMate"),
            ("Build, explain, improve — that is how developers grow.", "InterviewMate"),
            ("Confidence comes from practice, not perfection.", "InterviewMate")
        ]
        let quote = fallbackQuotes.randomElement() ?? fallbackQuotes[0]
        quoteText = quote.0
        quoteAuthor = quote.1
    }
}
