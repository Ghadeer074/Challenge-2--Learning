import SwiftUI
import Combine

struct ActivityView: View {
    @StateObject private var viewModel = ActivityVM()
    var onboardingVM: OnBoardingVM
    
    var body: some View {
        VStack(spacing: 31) {
            NavBar(viewModel: viewModel)
                .padding(.top, 47)
            
            ProgressCard(viewModel: viewModel)
            
            if viewModel.isGoalCompleted {
                GoalCompletedView(onReset: {
                    viewModel.resetStreak()
                }, onSameGoal: {
                    viewModel.updateGoal(newTopic: viewModel.topic, newDuration: viewModel.selectedDuration)
                })
            } else {
                Buttons(viewModel: viewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !viewModel.isInitialized {
                viewModel.loadGoal(topic: onboardingVM.topic, duration: onboardingVM.selectedDuration)
            }
            viewModel.checkCurrentDayStatus()
        }
    }
}


struct NavBar: View {
    @ObservedObject var viewModel: ActivityVM
    
    var body: some View {
        HStack {
            Text("Activity")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
            Spacer().frame(width: 160)
            NavigationLink(destination: CalendarView(activityVM: viewModel)) {
                Image(systemName: "calendar")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .frame(width: 46, height: 46)
                    .glassEffect(.clear)
            }
            Spacer().frame(width: 15)
            NavigationLink(destination: LearningGoal(activityVM: viewModel)) {
                Image(systemName: "pencil.and.outline")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .frame(width: 46, height: 46)
                    .glassEffect(.clear)
            }
        }
    }
}

struct Buttons: View {
    @ObservedObject var viewModel: ActivityVM
    
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                if viewModel.canLogLearned {
                    viewModel.logAsLearned()
                }
            }) {
                Text(viewModel.learnedButtonText)
                    .font(.system(size: 45, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 274, height: 274)
                    .background(viewModel.learnedButtonColor)
                    .clipShape(Circle())
            }
            .glassEffect()
            .disabled(!viewModel.canLogLearned && viewModel.currentDayStatus != .learned && viewModel.currentDayStatus != .freezed)
            
            Spacer()
            
            Button(action: {
                if viewModel.canLogFreezed {
                    viewModel.logAsFreezed()
                }
            }) {
                Text("Log as Freezed")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 315, height: 50)
                    .background(viewModel.freezeButtonEnabled ? Color.blueTeal : Color.blueTeal.opacity(0.3))
                    .cornerRadius(30)
            }
            .glassEffect()
            .disabled(!viewModel.freezeButtonEnabled)
            
            Text(viewModel.freezeCounterText)
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .padding(.top, 10)
                .padding(.bottom, 50)
        

        }
    }
}
struct GoalCompletedView: View {
    let onReset: () -> Void
    let onSameGoal: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer().frame(height: 40)
            
            VStack(spacing: 14) {
                Image(systemName: "hands.clap.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                
                Text("Well done!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Goal completed! Start learning again or set a new learning goal.")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
            }
            
            Button(action: onReset) {
                Text("Set new learning goal")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 55)
                    .background(Color.orangeButton)
                    .cornerRadius(35)
            }
            .glassEffect()
            
            Button(action: onSameGoal) {
                Text("Set same learning goal and duration")
                    .font(.system(size: 15))
                    .foregroundColor(.orange)
            }
        }
    }
}


#Preview {
    ActivityView(onboardingVM: OnBoardingVM())
}
