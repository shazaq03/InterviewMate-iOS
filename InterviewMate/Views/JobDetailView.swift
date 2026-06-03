import SwiftUI

struct JobDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: JobStore
    let job: JobApplication
    @State private var showingEditSheet = false
    @State private var showingDeleteConfirmation = false
    var currentJob: JobApplication { store.jobs.first(where: { $0.id == job.id }) ?? job }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(currentJob.company).font(.largeTitle).fontWeight(.bold)
                    Text(currentJob.role).font(.title3).foregroundStyle(.secondary)
                    StatusBadge(status: currentJob.status)
                }
                Divider()
                detailRow(title: "Date Applied", value: currentJob.dateApplied.formatted(date: .long, time: .omitted), icon: "calendar")
                if let interviewDate = currentJob.interviewDate { detailRow(title: "Interview Date", value: interviewDate.formatted(date: .long, time: .omitted), icon: "person.2.fill") }
                if !currentJob.followUp.isEmpty { detailSection(title: "Follow Up", text: currentJob.followUp, icon: "bell.badge.fill") }
                if !currentJob.notes.isEmpty { detailSection(title: "Notes", text: currentJob.notes, icon: "note.text") }
                Button(role: .destructive) { showingDeleteConfirmation = true } label: { Label("Delete Application", systemImage: "trash").frame(maxWidth: .infinity) }
                    .buttonStyle(.bordered).controlSize(.large).padding(.top, 8)
            }.padding()
        }
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { Button("Edit") { showingEditSheet = true } }
        .sheet(isPresented: $showingEditSheet) { AddEditJobView(existingJob: currentJob) { updatedJob in store.updateJob(updatedJob) } }
        .confirmationDialog("Delete this job application?", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) { store.deleteJob(currentJob); dismiss() }
            Button("Cancel", role: .cancel) {}
        }
    }

    private func detailRow(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon).foregroundStyle(.blue).frame(width: 24)
            VStack(alignment: .leading, spacing: 4) { Text(title).font(.caption).foregroundStyle(.secondary); Text(value).font(.body) }
            Spacer()
        }
    }

    private func detailSection(title: String, text: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: icon).font(.headline)
            Text(text).font(.body).foregroundStyle(.secondary).padding().frame(maxWidth: .infinity, alignment: .leading).background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
