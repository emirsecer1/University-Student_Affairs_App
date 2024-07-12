
import SwiftUI
import CoreData

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var studentNumber: String = ""
    @State private var password: String = ""
    @State private var isSaved: Bool = false
    @State private var registrationFailed: Bool = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Text("Kayıt Ekranı")
                .font(.largeTitle)
            
            TextField("İsim", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Öğrenci Numarası", text: $studentNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Şifre", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if isUserRegistered(studentNumber:

studentNumber) {
                    self.registrationFailed = true
                } else {
                    saveUser(name: name, studentNumber: studentNumber, password: password)
                    self.isSaved = true
                }
            }) {
                Text("Kaydet")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .alert(isPresented: $isSaved) {
                Alert(title: Text("Kayıt Başarılı"), message: Text("Kullanıcı başarıyla kaydedildi"), dismissButton: .default(Text("Tamam")))
            }
            .alert(isPresented: $registrationFailed) {
                Alert(title: Text("Kayıt Başarısız"), message: Text("Bu öğrenci numarası zaten kayıtlı"), dismissButton: .default(Text("Tamam")))
            }
        }
        .padding()
    }

    func isUserRegistered(studentNumber: String) -> Bool {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "studentNumber == %@", studentNumber)

        do {
            let users = try viewContext.fetch(fetchRequest)
            return users.count > 0
        } catch let error as NSError {
            print("Kayıt kontrolü yapılamadı. \(error), \(error.userInfo)")
            return false
        }
    }

    func saveUser(name: String, studentNumber: String, password: String) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: viewContext)!
        let user = NSManagedObject(entity: entity, insertInto: viewContext)

        user.setValue(name, forKey: "name")
        user.setValue(studentNumber, forKey: "studentNumber")
        user.setValue(password, forKey: "password")

        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Kaydedilemedi. \(error), \(error.userInfo)")
        }
    }

}


