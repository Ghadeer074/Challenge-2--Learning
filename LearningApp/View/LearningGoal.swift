//
//  LearningGoal.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 28/04/1447 AH.
//
import SwiftUI

struct LearningGoal: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                // Header
                HStack(alignment: .top) {
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            // Circular glass background
                            Circle()
                                .fill(.clear)
                                .frame(width: 44, height: 44)
                                .glassEffect(.clear)
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(.white)
                        }
                        // Ensure the whole area is tappable
                        .frame(width: 78, height: 44)
                    }
                    Spacer()
                    
                    Text("Learning goal")
                        .font(.system(size: 23, weight: .bold))
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Content section: TextField -> Divider -> Label -> Period selection
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("I want to learn")
                            .font(.system(size: 22))
                        
                        TextField("Swift", text: .constant(""))
                            .padding(.vertical, 8)
                            .textFieldStyle(.plain)
                            .font(.system(size: 22))
                        
                        Divider()
                            .background(Color.gray.opacity(1))
                    }
                    .padding(.horizontal)
                    
                    Text("I want to learn it in a")
                        .font(.system(size: 22))
                        .padding(.horizontal)
                    
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
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    LearningGoal()
}
