//
//  Activity.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 30/04/1447 AH.

import SwiftUI

struct Activity: View {
    var body: some View {
        VStack(spacing: 20) {
            Toolbar()
            //LearningButton()
            //freezButton()
            ProgressCard()
            
        }
    }
}

struct Toolbar: View {
    var body: some View{
            VStack {
                HStack(alignment: .top) {
                    Text("Activity")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()

                    Image(systemName: "calendar")
                        .font(Font.system(size: 22))
                        .frame(width: 44, height: 44)
                        //.glassEffect()

                    Image(systemName: "pencil.and.outline")
                        .font(Font.system(size: 22))
                        .frame(width:44 ,height: 44)
                       // .glassEffect()

                }
                .padding(.horizontal)
                .padding(.top)

                Spacer()
            }
        }
    }

struct ProgressCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                           .fill(Color(white: 0.08))
                           .frame(width: 395, height:134)
                           //.shadow(radius: 1, y: 1)
            HStack {
                CalView()
                Spacer().frame(width: 78)
                //LearningPills()
            }
        }
        //.glassEffect(.clear, in: .rect(cornerRadius: 12))
        .offset(y: -140)
        Spacer().frame(width: 60,height: 395)
    }
}

struct CalView: View {
    var body: some View {
        VStack{
            HStack{
                Text("October 2025")
                    .font(Font.system(size: 20, weight: .semibold))
                Image(systemName: "chevron.down").foregroundStyle(Color.orange).bold()
                
                Spacer().frame(width: 80, height:51)
                
                HStack(spacing : 3){
                    Image(systemName: "chevron.left").foregroundStyle(Color.orange).bold().padding(.trailing, 20)
                    Image(systemName: "chevron.right").foregroundStyle(Color.orange).bold().padding(.trailing, 18)
                }
               .padding(.trailing,-25)
            }
           // Spacer().frame( width:21,height:12)
             
            HStack(spacing: 22){
                ForEach(["SUN", "MON","TUE","WED","THU","FRI","SAT"], id: \.self){ day in
                    Text(day)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                        
                }
            }

            HStack(spacing: 11){
                ForEach(20...26, id: \.self) { date in
                    Circle()
                        .fill(
                            date == 20 ? Color.blueTeal.opacity(0.4) :
                            (21...24).contains(date) ? Color.orange.opacity(0.4) :
                            Color.clear
                        )
                        .foregroundColor(
                            date == 20 ? .teal :
                            (21...24).contains(date) ? .orange :
                            date == 26 ? .white :
                            .primary
                        )
                        
                }
            }
        }
            
    }
   
}

//struct LearningPills: View {
//    var body: some View {
//        VStack{
//            Text("Learning Swift").font(.system(size: 17, weight: .semibold)) .frame(maxWidth: .infinity, alignment: .leading)
//                       
//                       HStack(spacing: 10){
//                           ZStack{
//                               Rectangle().frame(width: 160, height: 70)
//                                   .foregroundColor(Color.orange)
//                                   .cornerRadius(34)
//                                   .opacity(0.4)
//                                 
//                               
//                               HStack{
//                                   Image(systemName: "flame.fill")
//                                       .foregroundColor(Color.orange)
//                                       .font(.system(size: 20, weight: .bold))
//                                   Spacer().frame(width:90)
//                                   
//                               }
//                               VStack{
//                                   Text("3")
//                                       .font(.system(size: 22, weight: .bold))
//                                   
//                                             
//                                   Text("Days Learend")
//                                   font(.system(size: 12))
//                                   
//                               }
//                           }
//                           
//                           ZStack{
//                               Rectangle().frame(width: 160, height: 70)
//                                   .foregroundColor(Color.teal)
//                                   .cornerRadius(34)
//                                   .opacity(0.3)
//                }
//                          
//            }
//        }
//    }
//}

//struct LearningButton: View {
//    var body: some View {
//        Button("Log as Learned"){
//        }
//        .bold()
//        .font(.system(size:30))
//        .padding(100)
//        .foregroundStyle(.white)
//        .background(Circle()
//            .fill(Color.orangeButton.opacity(1))
//            //.glassEffect(.clear.interactive())
//           )
//    }
//}

//struct freezButton: View {
//
//    var body: some View {
//        Button("Log as Freezed"){
//        }
//        .bold()
//        .font(.system(size:16))
//        //.padding(100)
//        .foregroundStyle(.white)
//        .frame(width: 270, height: 48)
//        //.glassEffect(.regular.tint(Color.blueTeal).interactive())
//
//    }
//}



#Preview{
    Activity()
}
