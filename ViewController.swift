//
//  ViewController.swift
//  finaleffect1
//
//  Created by Jillian Donahue on 4/22/18.
//  Copyright © 2018 Jillian Donahue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PdListener {

    //MARK: Properties
    
    @IBOutlet weak var speed_label: UILabel!
    @IBOutlet weak var maxfreq_label: UILabel!
    @IBOutlet weak var minfreq_label: UILabel!
    @IBOutlet weak var q_label: UILabel!
    
    
    let pd = PdAudioController()
    let dispatcher = PdDispatcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fluid-wallpaper.jpg")!)
        let pdInit = pd.configurePlayback(withSampleRate: 44100,
                                          numberChannels: 2, inputEnabled: true, mixingEnabled:
            false)
        guard pdInit == PdAudioOK else { // 0 for success
            fatalError("Error, could not instantiate pd audio engine")
        }
        dispatcher.add(self, forSource: "vibrato")
        PdBase.setDelegate(dispatcher)

        let pdPatch = "WahWah.pd"
        guard PdBase.openFile(pdPatch, path:
            Bundle.main.resourcePath) != nil else{
                fatalError("Failed to open the patch \(pdPatch)")
        }
        pd.isActive = true // The pd engine status is active!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func lfo(_ sender: UISlider) {
        PdBase.send(sender.value, toReceiver: "lfo_wahwah")
        speed_label.text = String(format: "Speed %.2f", sender.value)
    }
    
    @IBAction func maxfreq(_ sender: UISlider) {
        PdBase.send(sender.value, toReceiver: "max_wahwah")
        maxfreq_label.text = String(format: "Maximum Frequency %.2f", sender.value)
    }
    
    @IBAction func minfreq(_ sender: UISlider) {
        PdBase.send(sender.value, toReceiver: "min_wahwah")
        minfreq_label.text = String(format: "Minimum Frequency %.2f", sender.value)
    }

    @IBAction func q(_ sender: UISlider) {
        PdBase.send(sender.value, toReceiver: "Q_wahwah")
        q_label.text = String(format: "Q %.2f", sender.value)
    }

}

