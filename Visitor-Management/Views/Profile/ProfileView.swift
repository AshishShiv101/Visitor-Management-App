import SwiftUI

struct ProfileView: View {
    @State private var particles: [Particle] = []
    @State private var showContent = false
    
    // Sample user data (replace with actual data source)
    private let userName = "John Doe"
    private let mobileNumber = "+1 (555) 123-4567"
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Pure black background
                Color.black
                    .ignoresSafeArea()
                
                // Floating white particles
                ForEach(particles) { particle in
                    Circle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: particle.size, height: particle.size)
                        .position(x: particle.x, y: particle.y)
                        .opacity(showContent ? 1.0 : 0.0)
                        .animation(
                            .easeInOut(duration: particle.duration)
                            .delay(particle.delay)
                            .repeatForever(autoreverses: true),
                            value: showContent
                        )
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Profile")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Manage your account details")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: showContent ? 0 : -50)
                        
                        // User Info Card
                        VStack(spacing: 12) {
                            Text(userName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text(mobileNumber)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                        .padding(.horizontal, 20)
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: showContent ? 0 : 50)
                        
                        // Login History Button Card
                        NavigationLink(destination: LoginHistoryView()) {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                
                                Text("Login History")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.1))
                            )
                        }
                        .padding(.horizontal, 20)
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: showContent ? 0 : 50)
                        
                        // Logout Button Card
                        Button(action: {
                            // Handle logout action
                            print("Logout tapped")
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                
                                Text("Logout")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.red.opacity(0.8))
                            )
                        }
                        .padding(.horizontal, 20)
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: showContent ? 0 : 50)
                        
                        Spacer(minLength: 50)
                    }
                }
            }
            .onAppear {
                initializeParticles()
                startAnimations()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func initializeParticles() {
        particles = []
        for i in 0..<15 {
            let particle = Particle(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                size: CGFloat.random(in: 3...6),
                duration: Double.random(in: 4...8),
                delay: Double(i) * 0.2
            )
            particles.append(particle)
        }
    }
    
    private func startAnimations() {
        withAnimation(.easeInOut(duration: 0.8)) {
            showContent = true
        }
    }
}



#Preview {
    ProfileView()
}
