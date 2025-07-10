import SwiftUI

// Data model for login history items
struct LoginHistoryItem: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let device: String
    let location: String
}

struct LoginHistoryView: View {
    // Sample login history data (replace with actual data source)
    private let loginHistory: [LoginHistoryItem] = [
        LoginHistoryItem(date: "07/10/2025", time: "12:30 PM", device: "iPhone 14", location: "New York, NY"),
        LoginHistoryItem(date: "07/09/2025", time: "09:15 AM", device: "MacBook Pro", location: "San Francisco, CA"),
        LoginHistoryItem(date: "07/08/2025", time: "03:45 PM", device: "iPad Air", location: "Chicago, IL"),
        LoginHistoryItem(date: "07/07/2025", time: "11:20 AM", device: "iPhone 14", location: "Boston, MA"),
        LoginHistoryItem(date: "07/06/2025", time: "08:30 AM", device: "Windows PC", location: "Seattle, WA")
    ]
    
    var body: some View {
        ZStack {
            // Pure black background
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Login History")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Recent account activity")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Login history list
                    LazyVStack(spacing: 12) {
                        ForEach(loginHistory) { item in
                            LoginHistoryRow(item: item)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationTitle("Login History")
        .navigationBarTitleDisplayMode(.large)
    }
}

// Login history row component
struct LoginHistoryRow: View {
    let item: LoginHistoryItem
    
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
                    
                    Image(systemName: "lock.shield.fill")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.system(size: 18))
                }
                
                // Content
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.device)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text(item.location)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("\(item.date) at \(item.time)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
                    .font(.system(size: 14))
            }
            .padding(16)
        }
    }
}

#Preview {
    LoginHistoryView()
}
