import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.white) // White icons for active tab
        .onAppear {
            // Customize tab bar appearance with translucent effect
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
            // Customize tab item colors
            appearance.stackedLayoutAppearance.normal.iconColor = .white.withAlphaComponent(0.7)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
            appearance.stackedLayoutAppearance.selected.iconColor = .white
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    TabBarView()
}
