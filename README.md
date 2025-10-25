# Atlys App Demo - Refactored Architecture

## Overview
This project demonstrates a clean, maintainable SwiftUI architecture following MVVM pattern with reusable components. The app features a beautiful horizontal carousel showcasing travel destinations with country names and visa information.

## Architecture

### 📁 Project Structure

```
AtlysAppDemo/
├── Models/
│   ├── DestinationCard.swift           # Data model for destinations with Identifiable
│   └── CarouselConfiguration.swift     # Centralized configuration model
├── ViewModels/
│   └── CarouselViewModel.swift         # Business logic and state management
├── Views/
│   ├── ContentView.swift               # Main entry point with sample data
│   ├── CarouselView.swift              # Main carousel container
│   └── Components/
│       ├── DestinationCardView.swift   # Reusable destination card component
│       └── CarouselIndicator.swift     # Reusable pagination indicator
├── Utilities/
│   └── CarouselLayoutCalculator.swift  # Layout calculation logic
└── Assets/
    └── logo.imageset/                   # App logo
```

## Architecture Principles

### 🏗️ MVVM Pattern

**Models** (`Models/`):
- `DestinationCard`: Represents a destination with image URL, country name, and visa count
- `CarouselConfiguration`: Centralizes all carousel settings (dimensions, overlap, drag threshold)

**ViewModels** (`ViewModels/`):
- `CarouselViewModel`: Manages carousel state, navigation logic, and drag handling
- Uses `@Published` properties for reactive UI updates
- Implements `ObservableObject` for SwiftUI binding

**Views** (`Views/`):
- Container views compose smaller components
- Focus on presentation only, no business logic
- Reusable components for maintainability

**Utilities** (`Utilities/`):
- Pure calculation logic separated from UI
- `CarouselLayoutCalculator`: Handles layout mathematics

### 🎨 Component Architecture

**Reusable Components**:
- `DestinationCardView`: Self-contained card with image and labels
- `CarouselIndicator`: Pagination dots indicator
- `LogoHeaderView`: App branding header
- `AsyncImageView`: Handles async image loading with error states

### ⚙️ Configuration-Driven Design

All carousel properties are centralized in `CarouselConfiguration.default`:
```swift
static let `default` = CarouselConfiguration(
    itemHeight: 300,        // Center card height
    itemWidth: 250,         // Card width
    overlapPercentage: 0.2, // 20% overlap for parallax effect
    dragThreshold: 200      // Swipe sensitivity
)
```

## Features

### ✨ User Experience
- **Horizontal Carousel**: Swipe left/right to navigate between destinations
- **Parallax Effect**: 20% overlap with centered card focus
- **Smooth Animations**: Spring-based transitions
- **Boundary Constraints**: Cannot swipe beyond first/last item
- **Visual Indicators**: Pagination dots show current position

### 🎨 Visual Design
- **Country Labels**: Large, bold white text with shadow for readability
- **Visa Information**: Purple/blue strip with visa count on "Atlys"
- **Responsive Layout**: Cards resize based on position (center vs. side)
- **Consistent Dimensions**: Center card always 250×300, side cards 250×200

## How to Use

### Adding New Destinations

 `ContentView.swift` to add destinations:

```swift
private let destinations: [DestinationCard] = [
    DestinationCard(
        imageUrl: "https://your-image-url.com/image.jpg",
        countryName: "Your Country",
        visaCount: "XXK+"
    ),
    // Add more destinations...
]
```

### Customizing Appearance

**Modify Configuration** (`Models/CarouselConfiguration.swift`):
```swift
static let `default` = CarouselConfiguration(
    itemHeight: 300,      // Adjust card height
    itemWidth: 250,       // Adjust card width
    overlapPercentage: 0.2, // Adjust overlap (0.0-1.0)
    dragThreshold: 200    // Adjust swipe sensitivity
)
```

**Customize Colors** (`Views/Components/DestinationCardView.swift`):
```swift
// Change visa strip color (currently Color(red: 0.4, green: 0, blue: 0.8))
.background(Color(red: yourRed, green: yourGreen, blue: yourBlue))
```

## Benefits of This Architecture

1. **✅ Maintainability**: Clear separation of concerns, easy to navigate
2. **✅ Testability**: Components and view models can be tested independently
3. **✅ Reusability**: Components work across different contexts
4. **✅ Scalability**: Easy to add features (animations, gestures, etc.)
5. **✅ Readability**: Self-documenting code with clear naming
6. **✅ Performance**: Efficient updates using SwiftUI's reactive system

## Technical Details

### Card Dimensions
- **Center Card**: 250 × 300 pixels (full size)
- **Side Cards**: 250 × 200 pixels (reduced for parallax)
- **Overlap**: 200 pixels (20% of width)

### Animation System
- Spring physics with stiffness: 300, damping: 30
- Smooth transitions between cards
- Drag response with boundary constraints

### State Management
- `@StateObject` for ViewModel lifecycle
- `@Published` properties for reactive updates
- `@ObservedObject` for sub-views

## File Responsibilities

| File | Responsibility |
|------|---------------|
| `ContentView.swift` | Entry point, sample data |
| `CarouselView.swift` | Main container, layout orchestration |
| `DestinationCardView.swift` | Card rendering, image + labels |
| `CarouselIndicator.swift` | Pagination UI |
| `CarouselViewModel.swift` | Business logic, state management |
| `CarouselLayoutCalculator.swift` | Layout mathematics |
| `CarouselConfiguration.swift` | Settings and constants |

## Code Quality Standards

- ✅ Single Responsibility Principle
- ✅ DRY (Don't Repeat Yourself)
- ✅ Composition over inheritance
- ✅ Dependency inversion
- ✅ Clear naming conventions
- ✅ Comprehensive documentation
