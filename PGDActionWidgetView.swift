//
//  PGDActionWidgetView.swift
//  ActionWidget
//
//  Created by Emilio Cubo Ruiz on 13/7/17.
//  Copyright © 2017 Grupo Go Optimizations, SL. All rights reserved.
//

import UIKit
import CoreLocation

struct Action {
    
    var cms_url:String
    var end_date:Date
    var id:Int
    var image:String
    var isDo:Bool
    var isTodo:Bool
    var latitude:Double
    var longitude:Double
    var metric:String
    var metric_quantity:Int
    var platform:String
    var pledges:Int
    var review:Int
    var start_date:Date
    var text:String
    var time:Int
    var title:String
    var type:String
    var url:String
    
    var categories:[Category]
    var doUsers:[User]
    var lists:[List]
    var poll:[Answer]
    var todoUsers:[User]
}

struct Category {
    var id:Int
    var image:String
    var name:String
    var valor:Int
    
    var actions:[Action]
    var usersWithCategory:[User]
}

struct User {
    var address_1:String
    var address_2:String
    var alias:String
    var birdthdate:String
    var city:String
    var co2:Int
    var country:String
    var dollars:Int
    var email:String
    var firstname:String
    var gender:String
    var id:Int
    var image:String
    var lasname:String
    var latitude:Double
    var lives:Int
    var longitude:Double
    var nationality:String
    var official_document:String
    var phone:String
    var points:String
    var postal_code:String
    var region:String
    var session:String
    var time:Int
    
    var categories:[Category]
    var does:[Action]
    var lists:[List]
    var messages:[Message]
    var todoes:[Action]
    var types:[Type]
}

struct List {
    var created:Date
    var hashid:String
    var id:Int
    var isPrivate:Bool
    var last_update:Date
    var name:String
    
    var actions:[Action]
    var creator:User
}

struct Answer {
    var id:Int
    var poll_id:Int
    var poll_title:String
    var statValue:Int
    var text:String
    
    var action:Action
}

struct Message {
    var date:Date
    var ratting:Int
    var text:String
    
    var sender:User
}

struct Type {
    var id:Int
    var valor:Int
    
    var userWithType:User
}

public class PGDActionWidgetView: UIView {
    
    // MARK: Outlets
    @IBOutlet fileprivate var contentView:UIView?
    @IBOutlet fileprivate var container:UIView?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var actionText: UILabel!
    
    var actions: [Action]? {
        didSet {
            if let actions = actions {
                let screenHeight = UIScreen.main.bounds.size.height
                let height = screenHeight < 408 ? screenHeight - 108 : 300
                var originX = 12.0
                for action in actions {
                    let actionView = PGDActionView(frame: CGRect(x: originX, y: 0, width: 222.0, height: Double(height)))
                    actionView.action = action
                    originX += 234
                    scrollView.addSubview(actionView)
                }
                scrollView.layoutIfNeeded();
                let width = 234 * actions.count + 12
                scrollView.contentSize = CGSize(width: CGFloat(width), height: scrollView.contentSize.height);
                loader.isHidden = true
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit();
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let content = contentView else { return }
        var frameSize = content.bounds
        let screenHeight = UIScreen.main.bounds.size.height
        let height = screenHeight < 408 ? screenHeight - 108 : 300
        frameSize.size.height = screenHeight < 408 ? screenHeight : 408
        content.frame = frameSize
        
        for view in scrollView.subviews {
            if view.isKind(of: PGDActionView.self) {
                view.frame.size.height = height
            }
        }
    }
    
    public func searchActions(coordinates:CLLocationCoordinate2D, locationName:String, numberOfAction:Int?) {
        
        actionText.text = "Actions near \(locationName)"
        let size = numberOfAction != nil ? numberOfAction! : 100

        let urlCoordinates = "https://maps.googleapis.com/maps/api/geocode/json?language=en&sensor=false&latlng=\(coordinates.latitude),\(coordinates.longitude)&result_type=administrative_area_level_1&key=AIzaSyBxL5CwUDj15cnfFP0PbEr0k8nq6Po3gEw"
        let requestCoordinates = NSMutableURLRequest(url: URL(string: urlCoordinates)!)
        requestCoordinates.httpMethod = "GET"
        let taskCoordinates = URLSession.shared.dataTask(with: requestCoordinates as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                DispatchQueue.main.async(execute: {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        if let results = json["results"] as? [Any] {
                            if results.count > 0 {
                                let geometry = (results[0] as! [String:Any])["geometry"] as! [String:Any]
                                let bounds = geometry["bounds"] as! [String:Any]
                                
                                let max_lat = (bounds["northeast"] as! [String:Any])["lat"] as! Double
                                let max_lng = (bounds["northeast"] as! [String:Any])["lng"] as! Double
                                let min_lat = (bounds["southwest"] as! [String:Any])["lat"] as! Double
                                let min_lng = (bounds["southwest"] as! [String:Any])["lng"] as! Double
                                
                                let urlPHP = "https://webintra.net/api/Playground/search?min_lat=\(min_lat)&max_lat=\(max_lat)&min_lng=\(min_lng)&max_lng=\(max_lng)&size=\(size)"
                                let request = NSMutableURLRequest(url: URL(string: urlPHP)!)
                                request.httpMethod = "GET"
                                request.addValue("59baef879d68f4af3c97c0269ed46200", forHTTPHeaderField: "Token")
                                request.addValue("b6cccc4e45422e84143cd6a8fa589eb4", forHTTPHeaderField: "Secret")
                                
                                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                                    
                                    if error != nil {
                                        print(error!)
                                    } else {
                                        DispatchQueue.main.async(execute: {
                                            do {
                                                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                                                self.parseActions(parsedData: parsedData)
                                            } catch let error as NSError {
                                                print(error)
                                            }
                                        });
                                    }
                                    
                                })
                                task.resume()
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                });
            }
            
        })
        taskCoordinates.resume()

    }
    
