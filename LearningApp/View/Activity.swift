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




    #Preview {
        
        Activity()
        
    }




