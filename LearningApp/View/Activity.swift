//
//  Activity.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 28/04/1447 AH.
//
import SwiftUI

struct Activity: View {
    var body: some View {
        
        NavigationStack{
            
            VStack{
                
                Toolbar()
                
                ProgressCard()
                Spacer().frame(height: 24)
                
                LearningButton()
                Spacer().frame(height: 32)
                
                freezButton()
                
               }
            }
        }
    }


struct Toolbar: View {
    var body: some View{
        NavigationStack{
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
}


struct ProgressCard: View {
    var body: some View {
        ZStack{
            GlassEffectContainer{
                VStack(){
                    HStack{
                        Text("October 2025")
                            .font(Font.system(size: 18, weight: .semibold))
                        Image(systemName: "chevron.right").foregroundStyle(Color.orange).bold()
                        
                        Spacer()
                        Image(systemName: "chevron.left").foregroundStyle(Color.orange).bold().padding(.trailing, 20)
                        
                        Image(systemName: "chevron.right").foregroundStyle(Color.orange).bold().padding(.trailing, 18)
                       
                    }
                    Spacer().frame(height:12)

                    datesCard()
                }
            }
        }
    }
}

struct LearningButton: View {
    var body: some View {
        Button("Log as Learned"){
        }
        .bold()
        .font(.system(size:30))
        .padding(100)
        .foregroundStyle(.white)
        .background(Circle()
            .fill(Color.orangeButton.opacity(1))
            .glassEffect(.clear.interactive())
           )
    }
}

struct freezButton: View {
    
    var body: some View {
        Button("Log as Freezed"){
        }
        .bold()
        .font(.system(size:16))
        //.padding(100)
        .foregroundStyle(.white)
        .frame(width: 270, height: 48)
        .glassEffect(.regular.tint(Color.blueTeal).interactive())
        
    }
}

struct datesCard: View {
    var body: some View {
        HStack{
            ForEach(["SUN", "MON","TUE","WED","THU","FRI","SAT"], id: \.self){day in
                Text(day)
                    .font(Font.system(size: 14, weight: .semibold)).foregroundStyle(Color.gray).frame(maxWidth: .infinity)
            }
        }
        HStack{
            ForEach(20...26, id: \.self) { date in
                Circle()
                    .fill(
                        date == 20 ? Color.blueTeal.opacity(0.4):
                        date == 25 ? Color.orange : (21...25).contains(date) ? Color.orange.opacity(0.4): Color.clear
                           
                    )
                   
                    .frame(width: 44, height: 44)
                    //.glassEffect()
                    .overlay(
                       
                        Text("\(date)")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(
                                        date == 20 ? .teal :
                                        (21...24).contains(date) ? .orange :
                                        .primary
                                    )
                            
                    )
                    .frame(maxWidth: .infinity)
                    
            }
        }
        Divider().background(Color.gray.opacity(0.6))
        
        VStack(spacing: 10){
            Text("Learning Swift").font(.system(size: 17, weight: .semibold)) .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10){
                ZStack{
                    Rectangle().frame(width: 160, height: 70)
                        .foregroundColor(Color.orange)
                        .cornerRadius(34)
                        .opacity(0.4)
                        //.glassEffect()
                    
                    HStack{
                        Image(systemName: "flame.fill")
                            .foregroundColor(Color.orange)
                            .font(.system(size: 20, weight: .bold))
                        Spacer().frame(width:90)
                        
                    }
                    VStack{
                        Text("3")
                            .font(.system(size: 22, weight: .bold))
                        
                                  
                        Text("Days Learend")
                        font(.system(size: 12))
                        
                    }
                }
                
                ZStack{
                    Rectangle().frame(width: 160, height: 70)
                        .foregroundColor(Color.teal)
                        .cornerRadius(34)
                        .opacity(0.3)
                }
               
            }
        }
    }
    
   
    }

    #Preview {
        Activity()
        
    }
