//
//  Untitled.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 02/05/1447 AH.
//
 import SwiftUI

struct ProgressCard: View {
    let dayLabels = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let dates = [8, 9, 10, 11, 12, 13, 14]
   
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Month header with navigation
            HStack {
                HStack(spacing: 4) {
                    Text("October 2025")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.orange)
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.orange)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.orange)
                    }
                }
            }
            
            // Day labels
            HStack(spacing: 0) {
                ForEach(dayLabels, id: \.self) { label in
                    Text(label)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates row
            HStack(spacing: 0) {
                ForEach(0..<7) { index in
                    if index == 0 {
                        Text("\(dates[index])")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.orange)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("\(dates[index])")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            // Learning topic and stats
            VStack(alignment: .leading, spacing: 12) {
                Text("Learning how ")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                
                HStack(spacing: 12) {
                    // Days Learned
                    HStack(spacing: 12) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.orange)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("0")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Days Learned")
                                .font(.system(size: 15))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .background(Color.brown.opacity(0.8))
                    .cornerRadius(50)
                    
                    // Days Freezed
                    HStack(spacing: 12) {
                        Image(systemName: "cube.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.cyan)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("0")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Days Freezed")
                                .font(.system(size: 15))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 90)
                    .background(Color.teal.opacity(0.3))
                    .cornerRadius(50)
                }
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.1))
        .cornerRadius(30)
    }
    }

#Preview {
    ProgressCard()
}
