import SwiftUI

struct LoginView: View {
    @State private var userName: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to TeamTimes")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                TextField("Enter your name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(userName.isEmpty)
                
                Spacer()
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                ContentView()
            }
        }
    }
}

#Preview {
    LoginView()
} 
