//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Karthik Kannan on 3/16/15.
//  Copyright (c) 2015 Karthik Kannan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recodingLabel.text = "Tap microphone to record"
        recordButton.enabled = true
        
    }

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var recodingLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    @IBAction func recordAudio(sender: UIButton) {
        println("Action recordAudio")
        //Show "Recording in progress..." message
        recodingLabel.text = "Recording in progress..."
        stopButton.hidden = false
       
        //Record audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        
        //delegate set to get information on the audioRecorder
        audioRecorder.delegate = self
        
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        recordButton.enabled = false;
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            //Success Finished recording
            println("func audioRecorderDidFinishRecording -- Recording was Successful")
            recordedAudio = RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent!)
            
            //Using segue - stopRecording, transition to PlaySoundViewController. The recorded is passed.
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            // Error during recording
            println("func audioRecorderDidFinishRecording -- Recording was NOT successful")
            recordButton.enabled = true;
            stopButton.hidden = true
            recodingLabel.text = "Recording Failed."
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSound:PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
            playSound.recordedAudio = sender as RecordedAudio
            
        }
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        println("func stopRecording")
        audioRecorder.stop()
        recordButton.enabled = true;
        recodingLabel.hidden = false;
        recodingLabel.text = "Tap microphone to record"
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }

}

