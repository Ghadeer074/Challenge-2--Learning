//
//  ContentView.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 24/04/1447 AH.
//
import SwiftUI

struct Onboarding: View {
    
    @StateObject private var viewModel = OnBoardingVM()
    
    var body: some View {
        
        NavigationStack {
            VStack{
                //App logo
                ZStack {
                    Circle()
                        .fill(Color.orangeButton.opacity(0.1))
                        .frame(width: 109, height: 109)
                        .glassEffect(.clear)
                    
                    Image(systemName: "flame.fill")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color.orange)
                }
                .padding(.top, 39)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.bottom,66)
                
                
                // welcome text
                VStack(alignment: .leading,spacing: 6){
                    Text("Hello Learner")
                        .font(.system(size: 34, weight: .bold))
                    
                    Text("This app will help you learn everyday!")
                        .font(.system(size: 17))    
                        .colorMultiply(Color.gray)
                        .padding(.trailing,80)
                    Spacer()
                }
                
                .padding(.top,-12)
                
                //learning path
                VStack(spacing: 2){
                    VStack(spacing: -22){
                        Text("I want to learn")
                            .font(.system(size: 22))
                        
                        TextField("Swift", text: $viewModel.topic)
                            .padding()
                            .textFieldStyle(.plain)
                            .font(.system(size: 22))
                        
                    }
                    .padding(.trailing,229)
                    
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea(edges: .horizontal)
                        .background(Color.gray.opacity(1))
                    
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top,-177)
                
                // Second section that was previously outside NavigationStack
                VStack(alignment: .leading) {
                    Text("I want to learn it in a")
                        .font(.system(size: 19))
                        .padding()
                        .padding(.trailing,180)
                    
                    
                    // period selection
                    HStack(alignment: .top, spacing:12){
                        Button(action: {
                            viewModel.selectDuration(.week)
                        }) {
                            Text("Week")
                                .font(.system(size:15))
                                .foregroundStyle(Color.white)
                                .frame(width: 97, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 120)
                                        .fill(viewModel.selectedDuration == .week ? Color.orangeButton : Color.blackButtons)
                                )
                        }
                  

                        
                        Button(action:{
                            viewModel.selectDuration(.month)
                        }) {
                            Text("Month")
                                .font(.system(size:15))
                                .foregroundStyle(Color.white)
                                .frame(width: 97, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 120)
                                        .fill(viewModel.selectedDuration == .month ? Color.orangeButton : Color.blackButtons)
                                )
                        }
                        
                        
                        
                        Button(action:{
                            viewModel.selectDuration(.year)
                        }) {
                            Text("Year")
                                .font(.system(size:15))
                                .foregroundStyle(Color.white)
                                .frame(width: 97, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 120)
                                        .fill(viewModel.selectedDuration == .year ? Color.orangeButton : Color.blackButtons)
                                )
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                }
                .padding(.top,-347)
            }
            
            Button(action:{
                viewModel.startLearning()
            }) {
                Text("Start Learning ")
                    .font(.system(size:15))
                    .foregroundStyle(Color.white)
                    .frame(width: 182, height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 120)
                            .fill(Color.orangeButton)
                    )
            }
            .navigationDestination(isPresented: $viewModel.navigateToActivity) {
                ActivityView(onboardingVM: viewModel)
            }
        }
    }
}
#Preview {
    Onboarding()
}
