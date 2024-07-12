
import SwiftUI
import CoreData

struct LoginView: View {
    @State private var studentNumber: String = ""
    @State private var password: String = ""
    @State private var isLoginActive: Bool = false
    @State private var loginFailed: Bool = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            if isLoginActive {
                ContentView()
                    .environment(\.managedObjectContext, viewContext)
            } else {
                NavigationView {
                    VStack {
                        Text("Giriş Ekranı")
                            .font(.largeTitle)
                        
                        TextField("Öğrenci Numarası", text: $studentNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        SecureField("Şifre", text: $password)
                            

.textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            if authenticateUser(studentNumber: studentNumber, password: password) {
                                self.isLoginActive = true
                            } else {
                                self.loginFailed = true
                            }
                        }) {
                            Text("Giriş Yap")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .alert(isPresented: $loginFailed) {
                            Alert(title: Text("Giriş Başarısız"), message: Text("Geçersiz öğrenci numarası veya şifre"), dismissButton: .default(Text("Tamam")))
                        }

                        NavigationLink(destination: RegistrationView()) {
                            Text("Kayıt Ol")
                                .foregroundColor(.blue)
                        }
                        .padding()

                    }
                    .padding()
                }
            }
        }
    }

    func authenticateUser(studentNumber: String, password: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "studentNumber == %@ AND password == %@", studentNumber, password)

        do {
            let users = try viewContext.fetch(fetchRequest)
            return users.count > 0
        } catch let error as NSError {
            print("Giriş yapılamadı. \(error), \(error.userInfo)")
            return false
        }
    }
}


