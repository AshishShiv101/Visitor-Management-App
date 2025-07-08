import SwiftUI

struct CurrentVisitorMessage: View {
    // Sample data for visitors
    let visitors = [
        Visitor(name: "John Doe", time: "10:30 AM", message: "Here for a meeting"),
        Visitor(name: "Jane Smith", time: "11:15 AM", message: "Delivery package"),
        Visitor(name: "Alex Brown", time: "12:00 PM", message: "Service appointment")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Current Visitors")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(visitors) { visitor in
                        VisitorCard(visitor: visitor)
                    }
                }
                .padding(.vertical, 10)
            }
        }
    }
}

// Visitor data model
struct Visitor: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let message: String
}

// Visitor card component
struct VisitorCard: View {
    let visitor: Visitor
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 16))
                    
                    Text(visitor.name)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                Text(visitor.time)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(visitor.message)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
            }
            .padding(16)
            .frame(width: 200, alignment: .leading)
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
