//
//  LearningGoal.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 28/04/1447 AH.
//
import SwiftUI

struct LearningGoal: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = GoalVM()
    var activityVM: ActivityVM

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 39) {
                SetGoal(topic: $viewModel.newTopic, topicChanged: viewModel.topicChanged)
                GoalDuration(selectedDuration: $viewModel.selectedDuration, selectDuration: viewModel.selectDuration)
                Spacer()
            }
            .padding(.top,34)
            .padding(.horizontal)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Learning Goal")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.primary)
                }
                
                if viewModel.showCheckButton {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.checkButtonTapped()
                        }
                        label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                                
                        }
                       .buttonStyle(.borderedProminent)
                       .tint(.orangeButton)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
           
            .alert("Update Learning goal",
                   isPresented: $viewModel.showAlert,
                   actions: {
                        Button("Dismiss", role: .cancel) {
                            viewModel.dismissAlert()
                        }
                       
                        Button("Update") {
                            viewModel.updateGoal()
                            dismiss()
                        }
                   },
                   message: {
                        Text("If you update now, your streak will start over.")
                   }
            )
            .onAppear {
                viewModel.loadCurrentGoal(from: activityVM)
            }
        }
    }
}

struct SetGoal: View {
    @Binding var topic: String
    let topicChanged: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("I want to learn")
                    .font(.system(size: 22))
                
                TextField("Swift", text: $topic)
                    .padding(.vertical, 8)
                    .textFieldStyle(.plain)
                    .font(.system(size: 22))
                    .onChange(of: topic) { _, _ in
                        topicChanged()
                    }
                
                Divider()
                    .background(Color.gray.opacity(1))
            }
        }
    }
}

struct GoalDuration: View {
    @Binding var selectedDuration: Duration
    let selectDuration: (Duration) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            Text("I want to learn it in a")
                .font(.system(size: 22))
            // period selection
            HStack(alignment: .top, spacing: 12) {
                Button(action: {
                    selectDuration(.week)
                }) {
                    Text("Week")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .frame(width: 97, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 120)
                                .fill(selectedDuration == .week ? Color.orangeButton : Color.blackButtons)
                        )
                }
                Button(action: {
                    selectDuration(.month)
                }) {
                    Text("Month")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .frame(width: 97, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 120)
                                .fill(selectedDuration == .month ? Color.orangeButton : Color.blackButtons)
                        )
                }
                Button(action: {
                    selectDuration(.year)
                }) {
                    Text("Year")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .frame(width: 97, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 120)
                                .fill(selectedDuration == .year ? Color.orangeButton : Color.blackButtons)
                        )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    LearningGoal(activityVM: ActivityVM())
}
