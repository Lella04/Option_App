
import SwiftUI
import Combine

struct BluetoothView: View {
    @ObservedObject var bluetooth = Settings()

    var body: some View {
        return NavigationLink(destination: ToggleBluetoothView(bluetooth: bluetooth)) {
            HStack() {
                ZStack{
                    Rectangle().frame(width: 35, height: 35).foregroundColor(.blue).cornerRadius(10)
                    Image("bluetooth").resizable().frame(width: 25, height: 25)
                    
                    
                }
                
                
                Text("Bluetooth")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 150,height: 40, alignment: .leading)
                Text(bluetooth.isBluetoothOn ? "On" : "Off")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .font(.subheadline)
                    .frame(width: 170, height: 40, alignment: .trailing).offset(x: -70)
            }
        }
    }
}

struct ToggleBluetoothView: View {
   @ObservedObject var bluetooth: Settings
    
    var body: some View {
        Form {
            Section(header: Text("ENABLE TO CONNECT WITH NEARBY DEVICES")) {
                Toggle(isOn: $bluetooth.isBluetoothOn) {
                    Text("Bluetooth")
                    }
            
                if bluetooth.isBluetoothOn {
                    HStack {
                    Text("Searching for nearby devices...")
                    .foregroundColor(.gray)
                    .font(.system(size: 18))
                    .font(.system(.subheadline))
                    ActivityIndicator(style: .medium)
                    }
                }
            }
        }
    }
}

#Preview{
    BluetoothView()
}
