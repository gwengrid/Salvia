//
//  HeadViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/13/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

class HeadViewController: UIViewController {

    @IBOutlet weak var happyFace: UIImageView!
    @IBOutlet weak var happyText: UILabel!

    private let intentionSpace: IntentionViewController
    private var headstate: Headstate = .Empty {
        didSet {
            self.happyFace.image = headstate == .Empty ? UIImage(asset: .Serene) : UIImage(asset: .Congrats)
            self.happyText.text = headstate == .Empty ? "Nothing to do today." : "Enjoy the rest of your day!"
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("why are you here? in any case, here's a nice quote: there is nothing more beautiful than the way the ocean refuses to stop kissing th shoreline, no matter how many times it's sent away")
    }

    required init(intent: IntentionViewController) {
        self.intentionSpace = intent
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headstate = intentionSpace.focus != nil ? .Available : .Empty
    }
}
