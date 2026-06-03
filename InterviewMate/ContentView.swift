import SwiftUI

struct ContentView: View {
    @StateObject private var store = JobStore()
    @StateObject private var quoteService = QuoteService()
    @State private var searchText = ""
    @State private var selectedStatus: JobStatus? = nil
    @State private var showingAddSheet = false
    private var filteredJobs: [JobApplication] { store.filteredJobs(searchText: searchText, status: selectedStatus) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    QuoteCard(quoteService: quoteService)
                    statusSummary
                    filterPicker
                    if filteredJobs.isEmpty { emptyState } else {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredJobs) { job in
                                NavigationLink { JobDetailView(store: store, job: job) } label: {
                                    JobRowView(job: job).padding().background(.background).clipShape(RoundedRectangle(cornerRadius: 20)).shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
                                }.buttonStyle(.plain)
                            }
                        }
                    }
                }.padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("InterviewMate")
            .searchable(text: $searchText, prompt: "Search company or role")
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { showingAddSheet = true } label: { Image(systemName: "plus.circle.fill").font(.title2) } } }
            .sheet(isPresented: $showingAddSheet) { AddEditJobView { newJob in store.addJob(newJob) } }
            .task { await quoteService.loadQuote() }
        }
    }

    private var statusSummary: some View { ScrollView(.horizontal, showsIndicators: false) { HStack(spacing: 12) { ForEach(JobStatus.allCases) { status in StatCard(status: status, count: store.count(for: status)) } } } }

    private var filterPicker: some View {
        HStack {
            Text("Filter").font(.headline)
            Spacer()
            Menu {
                Button("All Statuses") { selectedStatus = nil }
                ForEach(JobStatus.allCases) { status in Button { selectedStatus = status } label: { Label(status.title, systemImage: status.icon) } }
            } label: {
                HStack { Text(selectedStatus?.title ?? "All Statuses"); Image(systemName: "chevron.down") }
                    .font(.subheadline).fontWeight(.semibold).padding(.horizontal, 12).padding(.vertical, 8).background(.thinMaterial).clipShape(Capsule())
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "briefcase").font(.system(size: 48)).foregroundStyle(.secondary)
            Text("No applications found").font(.headline)
            Text("Add a job application or adjust your search/filter.").font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
            Button { showingAddSheet = true } label: { Label("Add Job", systemImage: "plus") }.buttonStyle(.borderedProminent).padding(.top, 8)
        }.padding(40).frame(maxWidth: .infinity).background(.background).clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
