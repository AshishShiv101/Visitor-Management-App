import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let duration: Double
}

struct SplashScreen: View {
    @State private var opacity = 0.0
    @State private var scale: CGFloat = 0.8
    @State private var particles: [Particle] = []
    
    var body: some View {
        ZStack {
            // Black background
            Color.black
                .ignoresSafeArea()
            
            // Particle effect
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x, y: particle.y)
                    .opacity(opacity)
                    .animation(
                        .easeInOut(duration: particle.duration)
                        .repeatForever(autoreverses: true),
                        value: opacity
                    )
            }
            
            // Logo and text
            VStack {
        
                
                Text("VMS")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .opacity(opacity)
            .scaleEffect(scale)
        }
        .onAppear {
            // Initialize particles
            for _ in 0..<20 {
                let particle = Particle(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                    size: CGFloat.random(in: 5...30),
                    duration: Double.random(in: 2...5)
                )
                particles.append(particle)
            }
            
            // Animation for logo and text
            withAnimation(.easeInOut(duration: 1.5)) {
                opacity = 1.0
                scale = 1.0
            }
        }
    }
}

#Preview {
    SplashScreen()
}
