//
//  PGDActionView.swift
//  ActionWidget
//
//  Created by Emilio Cubo Ruiz on 13/7/17.
//  Copyright © 2017 Grupo Go Optimizations, SL. All rights reserved.
//

import UIKit

public class PGDActionView: UIView {
    
    // MARK: Outlets
    @IBOutlet fileprivate var contentView:UIView?
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionPlatformView: UIView!
    @IBOutlet weak var actionPlatform: UILabel!
    @IBOutlet weak var actionType: UILabel!
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var actionPledges: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var actionDetailButtonImage: UIImageView!
    @IBOutlet weak var actionDetailButton: UIButton!
    @IBOutlet weak var actionTitleDetail: UILabel!
    @IBOutlet weak var actionDescription: UITextView!
    @IBOutlet weak var actionShareButtonImage: UIImageView!
    
    
    var fillRatingImage = UIImage(named: "fill", in: Bundle(for: PGDActionView.self), compatibleWith: nil)
    var outlineRatingImage = UIImage(named: "outline", in: Bundle(for: PGDActionView.self), compatibleWith: nil)
    var zoomOutImage = UIImage(named: "zoom_out", in: Bundle(for: PGDActionView.self), compatibleWith: nil)
    
    var zoomInImage: UIImage = UIImage(named: "zoom_in", in: Bundle(for: PGDActionView.self), compatibleWith: nil)! {
        didSet {
            layoutSubviews()
        }
    }
    
    var shareImage: UIImage = UIImage(named: "share", in: Bundle(for: PGDActionView.self), compatibleWith: nil)! {
        didSet {
            layoutSubviews()
        }
    }
    
    var action: Action? {
        didSet {
            if let action = action {
                
                if action.platform.lowercased() != "" && action.platform.lowercased() != "webintra" {
                    actionPlatform.text = action.platform.uppercased()
                } else {
                    actionPlatformView.isHidden = true
                }
                
                var actionButtonTile:String = ""
                switch action.type.lowercased() {
                case "Signatures for change".lowercased():
                    actionButtonTile = "Sign"
                case "Free Training".lowercased():
                    actionButtonTile = "Learn"
                case "Ideation".lowercased():
                    actionButtonTile = "Think"
                case "Micro-Volunteering".lowercased(),
                     "NGOs and volunteer work".lowercased():
                    actionButtonTile = "Participate"
                case "Events".lowercased():
                    actionButtonTile = "Assist"
                case "Donations".lowercased():
                    actionButtonTile = "Donate"
                case "Personal Habits".lowercased(),
                     "Ethical Consumer".lowercased():
                    actionButtonTile = "Pledge"
                case "Messages Worth Spreading".lowercased():
                    actionButtonTile = "Share"
                case "Adoptions".lowercased():
                    actionButtonTile = "Adopt"
                case "Crowdfunding positive projects".lowercased(),
                     "Donate Processing Power".lowercased():
                    actionButtonTile = "Contribute"
                case "Individual Actions".lowercased(),
                     "Special".lowercased(),
                     "Help us prioritize".lowercased():
                    actionButtonTile = "Do"
                case "Poll".lowercased():
                    actionButtonTile = "Reply"
                default:
                    actionButtonTile = "Do"
                }
                
                actionTitle.text = action.title
                actionTitleDetail.text = action.title
                actionDescription.text = action.text
                actionType.text = action.type
//                actionButton.setTitle(actionButtonTile, for: .normal)
//                actionDetailButton.setTitle(actionButtonTile, for: .normal)
                actionPledges.text = "\(action.pledges)"
                
                switch action.review {
                case 1:
                    star1.image = fillRatingImage
                    star2.image = outlineRatingImage
                    star3.image = outlineRatingImage
                    star4.image = outlineRatingImage
                    star5.image = outlineRatingImage
                case 2:
                    star1.image = fillRatingImage
                    star2.image = fillRatingImage
                    star3.image = outlineRatingImage
                    star4.image = outlineRatingImage
                    star5.image = outlineRatingImage
                case 3:
                    star1.image = fillRatingImage
                    star2.image = fillRatingImage
                    star3.image = fillRatingImage
                    star4.image = outlineRatingImage
                    star5.image = outlineRatingImage
                case 4:
                    star1.image = fillRatingImage
                    star2.image = fillRatingImage
                    star3.image = fillRatingImage
                    star4.image = fillRatingImage
                    star5.image = outlineRatingImage
                case 5:
                    star1.image = fillRatingImage
                    star2.image = fillRatingImage
                    star3.image = fillRatingImage
                    star4.image = fillRatingImage
                    star5.image = fillRatingImage
                default:
                    star1.image = outlineRatingImage
                    star2.image = outlineRatingImage
                    star3.image = outlineRatingImage
                    star4.image = outlineRatingImage
                    star5.image = outlineRatingImage
                }
                
                let catPictureURL = URL(string: action.image)!
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        if let _ = response as? HTTPURLResponse {
                            if data != nil, let image = UIImage(data: data!) {
                                self.actionImage.image = image
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }
                downloadPicTask.resume()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit();
    }
    
    func schemeAvailable(_ scheme: String) -> Bool {
        if let url = URL.init(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    @IBAction func pledgeAction(_ sender: UIButton) {
        if let action = action {
            let PGDHook = "playgrounddo://#social!\(action.id)"
            let PGURL = URL(string: PGDHook)
            if UIApplication.shared.canOpenURL(PGURL! as URL) {
                UIApplication.shared.openURL(PGURL!)
            } else {
                let url = action.url
                let url_cms = action.cms_url
                if url != "" {
                    UIApplication.shared.openURL(URL(string: url)!)
                } else {
                    UIApplication.shared.openURL(URL(string: url_cms)!)
                }
            }
        }
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        if let action = action {
            let shortURL:String = action.url != "" ? action.url : action.cms_url;
            if let urlToShare = URL(string: shortURL as String) {
                let objectsToShare = ["\(action.title)", urlToShare, "vía @PlaygroundDO"] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    topController.present(activityVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func showDetail(_ sender: Any) {
        rotateView()
    }
    
    @IBAction func closeDetail(_ sender: Any) {
        rotateView()
    }
    
    func rotateView() {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            if self.detailView.isHidden {
                self.detailView.isHidden = false
                self.actionDetailButtonImage.image = self.zoomOutImage
            } else {
                self.detailView.isHidden = true
                self.actionDetailButtonImage.image = self.zoomInImage
            }
        }, completion: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        
        let bundle = Bundle(for: PGDActionView.self)
        bundle.loadNibNamed("PGDActionView", owner: self, options: nil)
        guard let content = contentView else { return }
        
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        content.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        content.layer.shadowOffset = CGSize(width: 0, height: 0)
        content.layer.shadowOpacity = 0.5
        content.layer.cornerRadius = 5
        
        container.layer.cornerRadius = 5
        detailView.layer.cornerRadius = 5
        
//        actionButton.layer.borderColor = UIColor.black.cgColor
//        actionButton.layer.borderWidth = 1
//        actionDetailButton.layer.borderColor = UIColor.black.cgColor
//        actionDetailButton.layer.borderWidth = 1
        
        self.addSubview(content)
    }
}
