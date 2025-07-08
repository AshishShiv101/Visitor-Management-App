//
//  ContentView.swift
//  Visitor-Management
//
//  Created by Ashish Shiv on 07/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
                    .transition(.opacity)
            } else {
                LoginPage()
                    .transition(.opacity)
            }
        }
        .onAppear {
            // Show splash screen for 3 seconds, then transition to login
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
