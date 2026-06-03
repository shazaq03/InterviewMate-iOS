import SwiftUI

struct StatusBadge: View {
    let status: JobStatus
    var body: some View {
        Label(status.title, systemImage: status.icon)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundStyle(status.color)
            .background(status.color.opacity(0.12))
            .clipShape(Capsule())
    }
}
