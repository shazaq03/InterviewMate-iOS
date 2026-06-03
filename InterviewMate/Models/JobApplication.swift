import Foundation

struct JobApplication: Identifiable, Codable, Equatable {
    var id: UUID
    var company: String
    var role: String
    var status: JobStatus
    var dateApplied: Date
    var interviewDate: Date?
    var notes: String
    var followUp: String

    init(
        id: UUID = UUID(),
        company: String,
        role: String,
        status: JobStatus,
        dateApplied: Date,
        interviewDate: Date? = nil,
        notes: String = "",
        followUp: String = ""
    ) {
        self.id = id
        self.company = company
        self.role = role
        self.status = status
        self.dateApplied = dateApplied
        self.interviewDate = interviewDate
        self.notes = notes
        self.followUp = followUp
    }

    static let samples: [JobApplication] = [
        JobApplication(
            company: "Apple",
            role: "iOS Developer Intern",
            status: .interviewing,
            dateApplied: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(),
            interviewDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
            notes: "Prepare SwiftUI, MVVM, state management, and app lifecycle questions.",
            followUp: "Send thank-you email after technical round."
        ),
        JobApplication(
            company: "Spotify",
            role: "Mobile Engineer",
            status: .applied,
            dateApplied: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            interviewDate: nil,
            notes: "Applied through careers page. Resume focused on mobile and security projects.",
            followUp: "Follow up in one week."
        ),
        JobApplication(
            company: "Netflix",
            role: "Junior iOS Engineer",
            status: .offer,
            dateApplied: Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date(),
            interviewDate: Calendar.current.date(byAdding: .day, value: -1, to: Date()),
            notes: "Discussed SwiftUI, async/await, API design, and debugging.",
            followUp: "Review offer details."
        ),
        JobApplication(
            company: "Meta",
            role: "iOS Software Engineer",
            status: .rejected,
            dateApplied: Calendar.current.date(byAdding: .day, value: -20, to: Date()) ?? Date(),
            interviewDate: Calendar.current.date(byAdding: .day, value: -10, to: Date()),
            notes: "Good learning experience. Need more practice with data structures.",
            followUp: "Reapply after improving interview prep."
        )
    ]
}
