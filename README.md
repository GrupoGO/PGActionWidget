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

class ViewController: UIViewController {

    @IBOutlet weak var widget: PGDActionWidgetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Ask for top actions
        // numberOfAction default is 10
        widget.searchActions(text: nil, numberOfAction: nil)
    }
    
}
```

<p align="center"><img src ="https://github.com/GrupoGO/PGActionWidget/blob/master/Screenshot.png" /></p>

### Search for a tag actions
```swift
widget.searchActions(text: "your tag here", numberOfAction: nil)
```

### Search for a location actions
```swift
import PGActionWidget

class ViewController: UIViewController {

    @IBOutlet weak var widget: PGDActionWidgetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2D(latitude: 41.397392, longitude: 2.195231)
        widget.searchActions(coordinates: location, locationName: "PlayGround", numberOfAction: 150)
    }
    
}

```
