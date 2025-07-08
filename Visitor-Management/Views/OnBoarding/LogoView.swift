import SwiftUI

struct LogoView: View {
    let size: CGFloat
    let iconSize: CGFloat
    let showPulse: Bool
    let pulseScale: CGFloat
    
    @State private var animatedPulseScale: CGFloat = 1.0
    
    init(size: CGFloat = 100, iconSize: CGFloat = 50, showPulse: Bool = false, pulseScale: CGFloat = 1.2) {
        self.size = size
        self.iconSize = iconSize
        self.showPulse = showPulse
        self.pulseScale = pulseScale
    }
    
    var body: some View {
        ZStack {
            if showPulse {
                // Pulsing outer circle
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    .frame(width: size + 40, height: size + 40)
                    .scaleEffect(animatedPulseScale)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true),
                        value: animatedPulseScale
                    )
                    .onAppear {
                        animatedPulseScale = pulseScale
                    }
            }
            
            // Inner circle background
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: size, height: size)
            
            // Outer stroke
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                .frame(width: size, height: size)
            
            // Logo icon
            Image(systemName: "v.circle.fill")
                .font(.system(size: iconSize, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Compact Logo View for Navigation/Header
struct CompactLogoView: View {
    let size: CGFloat
    let iconSize: CGFloat
    let showBackground: Bool
    
    init(size: CGFloat = 46, iconSize: CGFloat = 20, showBackground: Bool = true) {
        self.size = size
        self.iconSize = iconSize
        self.showBackground = showBackground
    }
    
    var body: some View {
        ZStack {
            if showBackground {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: size, height: size)
            }
            
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                .frame(width: size + 4, height: size + 4)
            
            Image(systemName: "person.fill")
                .font(.system(size: iconSize, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Logo with Text Component
struct LogoWithTextView: View {
    let logoSize: CGFloat
    let iconSize: CGFloat
    let titleFont: Font
    let subtitleFont: Font
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    
    init(
        logoSize: CGFloat = 46,
        iconSize: CGFloat = 20,
        titleFont: Font = .title2,
        subtitleFont: Font = .caption,
        spacing: CGFloat = 15,
        alignment: HorizontalAlignment = .leading
    ) {
        self.logoSize = logoSize
        self.iconSize = iconSize
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.spacing = spacing
        self.alignment = alignment
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            CompactLogoView(size: logoSize, iconSize: iconSize)
            
            VStack(alignment: alignment, spacing: 2) {
                Text("VMS")
                    .font(titleFont)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Visitor Management")
                    .font(subtitleFont)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            if alignment == .leading {
                Spacer()
            }
        }
    }
}

#Preview("Main Logo") {
    ZStack {
        Color.black.ignoresSafeArea()
        LogoView(size: 100, iconSize: 50, showPulse: true)
    }
}

#Preview("Compact Logo") {
    ZStack {
        Color.black.ignoresSafeArea()
        CompactLogoView()
    }
}

#Preview("Logo with Text") {
    ZStack {
        Color.black.ignoresSafeArea()
        LogoWithTextView()
            .padding()
    }
}
