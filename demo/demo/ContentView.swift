
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        NavigationLink(destination: ProfileView()) {
                            MenuOption(title: "Profil", icon: "person.crop.circle")
                        }
                        
                        NavigationLink(destination: NatificationView()) {
                            MenuOption(title: "Bildirimler", icon: "bell.circle")
                        }
                        
                        NavigationLink(destination: GPADetailView()) {
                            MenuOption(title: "GANO", icon: "graduationcap.circle")
                        }
                        
                        NavigationLink(destination: AttendanceDetailView()) {
                            MenuOption(title: "Devamsızlık", icon: "calendar.circle")
                        }

                        
                        NavigationLink(destination: BalanceDetailView()) {
                            MenuOption(title: "Güncel Bakiye", icon: "creditcard.circle")
                        }
                        
                        NavigationLink(destination: MealDetailView()) {
                            MenuOption(title: "Bugünkü Yemek", icon: "fork.knife.circle")
                        }
                    }
                    .padding()
                }
                
                Button(action: {
                    authViewModel.logout()
                }) {
                    Text("Çıkış Yap")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Ana Sayfa")
        }
    }

}

struct MenuOption: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .padding(.trailing, 10)
            
            Text(title)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 5)
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

