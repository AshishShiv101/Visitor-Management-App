import SwiftUI



struct OTPView: View {
    @State private var otpDigits: [String] = ["", "", "", ""]
    @State private var particles: [Particle] = []
    @State private var showContent = false
    @State private var headerOffset: CGFloat = -50
    @State private var formOffset: CGFloat = 50
    @FocusState private var focusedField: Int?
    
    var phoneNumber: String // Phone number passed from LoginPage
    var onVerify: () -> Void // Closure to trigger login on successful OTP
    var onChangeNumber: () -> Void // Closure to navigate back to LoginPage
    
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Enter OTP")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Code sent to \(phoneNumber)")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                    .offset(y: headerOffset)
                    .opacity(showContent ? 1.0 : 0.0)
                    
                    // Form section
                    VStack(spacing: 30) {
                        // OTP input fields
                        HStack(spacing: 12) {
                            ForEach(0..<4, id: \.self) { index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    focusedField == index ? Color.white.opacity(0.8) : Color.white.opacity(0.3),
                                                    lineWidth: focusedField == index ? 2 : 1
                                                )
                                        )
                                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                                    
                                    TextField("", text: $otpDigits[index])
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .foregroundColor(.white)
                                        .keyboardType(.numberPad)
                                        .focused($focusedField, equals: index)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 50, height: 56)
                                        .onChange(of: otpDigits[index]) { _, newValue in
                                            // Limit to single digit
                                            otpDigits[index] = String(newValue.prefix(1))
                                            // Move focus to next field
                                            if !newValue.isEmpty {
                                                focusedField = index < 3 ? index + 1 : nil
                                            }
                                        }
                                        .placeholder(when: otpDigits[index].isEmpty, alignment: .center) {
                                            Text("0")
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                }
                                .frame(width: 56, height: 56)
                            }
                        }
                        
                        // Verify OTP button
                        ModernButton(
                            title: "Verify OTP",
                            isEnabled: otpDigits.joined().count == 4,
                            action: {
                                let enteredOTP = otpDigits.joined()
                                if enteredOTP == "1234" { // Default OTP for demo
                                    onVerify()
                                } else {
                                    print("Invalid OTP: \(enteredOTP)")
                                }
                            }
                        )
                        
                        // Resend OTP link
                        Button(action: {
                            print("Resend OTP tapped")
                        }) {
                            Text("Resend OTP")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                                .underline()
                        }
                        
                        // Change Number link
                        Button(action: {
                            onChangeNumber()
                        }) {
                            Text("Change Number")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                                .underline()
                        }
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



#Preview {
    OTPView(phoneNumber: "0123456789", onVerify: {}, onChangeNumber: {})
}
