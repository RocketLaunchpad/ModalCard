# ModalCard

Easily enables you to modally present a view controller as a card that does not extend the default height.

![](Docs/modalcard.gif)

It's a simple as adding the following code to the modal view controller:

```swift
class ModalViewController: UIViewController {

    private var modalCardController: ModalCardController!

    override func awakeFromNib() {
        super.awakeFromNib()
        modalCardController = ModalCardController(parent: self, modalHeight: 200)
    }

    // To programmatically dismiss this modal
    func dismissModal(animated: Bool) {
        modalCardController.dismissModal(animated: animated)
    }
}
```

## Installation Instructions

Add the following to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/RocketLaunchpad/ModalCard.git" from: "1.0.0")
```
