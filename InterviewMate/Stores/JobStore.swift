import Foundation
import Combine

final class JobStore: ObservableObject {
    @Published var jobs: [JobApplication] = [] { didSet { saveJobs() } }
    private let storageKey = "interviewmate.jobs"
    private let hasSeededKey = "interviewmate.hasSeededSamples"

    init() {
        loadJobs()
        seedSamplesIfNeeded()
    }

    func addJob(_ job: JobApplication) { jobs.insert(job, at: 0) }
    func updateJob(_ updatedJob: JobApplication) { if let index = jobs.firstIndex(where: { $0.id == updatedJob.id }) { jobs[index] = updatedJob } }
    func deleteJob(_ job: JobApplication) { jobs.removeAll { $0.id == job.id } }
    func count(for status: JobStatus) -> Int { jobs.filter { $0.status == status }.count }

    func filteredJobs(searchText: String, status: JobStatus?) -> [JobApplication] {
        jobs.filter { job in
            let cleanSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesSearch = cleanSearch.isEmpty || job.company.localizedCaseInsensitiveContains(cleanSearch) || job.role.localizedCaseInsensitiveContains(cleanSearch)
            let matchesStatus = status == nil || job.status == status
            return matchesSearch && matchesStatus
        }
    }

    private func saveJobs() {
        if let data = try? JSONEncoder().encode(jobs) { UserDefaults.standard.set(data, forKey: storageKey) }
    }

    private func loadJobs() {
        guard let data = UserDefaults.standard.data(forKey: storageKey), let decoded = try? JSONDecoder().decode([JobApplication].self, from: data) else { return }
        jobs = decoded
    }

    private func seedSamplesIfNeeded() {
        if !UserDefaults.standard.bool(forKey: hasSeededKey) && jobs.isEmpty {
            jobs = JobApplication.samples
            UserDefaults.standard.set(true, forKey: hasSeededKey)
        }
    }
}
