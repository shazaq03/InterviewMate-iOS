import SwiftUI

struct JobRowView: View {
    let job: JobApplication
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(job.company).font(.headline)
                    Text(job.role).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                StatusBadge(status: job.status)
            }
            HStack(spacing: 12) {
                Label(job.dateApplied.formatted(date: .abbreviated, time: .omitted), systemImage: "calendar").font(.caption).foregroundStyle(.secondary)
                if let interviewDate = job.interviewDate {
                    Label(interviewDate.formatted(date: .abbreviated, time: .omitted), systemImage: "person.crop.circle.badge.clock").font(.caption).foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
    }
}
