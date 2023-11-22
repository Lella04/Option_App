
import SwiftUI

struct WiFiView : View {
    @ObservedObject var wifi: Settings
    
    var body: some View {
        Group() {
            Picker(selection: $wifi.type, label: WifiContainer()) {
                ForEach(0 ..< wifi.types.count) {
                    Text(self.wifi.types[$0]).tag($0).font(.system(size: 20))
                }
            }
            if wifi.type == 1 {
                HStack {
                    Text("SEARCHING FOR A NETWORK...")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .font(.system(.subheadline))
                    ActivityIndicator(style: .medium)
                }
            }
        }
    }
}

//WiFiView.swift
struct WifiContainer: View {
    var body: some View {
        HStack {
            ZStack{
                Rectangle().frame(width: 35, height: 35).foregroundColor(.blue).cornerRadius(10)
                Image(systemName: "wifi").foregroundColor(.white).font(.system(size: 18))
                
                
            }
            Text("WiFi")
                .foregroundColor(.black)
                .font(.system(size: 18))
        }
    }
}

    

