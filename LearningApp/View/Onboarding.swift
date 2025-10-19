//
//  ContentView.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 24/04/1447 AH.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        NavigationStack {
            
            //App logo
            ZStack {
                Circle()
                    .frame(width: 130, height: 130)
                    .foregroundStyle(.black)
                    .shadow(color: .orange, radius: 23)
                    .tint(.orange)
                
                Image(systemName: "flame.fill")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color.orange)
            }
            .padding(.top, 39) // Move the circle down a bit
            .frame(maxWidth: .infinity,alignment: .center)
            .padding(.bottom,66)
            
            
            // welcome text
            VStack(alignment: .leading,spacing: 6){
                Text("Hello Learner")
                    .font(.system(size: 40, weight: .bold))
                
                Text("This app will help you learn everyday!")
                    .font(.system(size: 20))
                    .colorMultiply(Color.gray)
                    .padding(.trailing,53)
                
            }
            
            Spacer().frame(height:350)
            
            //learning path
            VStack(spacing: 2){
                VStack(spacing: 2){
                    Text("I want to learn")
                        .font(.system(size: 25))
                    
                    TextField("Swift", text: .constant(""))
                        .padding()
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                .padding(.trailing,224)
                
                
                Divider()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .horizontal)
                    .background(Color.gray.opacity(1))
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top,-298)
            
            // Second section that was previously outside NavigationStack
            VStack {
                Text("I want to learn it in a")
                    .font(.system(size: 25))
                    .padding()
                    .padding(.top,-230)
                    .padding(.trailing,159.5)
                
                
                // period selection
                HStack {
                    Button(action: { }) {
                        Text("Week")
                            .font(.system(size:22))
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: 110, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 120)
                                    .fill(Color.orange)
                            )
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 120)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    
                    Button(action:{ }) {
                        Text("Month")
                            .font(.system(size:22))
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: 110, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 120)
                                    .fill(Color.orange)
                            )
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 120)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                    
                    
                    Button(action:{ }) {
                        Text("Year")
                            .font(.system(size:22))
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: 110, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 120)
                                    .fill(Color.orange)
                            )
                    }
                
                    
                
                }
            }
        }
    }
}
#Preview {
    Onboarding()
}
