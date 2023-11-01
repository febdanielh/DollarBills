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

let newOnboardSteps = [
    "Collect your items along your route",
    "Challenge other runners, use item strategically",
    "New Routes,\nNew Excitement"
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
                                .foregroundColor(Color.YellowLight1)
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
                                    .foregroundColor(.YellowLight1)
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
    AnotherOnboardingView(shouldShowOnboarding: .constant(true))
}

struct NewOnboardingView: View {
    @State var currentStep = 0
    @State private var rotationAngle: Double = 0
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(){
            HStack {
                ForEach(0..<newOnboardSteps.count) { i in
                    if i == currentStep {
                        Rectangle()
                            .frame(width: 100, height: 7)
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                    } else {
                        Rectangle()
                            .frame(width: 100, height: 7)
                            .cornerRadius(10)
                            .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                    }
                }
            }
            
            TabView(selection: $currentStep) {
                ForEach(0..<newOnboardSteps.count) { i  in
                    VStack {
                        ZStack {
                            Image("bg spruto")
                                .rotationEffect(Angle(degrees: rotationAngle), anchor: .center)
                                .transition(.slide)
                            Image("spruto lari")
                        }.padding(.bottom)
                        
                        Text(newOnboardSteps[i])
                            .font(.system(size: 36))
                            .bold()
                            .foregroundColor(.black)
                            .frame(width: 290, height: 140, alignment: .topLeading)
                            .padding(.top)
                    }
                    .tag(i)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentStep, perform: { _ in
                withAnimation(.bouncy) {
                    rotationAngle += 90
                }
            })
            
            Button(action: {
                if self.currentStep < onboardingSteps.count - 1 {
                    self.currentStep += 1
                } else {
                    vm.currentDisplayScreen = .viewMain
                    print("button pencet")
                }
            }, label: {
                Text(currentStep < onboardingSteps.count - 1 ? "Next" : "Get Started")
            })
            .buttonStyle(ActiveBlackButton()).bold()
        }.padding()
    }
}

struct AnotherOnboardingView: View {
    @State var currentStep = -1
    @State private var rotationAngle: Double = 0
    @EnvironmentObject var vm: ViewModel
    @Binding var shouldShowOnboarding: Bool
    
    @State var anotherOnboardSteps = [
        "",
        "Furthr",
        "Are you ready to experience a new way of running?",
        "Let’s make running more fun with Furthr as your guide.",
        "Collect items during your run,",
        "Use items strategically on a competitive duel mode...",
        "And increase your sense of competitiveness!"
    ]
    
    @State var visibleTexts: [String] = []
    @State var topLine: String = "Furthr"
    @State var fontSize: CGFloat = 20
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(visibleTexts, id: \.self) { text in
                    Text(text)
                        .font(.system(size: text == "Furthr" ? 28 : fontSize)).bold()
                        .multilineTextAlignment(.leading)
                        .opacity(text == topLine ? 1 : 0.5)
                        .frame(width: 320, alignment: .topLeading)
                        .padding(.horizontal).padding(.horizontal)
                        .transition(AnyTransition.opacity.animation(.smooth(duration: 0.5)))
                }
                Spacer()
                Image("spruto")
                Spacer()
            }
            .padding()
            
            if currentStep == anotherOnboardSteps.count - 1 {
                Button(action: {
                    vm.currentDisplayScreen = .viewMain
                    shouldShowOnboarding = false
                    print("go to main")
                }) {
                    Text("Let's Go")
                        .fontWeight(.semibold)
                }
                .buttonStyle(ActiveBlackSheetButton())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            updateVisibleTexts()
            if currentStep == 0 {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                    updateVisibleTexts()
                    if currentStep == anotherOnboardSteps.count - 1 {
                        timer.invalidate()
                        visibleTexts = ["Your adventure begins now!"]
                        topLine = "Your adventure begins now!"
                        fontSize = 50
                    }
                }
            }
        }
    }
    
    func updateVisibleTexts() {
        let nextIndex = (currentStep + 1) % anotherOnboardSteps.count
        let endIndex = min(nextIndex + 3, anotherOnboardSteps.count)
        visibleTexts = Array(anotherOnboardSteps[nextIndex..<endIndex])
        currentStep = nextIndex
        
        if visibleTexts.count >= 2 {
            if currentStep >= 0 {
                withAnimation {
                    topLine = visibleTexts[1]
                }
            }
        }
    }
}
