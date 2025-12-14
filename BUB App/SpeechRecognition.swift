//
//  SpeechRecognition.swift
//  BUB
//
//  Created by CHOTIWAT TANGSATHAPHORN on 28/1/23.
//

import Speech
import Foundation

func getPathRecorder() -> URL?{
    guard
        let path = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("voice.m4a") else{
        print("Error getting path.")
        return nil
    }
    return path
}

func requestPermission(completion: @escaping (String) -> Void){
    SFSpeechRecognizer.requestAuthorization{ authStatus in
        if authStatus == .authorized{
            if let path = getPathRecorder()?.path, FileManager.default.fileExists(atPath: path){
                recognizeAudio(url: URL(fileURLWithPath: path), completion: completion)
            }
        }else{
            print("Speech Failed")
        }
    }
}

func recognizeAudio(url: URL, completion: @escaping (String) -> Void){
    let recognizer = SFSpeechRecognizer()
    let request = SFSpeechURLRecognitionRequest(url: url)
    recognizer?.recognitionTask(with: request, resultHandler: {
        result, error in
        guard let result = result else{
//            print("\(result)")
            print("No results for recognition")
            return
        }
        completion(result.bestTranscription.formattedString)
    })
}
