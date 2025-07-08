 
import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let duration: Double
    let delay: Double
}

struct SplashScreen: View {
    @State private var opacity = 0.0
    @State private var scale: CGFloat = 0.5
    @State private var particles: [Particle] = []
    @State private var textOffset: CGFloat = 50
    @State private var showContent = false
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Pure black background
            Color.black
                .ignoresSafeArea()
            
            // Animated white particles
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x, y: particle.y)
                    .opacity(showContent ? 1.0 : 0.0)
                    .scaleEffect(showContent ? 1.0 : 0.0)
                    .animation(
                        .easeInOut(duration: particle.duration)
                        .delay(particle.delay)
                        .repeatForever(autoreverses: true),
                        value: showContent
                    )
            }
            
            // Main content
            VStack(spacing: 40) {
                // Logo container
                LogoView(
                    size: 100,
                    iconSize: 50,
                    showPulse: showContent,
                    pulseScale: pulseScale
                )
                .opacity(opacity)
                .scaleEffect(scale)
                
                // App name and subtitle
                VStack(spacing: 12) {
                    Text("VMS")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(opacity)
                        .offset(y: textOffset)
                    
                    Text("Vehicle Management System")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .opacity(showContent ? 1.0 : 0.0)
                        .offset(y: textOffset)
                        .animation(.easeInOut(duration: 0.8).delay(1.2), value: showContent)
                }
                
                // Loading indicator
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.white.opacity(0.6))
                            .frame(width: 8, height: 8)
                            .scaleEffect(showContent ? 1.0 : 0.5)
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                                value: showContent
                            )
                    }
                }
                .opacity(showContent ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.8).delay(1.5), value: showContent)
            }
        }
        .onAppear {
            initializeParticles()
            startAnimations()
        }
    }
    
    private func initializeParticles() {
        particles = []
        for i in 0..<20 {
            let particle = Particle(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                size: CGFloat.random(in: 2...8),
                duration: Double.random(in: 3...6),
                delay: Double(i) * 0.1
            )
            particles.append(particle)
        }
    }
    
    private func startAnimations() {
        // Main logo animation
        withAnimation(.easeInOut(duration: 1.2)) {
            opacity = 1.0
            scale = 1.0
            textOffset = 0
        }
        
        // Content reveal
        withAnimation(.easeInOut(duration: 0.8).delay(0.8)) {
            showContent = true
        }
        
        // Pulsing effect
        withAnimation(.easeInOut(duration: 2.0).delay(1.0)) {
            pulseScale = 1.2
        }
    }
}

#Preview {
    SplashScreen()
}
