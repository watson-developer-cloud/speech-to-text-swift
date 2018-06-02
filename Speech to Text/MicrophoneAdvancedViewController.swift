/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import AVFoundation
import SpeechToTextV1

/// This file demonstrates an advanced configuration using the `SpeechToTextSession` class.
class MicrophoneAdvancedViewController: UIViewController {

    var session: SpeechToTextSession!
    var settings: RecognitionSettings!
    var isSessionStarted = false
    var isStreaming = false
    var accumulator = SpeechRecognitionResultsAccumulator()

    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // use `SpeechToTextSession` for advanced configuration
        session = SpeechToTextSession(
            username: Credentials.SpeechToTextUsername,
            password: Credentials.SpeechToTextPassword
        )

        // define recognition session callbacks
        session.onConnect = { print("connected") }
        session.onDisconnect = { print("disconnected") }
        session.onError = { error in print(error) }
        session.onPowerData = { decibels in print(decibels) }
        session.onMicrophoneData = { data in print("received data") }
        session.onResults = {
            results in
            self.accumulator.add(results: results)
            self.textView.text = self.accumulator.bestTranscript
        }

        // define recognition settings
        settings = RecognitionSettings(contentType: "audio/ogg;codecs=opus")
        settings.interimResults = true
        settings.inactivityTimeout = -1

        // request microphone permission
        requestMicrophonePermission()
        
        // configure audio session
        configureAudioSession()
    }

    /// The `SpeechToTextSession` class will automatically request access to the microphone when
    /// it is needed. But some apps may prefer to request microphone permission in advance.
    func requestMicrophonePermission() {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            print("audio capture permission granted: \(granted)")
        }
    }
    
    /// Depending on your application's requirements, you might need to configure the default
    /// audio session to play nicely with other audio sources. For example, this function
    /// configures the session to default to the speaker (instead of headphones) and mix
    /// with audio from other apps rather than stopping playback when recording starts.
    func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [.defaultToSpeaker, .mixWithOthers])
            try audioSession.setActive(true)
        } catch {
            print("Failed to setup the AVAudioSession.")
        }
    }

    @IBAction func didPressSessionButton(_ sender: UIButton) {
        if !isSessionStarted {
            isSessionStarted = true
            sessionButton.setTitle("Stop Session", for: .normal)
            session.connect()
            session.startRequest(settings: settings)
        } else {
            isSessionStarted = false
            isStreaming = false
            sessionButton.setTitle("Start Sesson", for: .normal)
            microphoneButton.setTitle("Start Microphone", for: .normal)
            session.stopMicrophone()
            session.stopRequest()
            session.disconnect()
        }
    }

    @IBAction func didPressMicrophoneButton(_ sender: UIButton) {
        if !isStreaming && isSessionStarted {
            isStreaming = true
            microphoneButton.setTitle("Stop Microphone", for: .normal)
            session.startMicrophone()
        } else {
            isStreaming = false
            microphoneButton.setTitle("Start Microphone", for: .normal)
            session.stopMicrophone()
        }
    }
}

