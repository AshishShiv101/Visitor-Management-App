import SwiftUI

struct VisitorHistory: View {
    // Sample data for visitor history
    let history = [
        VisitorHistoryItem(name: "Sarah Wilson", date: "07/07/2025", time: "09:00 AM"),
        VisitorHistoryItem(name: "Mike Johnson", date: "07/06/2025", time: "02:30 PM"),
        VisitorHistoryItem(name: "Emily Davis", date: "07/05/2025", time: "11:45 AM"),
        VisitorHistoryItem(name: "Chris Lee", date: "07/04/2025", time: "04:15 PM")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Visitor History")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ForEach(history) { item in
                HistoryRow(item: item)
            }
        }
    }
}

// Visitor history data model
struct VisitorHistoryItem: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let time: String
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
            }
            .padding(16)
        }
    }
}

#Preview {
    VisitorHistory()
        .padding()
        .background(Color.black)
}
