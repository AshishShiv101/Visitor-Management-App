import SwiftUI

struct VisitorCardView: View {
    let visitor: VisitorHistoryItem
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Visitor Details")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 24))
                    }
                }
                
                // Content
                VStack(alignment: .leading, spacing: 15) {
                    // Visitor Name
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.white.opacity(0.7))
                        Text(visitor.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    // Visit Date
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.white.opacity(0.7))
                        Text("Date: \(visitor.date)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    // Visit Time
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.white.opacity(0.7))
                        Text("Time: \(visitor.time)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    // Visit Description
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white.opacity(0.7))
                        Text("Purpose: \(visitor.description)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    
                    // Status
                    HStack {
                        Image(systemName: "tag")
                            .foregroundColor(.white.opacity(0.7))
                        Text("Status: \(visitor.status.rawValue)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(visitor.status.color)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(visitor.status.color.opacity(0.15))
                            )
                    }
                }
            }
            .padding(25)
            .frame(width: 300)
            .frame(height: 340) // Increased height to accommodate status
        }
        .frame(width: 320, height: 360) // Adjusted outer frame
    }
}
