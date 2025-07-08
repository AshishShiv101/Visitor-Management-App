import SwiftUI

struct LoginPage: View {
    @State private var phoneNumber: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var particles: [Particle] = []
    @State private var showContent = false
    @State private var headerOffset: CGFloat = -50
    @State private var formOffset: CGFloat = 50
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case phoneNumber
    }
    
    var body: some View {
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
                    // Header section
                    VStack(spacing: 25) {
                        // Logo and branding using LogoWithTextView
                        LogoWithTextView(
                            logoSize: 50,
                            iconSize: 20,
                            titleFont: .title2,
                            subtitleFont: .caption,
                            spacing: 15,
                            alignment: .leading
                        )
                        .padding(.horizontal, 20)
                        .offset(y: headerOffset)
                        .opacity(showContent ? 1.0 : 0.0)
                        
                        // Welcome text
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome Back")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Sign in to access your vehicle dashboard")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .offset(y: headerOffset)
                        .opacity(showContent ? 1.0 : 0.0)
                    }
                    .padding(.top, 60)
                    
                    // Form section
                    VStack(spacing: 30) {
                        // Phone number input
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Phone Number")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            ZStack {
                                // Input field background
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                focusedField == .phoneNumber ? Color.white.opacity(0.8) : Color.white.opacity(0.3),
                                                lineWidth: focusedField == .phoneNumber ? 2 : 1
                                            )
                                    )
                                    .animation(.easeInOut(duration: 0.2), value: focusedField)
                                
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.system(size: 16))
                                    
                                    TextField("Enter your phone number", text: $phoneNumber)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .foregroundColor(.white)
                                        .keyboardType(.phonePad)
                                        .focused($focusedField, equals: .phoneNumber)
                                        .placeholder(when: phoneNumber.isEmpty) {
                                            Text("Enter your phone number")
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                            }
                            .frame(height: 56)
                        }
                        
                        // Login button
                        ModernButton(
                            title: "Sign In",
                            isEnabled: !phoneNumber.isEmpty,
                            action: {
                                print("Login tapped with phone: \(phoneNumber)")
                            }
                        )
                        
                        // Additional options
                
                    }
                    .padding(.horizontal, 20)
                    .offset(y: formOffset)
                    .opacity(showContent ? 1.0 : 0.0)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .onAppear {
            initializeParticles()
            startAnimations()
        }
        .onTapGesture {
            focusedField = nil
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
            headerOffset = 0
        }
        
        withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
            formOffset = 0
        }
    }
}

// MARK: - Modern Button Component (Black & White)
struct ModernButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    @State private var isPressed = false
    @State private var shimmerOffset: CGFloat = -1.0
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Base button
                RoundedRectangle(cornerRadius: 12)
                    .fill(isEnabled ? Color.white : Color.white.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
                
                // Shimmer effect for enabled state
                if isEnabled {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.0),
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.0)
                                ]),
                                startPoint: UnitPoint(x: shimmerOffset, y: shimmerOffset),
                                endPoint: UnitPoint(x: shimmerOffset + 0.5, y: shimmerOffset + 0.5)
                            )
                        )
                        .onAppear {
                            withAnimation(
                                Animation.linear(duration: 2.0)
                                    .repeatForever(autoreverses: false)
                            ) {
                                shimmerOffset = 1.0
                            }
                        }
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(isEnabled ? .black : .white.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .disabled(!isEnabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    isPressed = false
                    if isEnabled {
                        action()
                    }
                }
        )
    }
}

// MARK: - Placeholder Extension
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    LoginPage()
}
