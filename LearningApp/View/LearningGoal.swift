//
//  LearningGoal.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 28/04/1447 AH.
//
import SwiftUI

struct LearningGoal: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var topic: String = ""
    @State private var originalTopic: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 39) {
                SetGoal(topic: $topic)
                GoalDuration()
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if topic != originalTopic && !topic.isEmpty {
                            showAlert = true
                        }
                    }
                   
                    label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                            
                           
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            
            .alert("Update Learning goal", isPresented: $showAlert) {
                Button("Dismiss", role: .cancel) {
                    topic = originalTopic
                }
                
                Button("Update") {
                    originalTopic = topic
                        
                }
                
            }
            message: {
                Text("If you update now, your streak will start over.")
            }
            .onAppear {
                originalTopic = topic
            }
        }
    }
}

struct SetGoal: View {
    @Binding var topic: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("I want to learn")
                    .font(.system(size: 22))
                
                TextField("Swift", text: $topic)
                    .padding(.vertical, 8)
                    .textFieldStyle(.plain)
                    .font(.system(size: 22))
                
                Divider()
                    .background(Color.gray.opacity(1))
                
            }
        }
    }
}

struct GoalDuration: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            Text("I want to learn it in a")
                .font(.system(size: 22))
            // period selection
            HStack(alignment: .top, spacing: 12) {
                Button(action: { }) {
                    Text("Week")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .frame(width: 97, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 120)
                                .fill(Color.blackButtons)
                        )
                }
                Button(action: { }) {
                    Text("Month")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .frame(width: 97, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 120)
                                .fill(Color.orangeButton)
                        )
                }
                Button(action: { }) {
                    Text("Year")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .frame(width: 97, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 120)
                                .fill(Color.blackButtons)
                        )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    LearningGoal()
}
