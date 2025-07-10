import SwiftUI

struct CurrentVisitorMessage: View {
    // Sample data for visitors with random meeting times
    @State private var visitors: [Visitor] = [
        Visitor(name: "John Doe", time: "10:30 AM", message: "Here for a meeting with the marketing team", meetingTime: randomMeetingTime()),
        Visitor(name: "Jane Smith", time: "11:15 AM", message: "Delivery package for HR department", meetingTime: randomMeetingTime()),
        Visitor(name: "Alex Brown", time: "12:00 PM", message: "Service appointment for AC maintenance", meetingTime: randomMeetingTime()),
        Visitor(name: "Emily Davis", time: "1:00 PM", message: "Client visit to discuss sales report", meetingTime: randomMeetingTime()),
        Visitor(name: "Michael Lee", time: "2:30 PM", message: "Consultation about software implementation", meetingTime: randomMeetingTime())
    ]
    
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    
    private let cardWidth: CGFloat = 280
    private let cardSpacing: CGFloat = 15
    
    // Function to generate random meeting times
    static func randomMeetingTime() -> String {
        let hours = [15, 30, 45, 60, 90, 120].randomElement()!
        return "\(hours) min"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Current Visitors")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Carousel container
            GeometryReader { geometry in
                let totalOffset = -CGFloat(currentIndex) * (cardWidth + cardSpacing) + dragOffset
                
                HStack(spacing: cardSpacing) {
                    ForEach(0..<visitors.count, id: \.self) { index in
                        VisitorCard(visitor: Binding(
                            get: { self.visitors[index] },
                            set: { self.visitors[index] = $0 }
                        ))
                        .frame(width: cardWidth, height: 220)
                    }
                }
                .offset(x: totalOffset)
                .animation(.easeInOut(duration: isDragging ? 0 : 0.5), value: currentIndex)
                .animation(.easeInOut(duration: 0.3), value: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            isDragging = true
                            dragOffset = gesture.translation.width
                        }
                        .onEnded { gesture in
                            isDragging = false
                            let threshold: CGFloat = 50
                            
                            if gesture.translation.width > threshold && currentIndex > 0 {
                                currentIndex -= 1
                            } else if gesture.translation.width < -threshold && currentIndex < visitors.count - 1 {
                                currentIndex += 1
                            }
                            
                            dragOffset = 0
                        }
                )
            }
            .frame(height: 240)
            
            // Page indicators
            HStack(spacing: 8) {
                ForEach(0..<visitors.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.white : Color.white.opacity(0.4))
                        .frame(width: 8, height: 8)
                        .scaleEffect(index == currentIndex ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: currentIndex)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
        }
    }
}

// Visitor data model
struct Visitor: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let message: String
    let meetingTime: String
}

// Visitor card component
struct VisitorCard: View {
    @Binding var visitor: Visitor
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 18))
                    
                    Text(visitor.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(visitor.time)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Text(visitor.message)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
                    .padding(.vertical, 4)
                
                // Meeting time field
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 14))
                    
                    Text("Meeting Time: \(visitor.meetingTime)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.vertical, 4)
                
                Spacer()
                
                // Action buttons
                HStack(spacing: 10) {
                    Button(action: {
                        // Accept action
                    }) {
                        Text("Accept")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Reject action
                    }) {
                        Text("Reject")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Stall action
                    }) {
                        Text("Stall")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(20)
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

#Preview {
    CurrentVisitorMessage()
        .padding()
        .background(Color.black)
}
