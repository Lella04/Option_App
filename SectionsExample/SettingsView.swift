
import SwiftUI
import Combine

struct SettingsView : View {
    @ObservedObject var setting = Settings()
@State var bottonplane = false
    @State var mobiledata = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    SignInView()
                }
                Section {
                    HStack{
                        ZStack{
                            Rectangle().frame(width: 35, height: 35).foregroundColor(.orange).cornerRadius(10)
                            Image(systemName: "airplane").foregroundColor(.white).font(.system(size: 18))
                            
                            
                        }
                        
                        Text("Airplane Mode")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(width: 150,height: 40, alignment: .leading)
                        Toggle(isOn: $bottonplane) {
                            
                            
                        }
                    }
                    WiFiView(wifi: setting)
                    BluetoothView().offset(x: 38)
                    
                    HStack{
                        ZStack{
                            Rectangle().frame(width: 35, height: 35).foregroundColor(.green).cornerRadius(10)
                            Image(systemName: "antenna.radiowaves.left.and.right").foregroundColor(.white).font(.system(size: 18))
                            
                            
                        }
                        Text("Mobile Data")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(width: 150,height: 40, alignment: .leading)
                        Toggle(isOn: $mobiledata) {
                            
                            
                        }
                    }
                }
                ForEach(Option.options,id: \.id) { settingOption in
                    OptionRow(option: settingOption)
                        
                }
                
            }
            .navigationBarTitle(Text("Settings")).font(.largeTitle)
        }
    }
}

struct OptionRow: View {
    let option: Option
    var body: some View {
        Group() {
            if option.isAddSection {
                Section {
                    OptionSettingsView(option: option)
                    
                }
            } else {
                OptionSettingsView(option: option)
            }
        }
    }
}


struct OptionSettingsView : View {
    let option: Option
    
    var body: some View {
        return NavigationLink(destination: OptionInnerDetail(option: option)) {
            HStack {
                ZStack{
                    Rectangle().frame(width: 35, height: 35).foregroundColor(Color(hex: option.squareColorString)).cornerRadius(10)
                    Image(systemName: option.imagename)
                        .foregroundColor(.white).font(.system(size: 18))
                }
                
                Text(option.title)
                    .foregroundColor(.black)
                    .font(.system(size: 18))
            }
        }
    }
}




struct OptionInnerDetail: View {
    let option: Option
    var body: some View {
        Form {
            ForEach(option.values,id: \.title) { valuesOption in
                OptionInnerView(value: valuesOption)
            }
        }
        .navigationBarTitle(Text(option.title), displayMode: .inline)
    }
}

struct OptionInnerView: View {
    let value: InnerOptionValues
    var body: some View {
        Group() {
            if value.isAddSection && !value.isUseToggle {
                Section(header: Text(value.headerTitle)) {
                    InnerView(value: value)
                }
            } else if !value.isAddSection && value.isUseToggle {
                ToggleView(value: value)
            } else if value.isAddSection && value.isUseToggle {
                Section(header: Text(value.headerTitle)) {
                    ToggleView(value: value)
                }
            } else {
                InnerView(value: value)
            }
        }
    }
}



struct ToggleView: View {
    let value: InnerOptionValues
    @ObservedObject var toggle = Settings()
    
    var body: some View {
        HStack {
            Image("default")
                .resizable()
                .cornerRadius(12)
                .frame(width: 25, height: 25)
                .clipped()
                .aspectRatio(contentMode: .fit)
            
            Toggle(isOn: $toggle.isToggleOn) {
                Text(value.title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}

struct InnerView: View {
    let value: InnerOptionValues
    
    var body: some View {
        return NavigationLink(destination: EndView(value: value)) {
            HStack {
                Image("default")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 25, height: 25)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                Text(value.title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}



struct EndView: View {
    let value: InnerOptionValues
    
    var body: some View {
        return NavigationLink(destination: EndView(value: value)) {
            
            Text("Coming Soon!!!")
                .font(.system(size: 25))
                .foregroundColor(.blue)
        } .navigationBarTitle(Text(value.title), displayMode: .inline)
    }
}

#Preview{
    SettingsView()
}
