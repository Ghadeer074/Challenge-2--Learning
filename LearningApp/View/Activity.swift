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
            VStack(spacing: 90) {
                
                Spacer()
                
                // log and freeze buttons
                Buttons()
                
            }
            .navigationTitle("Activity")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Image(systemName: "calendar")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        }
                        .glassEffect()
                        
                        Button(action: {}) {
                            Image(systemName: "pencil.and.outline")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        }
                        .glassEffect()
                    }
                }
            }
        }
    }
}

struct Buttons: View{
    var body: some View{
        VStack(spacing: 12) {
            Button(action: {}) {
                Text("Log as Learned")
                    .font(.system(size: 40, weight: .bold))
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
                    .frame(width: 325, height: 60)
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
        .padding(.top, 210) // move the whole button group slightly down
    }
}

#Preview {
    ActivityView()
}
