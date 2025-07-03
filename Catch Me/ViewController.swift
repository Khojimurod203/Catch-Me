//
//  ViewController.swift
//  Catch Me
//
//  Created by Kojimurod Omonkulov on 03/04/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var girl: UIImageView!
    @IBOutlet weak var boy: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // allow to tap
        girl.isUserInteractionEnabled = true
        boy.isUserInteractionEnabled = true
       
        let recognizerG = UITapGestureRecognizer(target: self, action: #selector(nextViewG))
        let recognizerB = UITapGestureRecognizer(target: self, action: #selector(nextViewB))
        
        girl.addGestureRecognizer(recognizerG)
        boy.addGestureRecognizer(recognizerB)
        
        
        
        
        
      
       
    

    } //-->end of override func
    
      /// next Window
    @objc func nextViewG(){
        performSegue(withIdentifier: "toGirlVC", sender: nil)
    }
    
    //next Window
   @objc func nextViewB(){
       performSegue(withIdentifier: "toBoyVC", sender: nil)
    }

    
    
    
}

