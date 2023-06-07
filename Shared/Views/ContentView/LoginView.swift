import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = false
    @State private var isLoggedIn = false
    @StateObject private var lifeModel: GOLModel = .init(with: 30)
    
    var body: some View {
        if isLoggedIn {
            ContentView()
                .environmentObject(self.lifeModel)
        } else {
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 50) {
            Text(isLogin ? "Log in" : "Register new account")
                .font(.system(.title))
                .fontWeight(.bold)
            VStack(spacing: 30) {
                TextField("Email", text: $email)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor.label), lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                TextField("Password", text: $password)
                    .textContentType(.password)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor.label), lineWidth: 1)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            Button {
                isLogin ? logIn(email: email, password: password) : register(email: email, password: password)
            } label: {
                Text(isLogin ? "Log in" : "Sign Up")
                    .font(.system(.title3))
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 50)
            .background(Color.green)
            .foregroundColor(.black)
            .cornerRadius(10)
            Button {
                isLogin.toggle()
                email = ""
                password = ""
            } label: {
                Text(isLogin ? "Don't have account? Sign up" : "Already have account? Log in" )
            }
        }
        .onAppear() {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    isLoggedIn.toggle()
                }
            }
        }
    }
    
    private func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            isLoggedIn.toggle()
        }
    }
    
    private func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            isLoggedIn.toggle()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
