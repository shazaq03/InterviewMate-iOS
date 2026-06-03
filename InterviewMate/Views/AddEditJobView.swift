import SwiftUI

struct AddEditJobView: View {
    @Environment(\.dismiss) private var dismiss
    let existingJob: JobApplication?
    let onSave: (JobApplication) -> Void
    @State private var company: String
    @State private var role: String
    @State private var status: JobStatus
    @State private var dateApplied: Date
    @State private var hasInterviewDate: Bool
    @State private var interviewDate: Date
    @State private var notes: String
    @State private var followUp: String

    init(existingJob: JobApplication? = nil, onSave: @escaping (JobApplication) -> Void) {
        self.existingJob = existingJob
        self.onSave = onSave
        _company = State(initialValue: existingJob?.company ?? "")
        _role = State(initialValue: existingJob?.role ?? "")
        _status = State(initialValue: existingJob?.status ?? .applied)
        _dateApplied = State(initialValue: existingJob?.dateApplied ?? Date())
        _hasInterviewDate = State(initialValue: existingJob?.interviewDate != nil)
        _interviewDate = State(initialValue: existingJob?.interviewDate ?? Date())
        _notes = State(initialValue: existingJob?.notes ?? "")
        _followUp = State(initialValue: existingJob?.followUp ?? "")
    }

    private var canSave: Bool { !company.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !role.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        NavigationStack {
            Form {
                Section("Role Details") {
                    TextField("Company", text: $company)
                    TextField("Role", text: $role)
                    Picker("Status", selection: $status) { ForEach(JobStatus.allCases) { status in Label(status.title, systemImage: status.icon).tag(status) } }
                }
                Section("Dates") {
                    DatePicker("Date Applied", selection: $dateApplied, displayedComponents: .date)
                    Toggle("Interview Scheduled", isOn: $hasInterviewDate)
                    if hasInterviewDate { DatePicker("Interview Date", selection: $interviewDate, displayedComponents: .date) }
                }
                Section("Notes") { TextEditor(text: $notes).frame(minHeight: 100) }
                Section("Follow Up") { TextField("Example: Send thank-you email", text: $followUp, axis: .vertical).lineLimit(2...4) }
            }
            .navigationTitle(existingJob == nil ? "Add Job" : "Edit Job")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .topBarTrailing) { Button("Save") { saveJob() }.fontWeight(.semibold).disabled(!canSave) }
            }
        }
    }

    private func saveJob() {
        let job = JobApplication(id: existingJob?.id ?? UUID(), company: company.trimmingCharacters(in: .whitespacesAndNewlines), role: role.trimmingCharacters(in: .whitespacesAndNewlines), status: status, dateApplied: dateApplied, interviewDate: hasInterviewDate ? interviewDate : nil, notes: notes.trimmingCharacters(in: .whitespacesAndNewlines), followUp: followUp.trimmingCharacters(in: .whitespacesAndNewlines))
        onSave(job)
        dismiss()
    }
}
