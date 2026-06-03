import SwiftUI

struct StatCard: View {
    let status: JobStatus
    let count: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: status.icon).foregroundStyle(status.color).font(.title3)
            Text("\(count)").font(.title2).fontWeight(.bold)
            Text(status.title).font(.caption).foregroundStyle(.secondary)
        }
        .frame(width: 95, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
