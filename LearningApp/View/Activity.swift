import SwiftUI

struct ActivityView: View {
    @StateObject private var viewModel = ActivityVM()
    var onboardingVM: OnBoardingVM
    
    var body: some View {
        VStack(spacing: 31) {
            NavBar(viewModel: viewModel)
                .padding(.top, 47)
            
            ProgressCard(viewModel: viewModel)
            
            Buttons(viewModel: viewModel)
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
//            NavigationLink(destination: CalendarView()) {
//                Image(systemName: "calendar")
//                    .font(.system(size: 25))
//                    .foregroundColor(.white)
//                    .frame(width: 46, height: 46)
//                    .glassEffect(.clear)
//            }
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

#Preview {
    ActivityView(onboardingVM: OnBoardingVM())
}
