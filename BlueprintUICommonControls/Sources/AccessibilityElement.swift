import BlueprintUI
import UIKit

public struct AccessibilityElement: Element {

    public enum Trait: Hashable {
        case button
        case link
        case header
        case searchField
        case image
        case selected
        case playsSound
        case keyboardKey
        case staticText
        case summaryElement
        case notEnabled
        case updatesFrequently
        case startsMediaSession
        case adjustable
        case allowsDirectInteraction
        case causesPageTurn

        @available(iOS 10.0, *)
        case tabBar
    }

    public var label: String?
    public var value: String?
    public var hint: String?
    public var traits: Set<Trait>
    public var wrappedElement: Element

    public init(
        label: String? = nil,
        value: String? = nil,
        hint: String? = nil,
        traits: Set<Trait> = [],
        wrapping element: Element)
    {
        self.label = label
        self.value = value
        self.hint = hint
        self.traits = traits
        self.wrappedElement = element
    }

    private var accessibilityTraits: UIAccessibilityTraits {
        var traits: UIAccessibilityTraits = .none

        for trait in self.traits {
            switch trait {
            case .button:
                traits.formUnion(.button)
            case .link:
                traits.formUnion(.link)
            case .header:
                traits.formUnion(.header)
            case .searchField:
                traits.formUnion(.searchField)
            case .image:
                traits.formUnion(.image)
            case .selected:
                traits.formUnion(.selected)
            case .playsSound:
                traits.formUnion(.playsSound)
            case .keyboardKey:
                traits.formUnion(.keyboardKey)
            case .staticText:
                traits.formUnion(.staticText)
            case .summaryElement:
                traits.formUnion(.summaryElement)
            case .notEnabled:
                traits.formUnion(.notEnabled)
            case .updatesFrequently:
                traits.formUnion(.updatesFrequently)
            case .startsMediaSession:
                traits.formUnion(.startsMediaSession)
            case .adjustable:
                traits.formUnion(.adjustable)
            case .allowsDirectInteraction:
                traits.formUnion(.allowsDirectInteraction)
            case .causesPageTurn:
                traits.formUnion(.causesPageTurn)
            case .tabBar:
                if #available(iOS 10.0, *) {
                    traits.formUnion(.tabBar)
                }
            }
        }

        return traits
    }

    public var content: ElementContent {
        return ElementContent(child: wrappedElement)
    }

    public func backingViewDescription(bounds: CGRect, subtreeExtent: CGRect?) -> ViewDescription? {
        return UIView.describe { config in
            config[\.accessibilityLabel] = label
            config[\.accessibilityValue] = value
            config[\.accessibilityHint] = hint
            config[\.accessibilityTraits] = accessibilityTraits
            config[\.isAccessibilityElement] = true
        }
    }

}
