import SwiftUI

// Core content of VisitorHistory without NavigationStack
struct VisitorHistoryContent: View {
    let history: [VisitorHistoryItem]
    @Binding var selectedVisitor: VisitorHistoryItem?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Visitor History")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ForEach(history.prefix(4)) { item in
                HistoryRow(item: item)
                    .onTapGesture {
                        selectedVisitor = item
                    }
            }
            
            if history.count > 4 {
                NavigationLink(destination: VisitorHistoryLibrary(allHistory: history)) {
                    HStack {
                        Text("View More")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 14))
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
            }
        }
        .padding()
        .background(Color.black)
    }
}

// Original VisitorHistory with NavigationStack
struct VisitorHistory: View {
    let history = [
        VisitorHistoryItem(name: "Sarah Wilson", date: "07/07/2025", time: "09:00 AM", description: "Business meeting", status: .completed),
        VisitorHistoryItem(name: "Mike Johnson", date: "07/06/2025", time: "02:30 PM", description: "Project consultation", status: .completed),
        VisitorHistoryItem(name: "Emily Davis", date: "07/05/2025", time: "11:45 AM", description: "Guest speaker", status: .cancelled),
        VisitorHistoryItem(name: "Chris Lee", date: "07/04/2025", time: "04:15 PM", description: "Client visit", status: .completed),
        VisitorHistoryItem(name: "Alex Thompson", date: "07/03/2025", time: "10:30 AM", description: "Training session", status: .cancelled),
        VisitorHistoryItem(name: "Jessica Brown", date: "07/02/2025", time: "03:00 PM", description: "Partnership meeting", status: .completed)
    ]
    
    @State private var selectedVisitor: VisitorHistoryItem?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VisitorHistoryContent(history: history, selectedVisitor: $selectedVisitor)
                
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
        }
    }
}

// Visitor status enum
enum VisitorStatus: String, CaseIterable {
    case completed = "Completed"
    case cancelled = "Cancelled"
    
    var color: Color {
        switch self {
        case .completed:
            return .green
        case .cancelled:
            return .red
        }
    }
}

// Visitor history data model
struct VisitorHistoryItem: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let time: String
    let description: String
    let status: VisitorStatus
}

// History row component
struct HistoryRow: View {
    let item: VisitorHistoryItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
            
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 16))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text("\(item.date) at \(item.time)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Status label
                Text(item.status.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(item.status.color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(item.status.color.opacity(0.15))
                    )
            }
            .padding(16)
        }
    }
}

#Preview {
    VisitorHistory()
}
