//
//  Activity.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 28/04/1447 AH.
//
import SwiftUI

struct Activity: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Activity")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "calendar")
                    .font(Font.system(size: 22))
                    .frame(width: 44, height: 44)
                    .glassEffect()
                
                Image(systemName: "pencil.and.outline")
                    .font(Font.system(size: 22))
                    .frame(width:44 ,height: 44)
                    .glassEffect()

            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
        
    }
}

struct LearningProgress {
    var topic: String
    var daysLearned: Int
    var dayFreezed: Int
}

struct LearningProgressCard: View {
    let progress: LearningProgress
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(spacing: 16) {
            }
        }
    }
    
    #Preview {
        Activity()
        //ZStack {
           // Color.black.ignoresSafeArea() // Add background so you can see the glassy effects
            
        //VStack {
              
                
             //   LearningProgressCard(progress: LearningProgress(
               //     topic: "Swift",
              //     daysLearned: 4,
                //dayFreezed: 1
               // ))
                //.padding()
                
               // Spacer()
            }
        }
    



