import SwiftUI

struct VisitorHistoryLibrary: View {
    let allHistory: [VisitorHistoryItem]
    @State private var selectedVisitor: VisitorHistoryItem?
    @State private var searchText = ""
    @State private var selectedDate: Date? = nil // Changed to optional to allow deselection
    
    // Filter history based on search text and selected date
    private var filteredHistory: [VisitorHistoryItem] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return allHistory.filter { item in
            let matchesSearch = searchText.isEmpty ||
                item.name.lowercased().contains(searchText.lowercased()) ||
                item.description.lowercased().contains(searchText.lowercased())
            
            // Only apply date filter if selectedDate is not nil
            if let selectedDate = selectedDate {
                let selectedDateString = dateFormatter.string(from: selectedDate)
                return matchesSearch && item.date == selectedDateString
            }
            return matchesSearch
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Search bar and DatePicker
                HStack(spacing: 12) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.7))
                        
                        TextField("Search visitors...", text: $searchText)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    )
                    
                    // Date picker
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { selectedDate ?? Date() },
                            set: { selectedDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(.white)
                    .frame(width: 120)
                    
                    // Clear date button
                    Button(action: {
                        selectedDate = nil
                    }) {
                        Text("Clear Date")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white.opacity(0.15))
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // Visitor list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredHistory) { item in
                            LibraryHistoryRow(item: item)
                                .onTapGesture {
                                    selectedVisitor = item
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            // Overlay card
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
        .navigationTitle("All Visitors")
        .navigationBarTitleDisplayMode(.large)
    }
}

// Enhanced history row for library view
struct LibraryHistoryRow: View {
    let item: VisitorHistoryItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
            
            HStack(spacing: 15) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "person.fill")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.system(size: 18))
                }
                
                // Content
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(item.date) at \(item.time)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
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
    VisitorHistoryLibrary(allHistory: [
        VisitorHistoryItem(name: "Sarah Wilson", date: "07/07/2025", time: "09:00 AM", description: "Business meeting", status: .completed),
        VisitorHistoryItem(name: "Mike Johnson", date: "07/06/2025", time: "02:30 PM", description: "Project consultation", status: .completed),
        VisitorHistoryItem(name: "Emily Davis", date: "07/05/2025", time: "11:45 AM", description: "Guest speaker", status: .cancelled),
        VisitorHistoryItem(name: "Chris Lee", date: "07/04/2025", time: "04:15 PM", description: "Client visit", status: .completed),
        VisitorHistoryItem(name: "Alex Thompson", date: "07/03/2025", time: "10:30 AM", description: "Training session", status: .cancelled),
        VisitorHistoryItem(name: "Jessica Brown", date: "07/02/2025", time: "03:00 PM", description: "Partnership meeting", status: .completed)
    ])
}
