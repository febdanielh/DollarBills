//
//  OnboardingView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 13/10/23.
//

import SwiftUI

struct OnboardingSteps {
    let image: String
    let title: String
    let descriptions: String
}

private let onboardingSteps = [
    OnboardingSteps(image: "map and route", title: "MAP AND ROUTE", descriptions: "In Qokka, you won't just run without direction. You'll have access to various routes  that will make your experience more engaging."),
    OnboardingSteps(image: "scavenger hunt", title: "SCAVENGER HUNT", descriptions: "At Qokka, we merge sports and adventure into one. As you run, you'll discover valuable items, and these items will aid you in race features."),
    OnboardingSteps(image: "running race", title: "RUNNING RACE", descriptions: "In the Race feature, you'll compete with others. Use Scavenger Hunt items to attack or boost your performance. Speed and strategy are key!")
    
]

struct OnboardingView: View {
    @State var currentStep = 0
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack{
            Color.YellowNormal
                .ignoresSafeArea()
            Image("puzzle piece 1")
                .offset(x: -90, y: 315)
            Image("puzzle piece 2")
                .offset(x: 150, y: 30)
            VStack(){
                Text("Step \(currentStep + 1) of \(onboardingSteps.count)")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top)
                HStack {
                    ForEach(0..<onboardingSteps.count) { i in
                        if i == currentStep {
                            Rectangle()
                                .frame(width: 44, height: 16)
                                .cornerRadius(10)
                                .foregroundColor(Color.primaryColor02)
                        } else {
                            Rectangle()
                                .frame(width: 44, height: 16)
                                .cornerRadius(10)
                                .foregroundColor(Color.YellowDark4)
                        }
                    }
                }
                TabView(selection: $currentStep) {
                    ForEach(0..<onboardingSteps.count) { i  in
                        VStack {
                            Spacer().frame(height: 50)
                            Image(onboardingSteps[i].image)
                                .resizable()
                                .frame(width: 288, height: 191)
                                .padding()
                            ZStack{
                                Text(onboardingSteps[i].title)
                                    .font(.system(size: 32))
                                    .bold()
                                    .foregroundColor(.black)
                                    .offset(x: -3, y: 1)
                                Text(onboardingSteps[i].title)
                                    .font(.system(size: 32))
                                    .bold()
                                    .foregroundColor(.primaryColor02)
                            }
                            Text(onboardingSteps[i].descriptions)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                .frame(width: 308)
                                .bold()
                                .foregroundColor(.black)
                                .padding()
                            Spacer()
                        }
                        .tag(i)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                Button(action: {
                    if self.currentStep < onboardingSteps.count - 1 {
                        self.currentStep += 1
                    } else {
                        vm.currentDisplayScreen = .viewMain
                        print("button pencet")
                    }
                }, label: {
                    Text(currentStep < onboardingSteps.count - 1 ? "Next" : "Start Exploring")
                })
                .buttonStyle(ActiveBlackButton())
                .bold()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
