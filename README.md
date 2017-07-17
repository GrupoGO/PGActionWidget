# PGActionWidget
PGActionWidget Init


## Requirements

It requires Xcode 9.0+ and Swift 3.0.


## Installation

```ruby
pod 'PGActionWidget', :git => 'https://github.com/GrupoGO/PGActionWidget.git'
```

## Usage

### Basic Usage
Just `import PGActionWidget` and create a instance of `PGDActionWidgetView`. **Works with Storyboard too**


```swift
import PGActionWidget

class ViewController: UIViewController {

    @IBOutlet weak var widget: PGDActionWidgetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        widget.searchAction(text: nil, numberOfAction: nil)
    }
    
}
```
