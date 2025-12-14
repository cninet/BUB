//
//  Info.swift
//  BUB
//
//  Created by CHOTIWAT TANGSATHAPHORN on 3/2/23.
//

import SwiftUI

struct location: Identifiable {
    let id = UUID()
    var name: String
 }

var locations = [
    location(name: "Apple Central World"),
    location(name: "Chulalongkorn University"),
    location(name: "Siam Paragon")
]

struct Info: View { //Open Struct
    var body: some View { //Open Body
        NavigationView{ //Open NavView
            ScrollView{ //Open ScrollView
                VStack{ //Open VStack 1
                    VStack{ //Open VStack 2
                        Text("How to use")
                            .font(.system(size:40))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,10)
                        Text("Currently, This application supports **3** locations.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,10)
                        List{
                            ForEach(locations) { location in
                                Text(location.name)
                            }
                        }.frame(minHeight: 200, maxHeight: 200)
                        Text("Step 1")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top,.leading],10)
                        Text("Tap the microphone button on the middle of the screen to record your voice.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.bottom,.leading],10)
                        Text("Step 2")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top,.leading],10)
                        Text("When you finished speaking, tap the microphone button again to process your voice. Please wait up to 5 seconds.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.bottom,.leading],10)
                        Text("Step 3")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top,.leading],10)
                        Text("If the location exists, the map will be shown and you will be told when the bus will arrive.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.bottom, .leading],10)
                    } //Close VStack 2
                    Spacer()
                    Text("This application is made for blind people.")
                        .foregroundColor(.cyan)
                    Text("WWDC Swift Student Challenge 2023.")
                        .foregroundColor(.cyan)
                        .padding(.bottom,5)
                    Text("CHOTIWAT TANGSATHAPHORN")
                        .foregroundColor(.cyan)
                        .fontWeight(.bold)
                        .padding(.bottom,50)
                } //Close VStack 1
            }.frame(maxHeight: .infinity) //Close Scroll View
        } //Close NavView
        .navigationTitle("Info")
    } //Close Body
} //Close Struct

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
