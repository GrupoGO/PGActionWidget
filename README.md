# PGActionWidget
Action Widget for PlayGround Do social actions.

## Requirements

It requires Xcode 9.0+ and Swift 3.0.


## Installation

```ruby
pod 'PGActionWidget', :git => 'https://github.com/GrupoGO/PGActionWidget.git'
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

        // Ask for top actions with 10 actions default
        widget.searchActions(text: nil, numberOfAction: nil)
        
        // Search for Search for a tag
        // widget.searchActions(text: "your tag here", numberOfAction: nil)

        // Search for Search for a tag
        // widget.searchActions(text: nil, numberOfAction: nil)
    }
    
}
```

<p align="center"><img src ="https://github.com/GrupoGO/PGActionWidget/blob/master/Screenshot.png" /></p>
