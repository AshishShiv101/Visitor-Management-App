import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var isLoggedIn = false
    @State private var showOTP = false
    @State private var phoneNumber: String = ""

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
                    .transition(.opacity)
            } else if isLoggedIn {
                TabBarView()
                    .transition(.opacity)
            } else if showOTP {
                OTPView(
                    phoneNumber: phoneNumber,
                    onVerify: {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            isLoggedIn = true
                            showOTP = false
                        }
                    },
                    onChangeNumber: {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            showOTP = false
                        }
                    }
                )
                .transition(.opacity)
            } else {
                LoginPage(onLogin: { number in
                    phoneNumber = number
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showOTP = true
                    }
                })
                .transition(.opacity)
            }
        }
        .onAppear {
            // Show splash screen for 3 seconds, then transition
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    showSplash = false
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
