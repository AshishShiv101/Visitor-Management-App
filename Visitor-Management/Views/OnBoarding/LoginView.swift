import SwiftUI

struct LoginPage: View {
    @State private var phoneNumber: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var containerOffset: CGFloat = 50
    @State private var topCircleScale: CGFloat = 0.5
    @State private var bottomCircleScale: CGFloat = 0.3
    @State private var topCircleOpacity: Double = 0.1
    @State private var bottomCircleOpacity: Double = 0.2
    @FocusState private var focusedField: Field?
    @Environment(\.colorScheme) var colorScheme
    @State private var particles: [Particle] = []
    
    enum Field: Hashable {
        case phoneNumber
    }
    
    var body: some View {
        ZStack {
            // Black background
            Color.black
                .ignoresSafeArea()
            
            // Particle effect
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x, y: particle.y)
                    .opacity(1.0)
                    .animation(
                        .easeInOut(duration: particle.duration)
                        .repeatForever(autoreverses: true),
                        value: 1.0
                    )
            }
            
            // Main content
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 5) {
                    HStack {
                        Image(systemName: "dumbbell.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(90))
                        Rectangle()
                            .frame(width: 2, height: 30)
                            .foregroundColor(.white)
                        Text("ShapeShift")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                    }
                    Text("Transform Your Fitness Journey")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 40)
                
                // Sign in text
                Text("Sign in to your Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                
                Text("Enter your phone number to log in")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                
                // Glassmorphic container for form
                ZStack {
                    // Glassmorphic background
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.white.opacity(0.6),
                                            Color.white.opacity(0.2)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(Color.gray.opacity(0.05))
                        .padding(3)
                        .blur(radius: 8)
                    
                    // Form content
                    VStack(spacing: 15) {
                        // Phone number field
                        ModernTextField(
                            title: "Phone Number",
                            text: $phoneNumber,
                            isTyping: focusedField == .phoneNumber,
                            keyboardType: .phonePad,
                            autocapitalization: .never
                        )
                        .focused($focusedField, equals: .phoneNumber)
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        
                        // Log in Button
                        ModernButton(
                            title: "Log in",
                            isEnabled: !phoneNumber.isEmpty,
                            action: {
                                print("Login tapped")
                            }
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                }
            }
        }
        .onAppear {
            // Initialize particles
            for _ in 0..<20 {
                let particle = Particle(
                    x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                    y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                    size: CGFloat.random(in: 5...15),
                    duration: Double.random(in: 2...5)
                )
                particles.append(particle)
            }
        }
    }
}

// Modern TextField Component
struct ModernTextField: View {
    let title: String
    @Binding var text: String
    var isTyping: Bool
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    @State private var isValid: Bool = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading, 16)
                .frame(height: 55)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isFocused ? Color.white : Color.white.opacity(0.3),
                            lineWidth: isFocused ? 2 : 1.5
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.95))
                        )
                )
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .foregroundColor(.black)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            Text(title)
                .padding(.horizontal, 8)
                .background(Color.white)
                .foregroundColor(isFocused ? Color.white : .gray)
                .font(.system(size: isFocused || !text.isEmpty ? 12 : 16, weight: isFocused ? .medium : .regular))
                .padding(.leading, 12)
                .offset(y: isFocused || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isFocused = true
                }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onChange(of: isTyping) { newValue in
            isFocused = newValue
        }
    }
}

// Modern Button Component
struct ModernButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    @State private var isPressed = false
    @State private var shimmerOffset: CGFloat = -0.25
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Base gradient
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                isEnabled ? Color.purple : Color.gray.opacity(0.6),
                                isEnabled ? Color.blue : Color.gray.opacity(0.4)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Shimmer effect
                if isEnabled {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.0),
                                    Color.white.opacity(0.1),
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.1),
                                    Color.white.opacity(0.0)
                                ]),
                                startPoint: UnitPoint(x: shimmerOffset, y: shimmerOffset),
                                endPoint: UnitPoint(x: shimmerOffset + 1, y: shimmerOffset + 1)
                            )
                        )
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: false)) {
                                shimmerOffset = 1.25
                            }
                        }
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.7)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}


#Preview {
    LoginPage()
}
