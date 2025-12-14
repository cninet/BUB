# 🚌 BUB: Bus Route for the Blind
> 🏆 **WWDC23 Swift Student Challenge Winner**

**BUB** is an accessible iOS application designed to assist visually impaired users in navigating public bus routes in Bangkok. This project was engineered to solve real-world accessibility challenges through intuitive voice interaction and auditory feedback.

🔗 **View the submission on WWDCScholars:** [Click Here](https://www.wwdcscholars.com/s/70D27184-8A46-4592-AC93-B96585299647/2023)

## 🛠 Tech Stack
* **Language:** Swift
* **UI Framework:** SwiftUI
* **Key Frameworks:** AVFoundation, Speech, CoreLocation
* **Architecture:** Offline-first (Simulation Logic)

## 🧩 Project Constraints & Logic
Due to the **WWDC Swift Student Challenge** rules restricting internet access during judging, this app was designed with a **Simulated Navigation System**.
* It does not fetch real-time GPS data.
* Instead, it simulates location changes and map information based on actual bus route data in Bangkok to demonstrate the app's logic and accessibility features within the submission environment.

## 📱 How to Test / Demo
The app currently supports simulation for three specific landmarks in Bangkok:
1.  **Apple Central World**
2.  **Siam Paragon**
3.  **Chulalongkorn University**

### Voice Command Instructions
To interact with the app, please use voice commands:
* You can speak the destination name clearly (e.g., *"Siam Paragon"*).
* Alternatively, you can play the recorded voice samples located in the **[`/DemoResources`](./DemoResources)** folder:
  * 🔊 [Apple Central World](./DemoResources/Apple%20Central%20World.mp3)
  * 🔊 [Chulalongkorn University](./DemoResources/Chulalongkorn%20University.mp3)
  * 🔊 [Siam Paragon](./DemoResources/Siam%20Paragon.mp3)

> **Note:** If you encounter a speech recognition error after granting Microphone and Speech permissions for the first time, please try speaking again.

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
