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
                .padding(.trailing, 115)
                Spacer()
                
                
            }
           
            VStack(spacing: 2){
                VStack(spacing: 2){
                    Text("I want to learn")
                        .font(.system(size: 22))
                    
                    TextField("Swift", text: .constant(""))
                        .padding()
                        .textFieldStyle(.plain)
                        .font(.system(size: 22))
                    
                }
                .padding(.trailing,252)
                
                Divider()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .horizontal)
                    .background(Color.gray.opacity(1))
                
              
                VStack(alignment: .leading) {
                    Text("I want to learn it in a")
                        .font(.system(size: 22))
                        .padding()
                        .padding(.trailing,180)
                    
                    // period selection
                    HStack(alignment: .top, spacing:12){
                        Button(action: { }) {
                            Text("Week")
                                .font(.system(size:15))
                                .foregroundStyle(Color.white)
                                .frame(width: 97, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 120)
                                        .fill(Color.blackButtons).glassEffect(.clear).opacity(1)
                                )
                        }
                        
                        Button(action:{ }) {
                            Text("Month")
                                .font(.system(size:15))
                                .foregroundStyle(Color.white)
                                .frame(width: 97, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 120)
                                        .fill(Color.orangeButton).glassEffect(.clear).opacity(1)
                                )
                        }
                        
                        Button(action:{ }) {
                            Text("Year")
                                .font(.system(size:15))
                                .foregroundStyle(Color.white)
                                .frame(width: 97, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 120)
                                        .fill(Color.blackButtons).glassEffect(.clear).opacity(1)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal) // valid padding (removed the invalid .padding(.horizontal, .top, 122))
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, -277) // keep your original positioning for this section
            
        }
    }
}

#Preview {
    LearningGoal()
}
