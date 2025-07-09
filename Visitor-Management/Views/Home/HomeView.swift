import SwiftUI

struct HomeView: View {
    @State private var particles: [Particle] = []
    @State private var showContent = false
    
    var body: some View {
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
                VStack(spacing: 40) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Home Dashboard")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Monitor your visitors and history")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                    .opacity(showContent ? 1.0 : 0.0)
                    .offset(y: showContent ? 0 : -50)
                    
                    // Current Visitor Message Component
                    CurrentVisitorMessage()
                        .padding(.horizontal, 20)
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: showContent ? 0 : 50)
                    
                    // Visitor History Component
                    VisitorHistory()
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
    HomeView()
}
