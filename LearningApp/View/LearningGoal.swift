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
                // Custom back button in the navigation bar
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
                // Trailing orange check button
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
                        //.buttonBorderShape(Capsule())
                       // .background(Color.orange)
                        .glassEffect(.clear)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .overlay {
                if viewModel.showAlert {
                    UpdateAlert(
                        isPresented: $viewModel.showAlert,
                        title: "Update Learning goal",
                        message: "If you update now, your streak will start over.",
                        dismissText: "Dismiss",
                        updateText: "Update",
                        onDismiss: {
                            viewModel.dismissAlert()
                        },
                        onUpdate: {
                            viewModel.updateGoal()
                        }
                    )
                }
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


struct UpdateAlert: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let dismissText: String
    let updateText: String
    let onDismiss: () -> Void
    let onUpdate: () -> Void
    
    var body: some View {
            
                ZStack {
                    // Background overlay
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            // Dismiss when tapping outside
                        }
                    
                    // Alert box
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(title)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text(message)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Buttons
                        HStack(spacing: 12) {
                            Button(action: {
                                onDismiss()
                                isPresented = false
                            }) {
                                Text(dismissText)
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(25)
                            }
                            
                            Button(action: {
                                onUpdate()
                                isPresented = false
                            }) {
                                Text(updateText)
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.orangeButton)
                                    .cornerRadius(25)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    }
                    .frame(width: 320)
                    .background(Color(white: 0.15))
                    .cornerRadius(30)
                }
            }
        }
    

#Preview {
    LearningGoal()
}
