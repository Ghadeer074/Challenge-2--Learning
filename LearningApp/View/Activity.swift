import SwiftUI

// MARK: - Model
struct LearningSession {
    var topic: String
    var daysLearned: Int
    var daysFreezed: Int
    var freezesUsed: Int
    var totalFreezes: Int
}

// MARK: - View
struct ActivityView: View {
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 31) {
                NavBar().padding(.top, 47)
                ProgressCard()
                // log and freeze buttons
                Buttons()
             
               }
            }
        Spacer()
        .navigationBarBackButtonHidden(true) 
        }
    }

struct NavBar: View{
    var body: some View{
        HStack{
            Text("Activity")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
            Spacer().frame(width: 160)
            NavigationLink(destination: CalendarView()) {
                Image(systemName: "calendar")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .frame(width:46,height:46)
                    .glassEffect(.clear)
            }
            Spacer().frame(width: 15)
            NavigationLink(destination: LearningGoal()) {
                Image(systemName: "pencil.and.outline")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .frame(width:46,height:46)
                    .glassEffect(.clear)
            }
           
        }
    }
}

struct Buttons: View{
    var body: some View{
        VStack(spacing: 10) {
            Button(action: {}) {
                Text("Log as Learned")
                    .font(.system(size: 45, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 274, height: 274)
                    .background(Color.orangeButton)
                    .clipShape(Circle())
            }
            .glassEffect()
            Spacer()
            // Log as Freezed Button
            Button(action: {}) {
                Text("Log as Freezed")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 315, height: 50)
                    .background(Color.blueTeal)
                    .cornerRadius(30)
            }
            .glassEffect()
            
            // Freezes counter
            Text("0 out of 6 Freezes used")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .padding(.top, 10)
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    ActivityView()
}
