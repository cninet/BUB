//
//  RouteView.swift
//  BUB
//
//  Created by CHOTIWAT TANGSATHAPHORN on 28/1/23.
//
//

import SwiftUI
import AVFoundation

struct RouteView: View { //Open Struct
    //Fullscreen Cover
    @Environment(\.dismiss) var dismiss
    
    //Detect Color Scheme
    @Environment(\.colorScheme) var colorScheme
    
    //Audio Player
    let mySpeechUtterance = AVSpeechUtterance()
    let mySpeechSynthesizer = AVSpeechSynthesizer()
    
    func speak(Text: String){ //Open Function Speak
        let mySpeechUtterance = AVSpeechUtterance(string: Text)
        mySpeechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        mySpeechUtterance.rate = 0.575
        mySpeechSynthesizer.speak(mySpeechUtterance)
    } //Close Function Speak
    
    @State var audioPlayer: AVAudioPlayer?
    
    func soundeff(sound: String){
        let effPath = Bundle.main.path(forResource: (sound), ofType: "mp3")
        let effURL = URL(fileURLWithPath: effPath!)
        self.audioPlayer = try! AVAudioPlayer(contentsOf: effURL)
        self.audioPlayer?.play()
    }
    
    //Variables
    @Binding var selectRoute: String
    @Binding var processing: Bool
    @State var busline = 0
    @AppStorage("voiceAnnouncement") var voiceAnnouncement = true
    
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var countToZero = 5

    //Main
    var body: some View { //Open Body
        
        VStack{ //Open VStack
            Text("Bus Route")
                .font(.system(size:50))
                .fontWeight(.black)
            
            //Head Screen
            if selectRoute.caseInsensitiveCompare("Chulalongkorn University") == .orderedSame || selectRoute.caseInsensitiveCompare("Apple Central World") == .orderedSame || selectRoute.caseInsensitiveCompare("Siam Paragon") == .orderedSame{ //Open if location
                Text("Your destination is __\(selectRoute)__.")
                
                Text("Bus line: __\(busline)__")
                    .onAppear{
                        
                        if voiceAnnouncement{
                            speak(Text: "Your bus is line \(busline). It takes about \(timeRemaining) seconds until the bus arrives. Your destination is \(selectRoute). There will have sound notify you every 10 seconds. To end the route, tap END at the bottom of the screen to return to the main page.")
                        }
                        
                    }
                if timeRemaining > 1{
                    Text("It takes about **\(timeRemaining)** seconds until the bus arrives.")
                        .onReceive(timer){ time in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            }
                            if (timeRemaining%10) == 0{
                                soundeff(sound: "time")
                            }
                            if timeRemaining == countToZero{
                                soundeff(sound: "time")
                                countToZero -= 1
                            }
                        }
                }else if timeRemaining == 1{
                    Text("It takes about **\(timeRemaining)** second until the bus arrives.")
                        .onReceive(timer){ time in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            }
                        }
                }else if timeRemaining == 0{
                    Text("The bus is arriving.")
                        .font(.headline)
                        .onAppear{if voiceAnnouncement{speak(Text: "The bus is arriving.")}}
                }
                
                
                
                //Chulalongkorn University
                if selectRoute.caseInsensitiveCompare("Chulalongkorn University") == .orderedSame{ //Open if Chula
                    ZStack{ //Open ZStack Chula
                        if timeRemaining != 0{
                            if colorScheme == .light{
                                Image("Chula Wait")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }else{
                                Image("Chula Wait Dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }
                        } else if timeRemaining == 0{
                            if colorScheme == .light{
                                Image("Chula Arrive")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }else{
                                Image("Chula Arrive Dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }
                        }
                    } //Close ZStack Chula
                } //Close if Chula
                
                
                
                
                //Apple Central World
                else if selectRoute.caseInsensitiveCompare("Apple Central World") == .orderedSame{ //Open if Apple
                    ZStack{ //Open ZStack Apple
                        if timeRemaining != 0{
                            if colorScheme == .light{
                                Image("Apple Wait")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }else{
                                Image("Apple Wait Dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }
                        } else if timeRemaining == 0{
                            if colorScheme == .light{
                                Image("Apple Arrive")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }else{
                                Image("Apple Arrive Dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }
                        }
                    } //Close ZStack Apple
                } //Close if Apple
                
                
                
                
                //Siam Paragon
                else if selectRoute.caseInsensitiveCompare("Siam Paragon") == .orderedSame{ //Open if Siam Paragon
                    ZStack{ //Open ZStack Siam Paragon
                        if timeRemaining != 0{
                            if colorScheme == .light{
                                Image("Siam Paragon Wait")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                                    
                            }else{
                                Image("Siam Paragon Arrive Dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }
                        } else if timeRemaining == 0{
                            if colorScheme == .light{
                                Image("Siam Paragon Arrive")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }else{
                                Image("Siam Paragon Arrive Dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 10)
                            }
                        }
                    } //Close ZStack Siam Paragon
                } //Close if Siam Paragon
            } // Close if location
            
            
            
            //No Result
            else if selectRoute == "" { //Open If None
                Spacer()
                Text("Unable to recognize your voice.")
                    .font(.system(size:25))
                Text("Please try again.")
                    .font(.system(size:25))
                    .onAppear{ //Open OnAppear
                        timeRemaining = 3
                        if voiceAnnouncement{
                            speak(Text: "Unable to recgonize your voice. Please try again.")
                        }
                    } //Close OnAppear
                    .onReceive(timer){ time in //Open OnReceive
                        if timeRemaining > 0 { //Open If time > 0
                            timeRemaining -= 1
                        } //Close If time > 0
                        if timeRemaining == 0 { //Open If time = 0
                            dismiss()
                            processing = false
                        } //Close If time > 0
                    } //Close OnReceive
                
            } //Close If None
            
            
            
            //Unable to detect voice
            else{ //Open Else
                Spacer()
                Text("Unable to find the route to")
                    .font(.system(size: 25))
                Text("__\(selectRoute)__\n")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Please try again.")
                    .font(.system(size: 25))
                    .onAppear{ //Open OnAppear
                        timeRemaining = 4
                        if voiceAnnouncement{
                            speak(Text: "Unable to find the route to \(selectRoute). Please try again.")
                        }
                    } //Close OnAppear
                    .onReceive(timer){ time in //Open OnReceive
                        if timeRemaining > 0 { //Open If time > 0
                            timeRemaining -= 1
                        } //Close If time > 0
                        if timeRemaining == 0 { //Open If time = 0
                            dismiss()
                            processing = false
                        } //Close If time = 0
                    } //Close OnReceive
                
            } //Close Else
            Spacer()
            
            
            //END Button
            Button(action: {
                soundeff(sound: "click")
                dismiss()
                processing = false
            }){ //Open Button
                Text("End")
                    .fontWeight(.bold)
                    .frame(width: 300, height: 50)
                    .background(.cyan)
                    .foregroundColor(.black)
                    .cornerRadius(20)
            } //Close Button
        } //Close VStack
        .onAppear{
            if selectRoute.caseInsensitiveCompare("Apple Central World") == .orderedSame || selectRoute.caseInsensitiveCompare("Siam Paragon") == .orderedSame{ //Open if location
                self.busline = 54
            }else if selectRoute.caseInsensitiveCompare("Chulalongkorn University") == .orderedSame{
                self.busline = 36
            }
        }
        .onDisappear{ //Open OnDisappear
            if voiceAnnouncement{
                speak(Text: "Where do you want to go?")
            }
        } //Close OnDisappear
    } //Close Body
} //Close Struct

