/**
 * Copyright IBM Corporation 2016
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
import SpeechToTextV1

class MicrophoneViewController: UIViewController {

    var speechToText: SpeechToText!
    var isStreaming = false
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechToText = SpeechToText(
            username: Credentials.SpeechToTextUsername,
            password: Credentials.SpeechToTextPassword
        )
    }
    
    @IBAction func didPressMicrophoneButton(_ sender: UIButton) {
        if !isStreaming {
            microphoneButton.setTitle("Stop Microphone", for: .normal)
            isStreaming = true
            var settings = RecognitionSettings(contentType: .wav)
            settings.continuous = true
            settings.interimResults = true
            let failure = { (error: Error) in print(error) }
            speechToText.recognizeMicrophone(settings: settings, compress: false, failure: failure) {
                results in
                self.textView.text = results.bestTranscript
            }
        } else {
            microphoneButton.setTitle("Start Microphone", for: .normal)
            isStreaming = false
            speechToText.stopRecognizeMicrophone()
        }
    }
}
