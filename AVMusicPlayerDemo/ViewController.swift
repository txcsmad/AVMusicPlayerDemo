//
//  ViewController.swift
//  AVMusicPlayerDemo
//
//  Created by Matthew Ruston on 4/11/17.
//  Copyright © 2017 MattRuston. All rights reserved.
//

import UIKit
import AVFoundation

var BarrelRollSound: SystemSoundID = 0
var ErrorSound: SystemSoundID = 0

class ViewController: UIViewController {
    
    var players: [AVAudioPlayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerSounds()
    }
    
    
    //MARK: - Using AVAudioPlayer
    
    func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }
        
        let player = try! AVAudioPlayer(contentsOf: url)
        player.delegate = self
        players.append(player)
        player.play()
    }
    
    @IBAction func playCoin() {
        playSound(fileName: "Mario-coin-sound")
    }
    
    @IBAction func playHorn() {
        playSound(fileName: "AIRHORN")
    }
    
    @IBAction func playNavi() {
        playSound(fileName: "hey_listen")
    }
    
    @IBAction func playInception() {
        playSound(fileName: "inceptionhorn")
    }
    
    
    // MARK: - Using System Sounds
    
    func registerSounds() {
        if let songUrl = Bundle.main.url(forResource: "Barrel Roll", withExtension: "mp3") as CFURL? {
            AudioServicesCreateSystemSoundID(songUrl, &BarrelRollSound)
        }
        
        if let songUrl = Bundle.main.url(forResource: "error", withExtension: "mp3") as CFURL? {
            AudioServicesCreateSystemSoundID(songUrl, &ErrorSound)
        }
    }
    
    @IBAction func playBarrelRoll() {
        AudioServicesPlaySystemSound(BarrelRollSound)
    }
    
    @IBAction func playError() {
        AudioServicesPlaySystemSound(ErrorSound)
    }

}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for x in 0..<players.count {
            if players[x] == player {
                players.remove(at: x)
                return
            }
        }
    }
}

