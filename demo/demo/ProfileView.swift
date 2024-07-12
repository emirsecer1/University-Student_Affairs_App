
import SwiftUI

struct ProfileView: View {
    @State private var name = "Ali Veli"
    @State private var email = "ali.veli@example.com"
    @State private var studentNumber = "000000001"
    @State private var profileImage: Image? = nil
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage? = nil
    
    var body: some View {
        Form {
            Section(header: Text("Kişisel Bilgiler")) {
                TextField("İsim", text: $name)
                TextField("E-posta", text: $email)
                TextField("Öğrenci Numarası", text: $studentNumber)
            }
            
            Section(header: Text("Profil Resmi")) {
                profileImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .padding()
                
                Button(action: {
                    showingImagePicker = true

                }) {
                    Text("Resim Yükle")
                }
            }
            
            Section {
                Button(action: {
                    // Bilgileri kaydetme işlemi
                }) {
                    Text("Bilgileri Kaydet")
                }
            }
        }
        .navigationTitle("Profil")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

//struct ProfileView_Previews: PreviewProvider {
    //static var previews: some View {
        //ProfileView()
   // }
//}

