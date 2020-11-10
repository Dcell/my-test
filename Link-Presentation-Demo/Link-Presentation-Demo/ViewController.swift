//
//  ViewController.swift
//  Link-Presentation-Demo
//
//  Created by mac_25648_newMini on 2020/11/10.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let metadataProvider = LPMetadataProvider()
        let url = URL(string: "https://www.apple.com/ipad")!

        metadataProvider.startFetchingMetadata(for: url) { metadata, error in
            if error != nil {
                // The fetch failed; handle the error.
                return
            }
            if let metadata = metadata {
                DispatchQueue.main.async {
                    let linkView = LPLinkView(metadata: metadata)
                    linkView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                    self.view.addSubview(linkView)
                    linkView.sizeToFit()
                }
            }

            // Make use of fetched metadata.
        }
        

        // Do any additional setup after loading the view.
    }


}

