//
//  Untitled.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 02/05/1447 AH.
//
 import SwiftUI

struct ProgressCard: View {
    var body: some View {
        
        GlassEffectContainer{
            VStack{
                Calendar()
                Spacer().frame(height:11)
                Divider().foregroundColor(.gray).opacity(1)
                Spacer().frame(height:11)
                
                Text("Learning")
                    .font(.system(size: 17).bold())
                    .padding(.trailing,280)
                Spacer().frame(height:19)
                HStack{
                    Learned()
                    Spacer().frame(width: 12)
                    Freezed()
                }
            }
        }
        .padding(13)
        .glassEffect(.clear,in:.rect(cornerRadius: 20))
    
       }
    }

struct Calendar: View {
    var body: some View {
        VStack{
            HStack{
                Text("October 2025").bold().font(.system(size: 17))
                
                Button(action: {}) {
                    Image(systemName: "chevron.down").font(.system(size: 17)).bold().foregroundStyle(Color.orange)
                }
                Spacer()
                
                Button(action:{}){
                    Image(systemName: "chevron.left").foregroundStyle(Color.orange).bold().font(.system(size: 17))
                }
                Spacer().frame(width:20)
                
                Button(action:{}){
                    Image(systemName: "chevron.right").foregroundStyle(Color.orange).bold().font(.system(size: 17))
                }
            }
            Spacer().frame(height:20)

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
                        
                                .frame(width: 35, height: 35)
                                //.glassEffect()
                                .overlay(
                                   
                                    Text("\(date)")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(
                                                    date == 20 ? .teal :
                                                    (21...24).contains(date) ? .orange :
                                                    .primary
                                                )
                                              )
                                .frame(maxWidth: .infinity)
                        }
                      }
                   }
                }
            }

struct Learned: View {
    var body: some View {
        HStack{
            //Spacer().frame(width: 12)
                Image(systemName: "flame.fill").foregroundStyle(Color.orange).font(Font.system(size: 20))
            
            VStack(alignment: .leading){
                Text("0").font(.system(size:24))
                Text("Days Learned").font(.system(size: 14)).bold()
                Spacer().frame(height: 6)
            }
            //.frame(width: 78, height:49)
            Spacer().frame(width: 12)
        }
        .frame(width: 176 ,height:73)
        .glassEffect(.clear.tint(Color.orange.opacity(0.25)))
    }
}

struct Freezed: View {
  var body: some View {
      HStack{
          //Spacer().frame(width: 12)
              Image(systemName: "cube.fill").foregroundStyle(Color.teal).font(Font.system(size: 20))
          
          VStack(alignment: .leading){
              Text("0").font(.system(size:24))
              Text("Days Freezed").font(.system(size: 14)).bold()
              Spacer().frame(height: 6)
          }
          //.frame(width: 78, height:49)
          Spacer().frame(width: 12)
      }
      .frame(width: 176 ,height:73)
      .glassEffect(.clear.tint(Color.teal.opacity(0.23)))
    }
}

#Preview {
    ProgressCard()
}
