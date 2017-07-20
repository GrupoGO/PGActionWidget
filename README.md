# PGActionWidget
Action Widget for PlayGround Do social actions.

## Requirements

It requires Xcode 9.0+ and Swift 3.0.


## Installation

```ruby
pod 'PGActionWidget'
```

## Open actions in PlayGround Do application
Just add the item `playgrounddo` in your `LSApplicationQueriesSchemes`

```swift
    <key>LSApplicationQueriesSchemes</key>
    <array>
        // ...
        <string>playgrounddo</string>
    </array>
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
        widget.searchActions(keywords: nil, numberOfAction: nil)
    }
    
}
```

### Search actions for keywords
```swift
let keywords = ["fitness","health"]
widget.searchActions(keywords: keywords, numberOfAction: nil)
```

### Search for located actions
Add `import CoreLocation`

```swift
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var widget: PGDActionWidgetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let keywords = ["fitness","health"]
        let location = CLLocationCoordinate2D(latitude: 41.397392, longitude: 2.195231)
        widget.searchActions(coordinates: location, locationName: "PlayGround", keywords: keywords, numberOfAction: 150)
    }
    
}

```

<p align="center"><img src ="https://github.com/GrupoGO/PGActionWidget/blob/master/Screenshot_v2.png" /></p>
