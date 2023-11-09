//
//  OnboardingView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 13/10/23.
//

import SwiftUI
import AuthenticationServices
import GoTrue
import Supabase

struct OnboardingView: View {
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
    @State var isLast: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                if currentStep < anotherOnboardSteps.count - 1 {
                    ForEach(visibleTexts, id: \.self) { text in
                        Text(text)
                            .font(.system(size: text == "Furthr" ? 28 : fontSize)).bold()
                            .multilineTextAlignment(.leading)
                            .opacity(text == topLine ? 1 : 0.5)
                            .frame(width: 320, alignment: .topLeading)
                            .padding(.horizontal).padding(.horizontal)
                            .transition(AnyTransition.opacity.animation(.smooth(duration: 0.5)))
                    }
                } else if isLast == true  {
                    Text("Your\nadventure\nbegins\nnow!")
                        .font(.system(size: 36)).bold()
                        .foregroundColor(.black)
                        .lineSpacing(5)
                        .frame(width: 290, alignment: .leading)
                        .padding(.horizontal).padding(.horizontal)
                } else {
                    Text("Before We Start!")
                        .font(.system(size: 30)).bold()
                        .foregroundColor(.black)
                        .frame(width: 260, alignment: .leading)
                        .padding(.horizontal).padding(.horizontal)
                    Text("Help us provide the best experience by signing in with Apple")
                        .font(.system(size: 18)).bold()
                        .opacity(0.5)
                        .multilineTextAlignment(.leading)
                        .frame(width: 235, alignment: .topLeading)
                        .lineSpacing(5)
                        .padding(.horizontal).padding(.horizontal)
                }
                Spacer()
                Image("spruto")
                Spacer()
            }
            .padding()
            
            if currentStep == anotherOnboardSteps.count - 1 && isLast == false {
                SignInWithAppleButton { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    Task {
                        do {
                            guard let credential = try result.get().credential as? ASAuthorizationAppleIDCredential else { return }
                            
                            guard let idToken = credential.identityToken
                                .flatMap({ String(data: $0, encoding: .utf8) })
                            else { return }
                            
//                            try await vm.signInApple(uid: idToken)
                            try await Supabase.shared.client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken))
                            await vm.isUserAuthenticated()
                        } catch {
                            dump(error)
                        }
                        isLast = true
                    }
                }.frame(width: 300, height: 44).cornerRadius(18)
            } else if isLast == true {
                Button(action: {
                    vm.currentDisplayScreen = .viewMain
                    shouldShowOnboarding = false
                    print("go to main")
                }) {
                    Text("Let's Go")
                        .fontWeight(.semibold)
                }
                .buttonStyle(ActiveBlackButton())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            updateVisibleTexts()
            if currentStep == 0 {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                    updateVisibleTexts()
                    if currentStep == anotherOnboardSteps.count - 1 {
                        timer.invalidate()
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

#Preview {
    OnboardingView(shouldShowOnboarding: .constant(true))
}
