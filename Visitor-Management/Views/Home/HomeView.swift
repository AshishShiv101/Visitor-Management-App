import SwiftUI

struct HomeView: View {
    @State private var particles: [Particle] = []
    @State private var showContent = false
    @State private var selectedVisitor: VisitorHistoryItem?
    
    // Sample data for visitor history
    let history = [
        VisitorHistoryItem(name: "Sarah Wilson", date: "07/07/2025", time: "09:00 AM", description: "Business meeting",status: .completed),
        VisitorHistoryItem(name: "Mike Johnson", date: "07/06/2025", time: "02:30 PM", description: "Project consultation",status: .cancelled),
        VisitorHistoryItem(name: "Emily Davis", date: "07/05/2025", time: "11:45 AM", description: "Guest speaker",status: .cancelled),
        VisitorHistoryItem(name: "Chris Lee", date: "07/04/2025", time: "04:15 PM", description: "Client visit",status: .completed),
        VisitorHistoryItem(name: "Alex Thompson", date: "07/03/2025", time: "10:30 AM", description: "Training session",status: .cancelled),
        VisitorHistoryItem(name: "Jessica Brown", date: "07/02/2025", time: "03:00 PM", description: "Partnership meeting",status: .completed)
    ]
    
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
                        VisitorHistoryContent(history: history, selectedVisitor: $selectedVisitor)
                            .padding(.horizontal, 20)
                            .padding(.bottom,-50)
                            .opacity(showContent ? 1.0 : 0.0)
                            .offset(y: showContent ? 0 : 50)
                        
                        Spacer(minLength: 50)
                    }
                }
                
                // Overlay card for selected visitor
                if let visitor = selectedVisitor {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            selectedVisitor = nil
                        }
                    
                    VisitorCardView(visitor: visitor) {
                        selectedVisitor = nil
                    }
                    .transition(.scale)
                    .zIndex(1)
                }
            }
            .onAppear {
                initializeParticles()
                startAnimations()
            }
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
