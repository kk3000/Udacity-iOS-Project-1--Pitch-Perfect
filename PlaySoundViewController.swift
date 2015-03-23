//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Karthik Kannan on 3/16/15.
//  Copyright (c) 2015 Karthik Kannan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recordedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        //when tortoise is pressed
       playAudio(0.5)
        
    }
    
    @IBAction func playFastSound(sender: UIButton) {
        //when rabbit is pressed
        playAudio(2.0)
        
    }
    
    
    @IBAction func playChimunkSound(sender: AnyObject) {
        //when chipmunk is pressed
        playSoundWithDifferentPitch(1000)
    }
    
    
    @IBAction func playDarthWaderSound(sender: AnyObject) {
        //When Darthwader is pressed
        playSoundWithDifferentPitch(-1000)
    }
    
    
    func playSoundWithDifferentPitch (var pitch:Float){
        //Function to play soundwith different pitch
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
     
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func playAudio(var rate:Float){
        //Play audio at different speeds/rate
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
}