    public func searchActions(text:String?, numberOfAction:Int?) {
        
        if let textActioon = text {
            actionText.text = "Actions for \(textActioon)"
        } else {
            actionText.text = "Recommended actions"
        }
        
        let size = numberOfAction != nil ? numberOfAction! : 10
        let urlPHP = text != nil ? "https://webintra.net/api/Playground/search?text=\(text!)&size=\(size)" : "https://webintra.net/api/Playground/search?list=16758375"
        let request = NSMutableURLRequest(url: URL(string: urlPHP)!)
        request.httpMethod = "GET"
        request.addValue("59baef879d68f4af3c97c0269ed46200", forHTTPHeaderField: "Token")
        request.addValue("b6cccc4e45422e84143cd6a8fa589eb4", forHTTPHeaderField: "Secret")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                DispatchQueue.main.async(execute: {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        self.parseActions(parsedData: parsedData)
                    } catch let error as NSError {
                        print(error)
                    }
                });
            }
            
        })
        task.resume()
        
    }
    
    func parseActions(parsedData:[String:Any]) {
        let info = parsedData["info"] as! [String:Any]
        if let items = info["items"] as? [[String:Any]] {
            var parseActions = [Action]()
            for item in items {
                
                var newAction = Action(
                    cms_url: item["cms_url"] as! String,
                    end_date: Date.dateFromString(item["end_date"] as! String, timeZone: false),
                    id: item["id"] as! Int,
                    image: item["image"] as! String,
                    isDo: false,
                    isTodo: false,
                    latitude: item["latitude"] as? Double != nil ? item["latitude"] as! Double : 0.0,
                    longitude: item["longitude"] as? Double != nil ? item["longitude"] as! Double : 0.0,
                    metric: item["metric"] as! String,
                    metric_quantity: item["metric_quantity"] as! Int,
                    platform: item["website"] as! String,
                    pledges: item["plegdes"] as? Int != nil ? item["plegdes"] as! Int : 0,
                    review: item["review"] as? Int != nil ? item["review"] as! Int : 0,
                    start_date: Date.dateFromString(item["start_date"] as! String, timeZone: false),
                    text: item["description"] as! String,
                    time: item["time"] as! Int,
                    title: item["title"] as! String,
                    type: item["type"] as! String,
                    url: item["url"] as! String,
                    categories: [],
                    doUsers: [],
                    lists: [],
                    poll: [],
                    todoUsers: []
                )
                
                if newAction.type.lowercased() == "poll" {
                    let poll = item["poll"] as! [String:Any]
                    let pollTitle = poll["title"] as! String
                    newAction.title = pollTitle
                    
                    let pollAnswers = poll["answers"] as! [[String:Any]]
                    var answers = [Answer]()
                    for answer in pollAnswers {
                        let a = Answer(
                            id: answer["id"] as! Int,
                            poll_id: poll["id"] as! Int,
                            poll_title: newAction.title,
                            statValue: 0,
                            text: answer["text"] as! String,
                            action: newAction)
                        answers.append(a)
                    }
                    newAction.poll = answers
                }
                
                parseActions.append(newAction)
            }
            
            self.actions = parseActions
        }
    }
    
    fileprivate func commonInit() {
        
        let bundle = Bundle(for: PGDActionView.self)
        bundle.loadNibNamed("PGDActionWidgetView", owner: self, options: nil)
        guard let content = contentView else { return }
        
        var frameSize = self.bounds
        frameSize.size.height = 408
        content.frame = frameSize
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        container?.layer.cornerRadius = 5
        container?.layer.borderWidth = 1
        container?.layer.borderColor = UIColor.black.cgColor
        self.addSubview(content)
    }
    
    
}


extension Date {
    static func dateFromString(_ stringDate:String, timeZone:Bool) -> Date {
        var dateToReturn:Date = Date();
        let formatters = [
            "dd-MM-yyyy HH:mm",
            "yyyy-MM-dd"
            ].map { (format: String) -> DateFormatter in
                let formatter = DateFormatter()
                formatter.dateFormat = format
                if timeZone {
                    formatter.timeZone = TimeZone(abbreviation: "UTC");
                }
                return formatter
        }
        for formatter in formatters {
            if let date = formatter.date(from: stringDate) {
                dateToReturn = date;
            }
        }
        return dateToReturn;
    }
}
