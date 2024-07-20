//
//  ContentView.swift
//  VolleyScore
//
//  Created by BAHATTIN KOC on 27.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var leftColor = Color.blue
    @State private var leftScore = 0
    @State private var leftMainScore = 0
    @State private var rightColor = Color.red
    @State private var rightScore = 0
    @State private var rightMainScore = 0

    var body: some View {
        HStack {
            ScoreView(score: $leftScore, fontSize: 220)
                .background(leftColor)
                .gesture(DragGesture()
                    .onEnded { value in
                        withAnimation(.default.speed(1)) {
                            if value.translation.height < 0 {
                                leftScore += 1
                            } else if value.translation.height > 0 {
                                leftScore = max(leftScore - 1, 0)
                            }
                        }
                    }
                )
                .gesture(TapGesture(count: 2)
                    .onEnded { _ in
                        leftScore = 0
                    }
                )

            VStack {
                Button(action: {
                    switchScore()
                }, label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                        .foregroundStyle(.white)
                })
                .padding()

                Spacer()

                HStack {
                    ScoreView(score: $leftMainScore, fontSize: 44)
                        .frame(width: 60, height: 100)
                        .background(leftColor)
                        .clipShape(.buttonBorder)
                        .gesture(DragGesture()
                            .onEnded { value in
                                withAnimation(.default.speed(1)) {
                                    if value.translation.height < 0 {
                                        leftMainScore += 1
                                    } else if value.translation.height > 0 {
                                        leftMainScore = max(leftMainScore - 1, 0)
                                    }
                                }
                            }
                        )
                        .gesture(TapGesture(count: 2)
                            .onEnded { _ in
                                leftMainScore = 0
                            }
                        )

                    ScoreView(score: $rightMainScore, fontSize: 44)
                        .frame(width: 60, height: 100)
                        .background(rightColor)
                        .clipShape(.buttonBorder)
                        .gesture(DragGesture()
                            .onEnded { value in
                                withAnimation(.default.speed(1)) {
                                    if value.translation.height < 0 {
                                        rightMainScore += 1
                                    } else if value.translation.height > 0 {
                                        rightMainScore = max(rightMainScore - 1, 0)
                                    }
                                }
                            }
                        )
                        .gesture(TapGesture(count: 2)
                            .onEnded { _ in
                                rightMainScore = 0
                            }
                        )
                }
                .padding(.bottom, 20.0)
            }

            ScoreView(score: $rightScore, fontSize: 220)
                .background(rightColor)
                .gesture(DragGesture()
                    .onEnded { value in
                        withAnimation(.default.speed(1)) {
                            if value.translation.height < 0 {
                                rightScore += 1
                            } else if value.translation.height > 0 {
                                rightScore = max(rightScore - 1, 0)
                            }
                        }
                    }
                )
                .gesture(TapGesture(count: 2)
                    .onEnded { _ in
                        rightScore = 0
                    }
                )
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func switchScore() {
        (leftColor, rightColor) = (rightColor, leftColor)
        (leftScore, rightScore) = (rightScore, leftScore)
        (leftMainScore, rightMainScore) = (rightMainScore, leftMainScore)
    }
}

struct ScoreView: View {
    @Binding var score: Int
    var fontSize: CGFloat

    var body: some View {
        VStack {
            Text("\(score)")
                .font(.system(size: fontSize))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .contentTransition(.numericText(countsDown: true))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
