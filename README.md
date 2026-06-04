# InterviewMate

InterviewMate is a SwiftUI iOS app for tracking job applications, interview stages, notes, and follow-ups. It was built as a practical iOS development project to demonstrate SwiftUI UI development, state management, local persistence, navigation, reusable components, search/filter functionality, and basic async networking.

## Features

- Add, edit, and delete job applications
- Track company, role, application status, application date, interview date, notes, and follow-up actions
- Search applications by company name or role
- Filter applications by job status
- View status summary cards for applications
- Save application data locally using `Codable` and `UserDefaults`
- Display a daily interview motivation card using `URLSession` and `async/await`
- Reusable SwiftUI components for cards, rows, badges, and dashboard elements

## Tech Stack

- Swift
- SwiftUI
- Xcode
- MVVM-style state management
- `ObservableObject`
- `@StateObject`
- `@State`
- `Codable`
- `UserDefaults`
- `URLSession`
- `async/await`

## Screenshots

### 1. Home Dashboard

The home dashboard shows the main job tracking interface. It includes a daily interview boost card, status summary cards, search functionality, filtering, and a list of saved job applications.

![Home Dashboard](screenshots/Home%20Dashboard.png)

---

### 2. Add Job Form

The add job screen allows the user to create a new job application by entering company name, role, status, application date, interview date, notes, and follow-up information.

![Add Job Empty](screenshots/Add%20job%20page%20empty.png)

---

### 3. Filled Add Job Form

This screen shows the add job form with sample application data filled in before saving. It demonstrates the form input flow and how a user can track interview-related details.

![Add Job Filled](screenshots/Add%20job%20page%20filled.png)

---

### 4. Job Added to Dashboard

After saving a new application, the job appears on the dashboard with its status badge and relevant application details.

![Job Added](screenshots/job%20added%20page.png)

---

### 5. Job Details Page

The detail page shows complete information for a selected job application, including company, role, status, date applied, interview date, notes, and follow-up tasks.

![Job Details](screenshots/job%20details%20page.png)

---

### 6. Filter Menu

The filter menu allows users to filter job applications by status, such as Applied, Interviewing, Offer, or Rejected.

![Filter Open](screenshots/filter%20open.png)

---

### 7. Search

The search feature allows users to quickly find job applications by company name or role title.

![Search Open](screenshots/search%20open.png)

