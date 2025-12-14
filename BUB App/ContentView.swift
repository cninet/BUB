import SwiftUI
import AVFoundation

struct ContentView: View { //Open Struct
    
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
    
    @State var speech = ""
    
    
    
    //Get Voice
    func getAudios(){
        do{
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            self.audios.removeAll()
            for i in result{
                self.audios.append(i)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    

    
    //Variables
    @State var showRouteView = false
    @State var selectRoute = ""
    @State var processing = false
    @AppStorage("voiceAnnouncement") var voiceAnnouncement = true
    
    
    
    //Recorder
    @State var record = false
//    @State var session: AVAudioSession!
    @State var recorder: AVAudioRecorder!
    @State var audios : [URL] = []
    
    
    
    //Time Countdown
    @State var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    
    //Main Body
    var body: some View { //Open Body
        NavigationView{ //Open NavView
            VStack { //Open VStack
                Text("Bus Route")
                    .font(.system(size: 50))
                    .fontWeight(.black)
                Text("Where do you want to go?")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                if !self.processing{ //Open If Processing
                    Button(action: { //Open Action
                        do{ //Open do
                            soundeff(sound: "click")
                            
                            
                            
                            //Stop Audio Recording Part
                            if self.record{
                                    self.recorder.stop()
                                    self.record = false
                                    self.getAudios()
                                
                                    requestPermission{ result in
                                        speech = result
                                    }
                                    
                                    self.processing.toggle()
                                    timeRemaining = 5
                                    if voiceAnnouncement{
                                        speak(Text: "Processing, please wait up to 5 seconds. To cancel the process, tap END at the bottom of the screen.")
                                    }
                                //Get Path to the file.
                                    print("\nFile located:")
                                print(getPathRecorder()!)
                                    return()
                            }
                            
                            
                            
                            //Record Audio Part
                            let session = AVAudioSession.sharedInstance()
                            try! session.setCategory(.playAndRecord, mode: .default)
                            try session.setActive(true)
                            session.requestRecordPermission { granted in
                                print("\nRecord Permission:")
                                print(granted)
                            }
                            
                            
                            //Set Path and Setting for Recording
                            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
                            let fileName = url.appendingPathComponent("voice.m4a")
                            let settings = [
                                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                AVSampleRateKey: 48000,
                                AVNumberOfChannelsKey: 1,
                                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                            ]
                            
                            
                            //Recording Audio
                            self.recorder = try AVAudioRecorder(url: fileName, settings: settings)
                            self.recorder.record()
                            print("\nIs Recording:")
                            print(self.recorder.isRecording)
                            self.record = true
                        } catch { // Close do & Open catch
                            print(error.localizedDescription)
                        } //Close Catch
                    }) //Close Action
                    { //Open Button
                        ZStack{ //Open ZStack
                            Text(.init(systemName: "mic.circle.fill"))
                                .font(.system(size: 300))
                                .fontWeight(.bold)
                                .accessibility(label: Text("Microphone"))
                            if self.record{ //If Recording, show circle around the button
                                Circle()
                                    .stroke(.red, lineWidth: 15)
                                    .frame(width: 350, height: 350)
                            }
                        } //Close ZStack
                    } //Close Button
                    
                    
                    
                //Processing Screen (Content)
                } else if processing{ //Close If Processing & Open Else Processing
                    Text("Processing...")
                        .font(.system(size: 50))
                        .onReceive(timer){ time in //Open OnRecieve
                            if timeRemaining > 0{
                                timeRemaining -= 1
                            }
                            if timeRemaining == 0{
                                self.showRouteView.toggle()
                                self.selectRoute = "\(speech)"
                                timeRemaining = -1 //Stop Loop Show RouteView
                            }
                        } //Close OnRecieve
                } //Close Else Processing
                Spacer()
                    .fullScreenCover(isPresented: $showRouteView){
                        RouteView(selectRoute: $selectRoute, processing: $processing)
                    }
                
                
                //Main Screen
                if !self.processing{
                    VStack{ //Open VStack
                        Toggle("Voice Annoucement", isOn: $voiceAnnouncement)
                            .padding([.leading,.trailing],75)
                        
                        NavigationLink(destination: Info()){ //Open NavLink
                            HStack{ //Open HStack
                                Text(Image(systemName: "info.circle.fill"))
                                    .font(.system(size:30))
                                Text("About this application")
                            } //Close HStack
                    } //Close VStack
                    } //Close NavLink
                    
                    
                //Processing Screen
                }else{
                    Button(action: {
                        soundeff(sound: "click")
                        processing = false
                    }){ //Open Button
                        Text("End")
                            .fontWeight(.bold)
                            .frame(width: 300, height: 50)
                            .background(.cyan)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    } //Close Button
                }
            } //Close VStack
        } //Close NavView
        .onAppear{ //Open OnAppear
            if voiceAnnouncement{ //Open VoiceAnnouncement
                speak(Text: "Where do you want to go? Tap the microphone button on the middle of the screen and then state your destination. After you're done tap the button again, then wait for processing.")
            } //Close VoiceAnnouncement
        } //Close OnAppear
    } //Close Body
} //Open Struct

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
