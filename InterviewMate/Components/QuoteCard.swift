import SwiftUI

struct QuoteCard: View {
    @ObservedObject var quoteService: QuoteService
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Daily Interview Boost", systemImage: "sparkles").font(.headline)
                Spacer()
                if quoteService.isLoading { ProgressView() }
            }
            Text("“\(quoteService.quoteText)”").font(.subheadline)
            Text("— \(quoteService.quoteAuthor)").font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .background(LinearGradient(colors: [.blue.opacity(0.18), .purple.opacity(0.12)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
