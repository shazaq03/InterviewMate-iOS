import SwiftUI

enum JobStatus: String, Codable, CaseIterable, Identifiable {
    case applied
    case interviewing
    case offer
    case rejected

    var id: String { rawValue }

    var title: String {
        switch self {
        case .applied:
            return "Applied"
        case .interviewing:
            return "Interviewing"
        case .offer:
            return "Offer"
        case .rejected:
            return "Rejected"
        }
    }

    var icon: String {
        switch self {
        case .applied:
            return "paperplane.fill"
        case .interviewing:
            return "person.2.fill"
        case .offer:
            return "star.fill"
        case .rejected:
            return "xmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .applied:
            return .blue
        case .interviewing:
            return .orange
        case .offer:
            return .green
        case .rejected:
            return .red
        }
    }
}
