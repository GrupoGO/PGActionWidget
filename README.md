# PGActionWidget
Action Widget for PlayGround Do social actions.

## Requirements

It requires Xcode 9.0+ and Swift 3.0.


## Installation

```ruby
pod 'PGActionWidget'
```

## Usage

### Basic Usage
Just `import PGActionWidget` and add a `PGDActionWidgetView` to your Storyboard


```swift
import PGActionWidget
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var widget: PGDActionWidgetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // numberOfAction default is 10
        
        // MARK: - Ask for top actions
        widget.searchActions(text: nil, numberOfAction: nil)
        
        // MARK: -  Search for a tag
        // widget.searchActions(text: "your tag here", numberOfAction: nil)
        
        // MARK: - Search for a location
        // widget.searchActions(coordinates: CLLocationCoordinate2D(latitude: 40.3546907, longitude: -3.744518400000061), numberOfAction: 150)
    }
    
}
```

<p align="center"><img src ="https://github.com/GrupoGO/PGActionWidget/blob/master/Screenshot.png" /></p>
