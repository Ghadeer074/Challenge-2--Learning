# Learning Journey – Daily Learning Streak Tracker for iOS

**Learning Journey** is a SwiftUI app that helps learners build a daily learning habit. You choose **what** you want to learn and **for how long** (a week, a month or a year), then log each day as *learned*. If you need a break, you can use a limited number of **streak freezes**. A calendar and progress card show how far you've come.

I built it individually for **Challenge 2 at the Apple Developer Academy**.

<!-- Add 2–3 screenshots here, e.g.:
<p align="center">
  <img src="docs/onboarding.png" width="230"> <img src="docs/activity.png" width="230"> <img src="docs/calendar.png" width="230">
</p>
-->

## Features

- **Onboarding:** set a learning topic (e.g. "Swift") and a goal duration
- **Daily logging:** mark today as *Learned* or *Freezed*, with logging limited to once per day
- **Streak freezes:** each goal includes a set number of freezes (week: 2 · month: 8 · year: 96)
- **Progress card and calendar:** see learned and freezed days at a glance
- **Edit your goal:** change the topic or duration at any time
- **Saved locally:** progress stays on the device between launches

## Tech Stack

| Area | Technology |
|---|---|
| Language & UI | Swift, SwiftUI (NavigationStack, Liquid Glass effects) |
| Architecture | MVVM with `ObservableObject` view models (Combine) |
| Persistence | `@AppStorage` / UserDefaults, with day logs encoded as JSON (`Codable`) |

## Project Structure

```
LearningApp/
├── Model/
│   └── Status.swift            # Goal, Duration & DayStatus types
├── ViewModel/
│   ├── OnBoardingVM.swift
│   ├── ActivityVM.swift        # Streak, freeze & daily-log logic + persistence
│   ├── GoalVM.swift            # Edit-goal logic
│   └── CalendarViewModel.swift
└── View/
    ├── Onboarding.swift
    ├── Activity.swift
    ├── ProgressCard.swift
    ├── CalendarView.swift
    └── LearningGoal.swift
```

## Getting Started

**Requirements:** Xcode 26+ and iOS 26+.

```bash
git clone https://github.com/Ghadeer074/Challenge-2--Learning.git
open Challenge-2--Learning/LearningApp.xcodeproj
```

Select a simulator or device, then build and run.

## Author

**Ghadeer Fallatah**: [LinkedIn](https://www.linkedin.com/in/ghadeer-fallatah-842988286) · [GitHub](https://github.com/Ghadeer074)
