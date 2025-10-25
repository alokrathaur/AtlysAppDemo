# Atlys App Demo 

## Overview
This project demonstrates a clean, maintainable SwiftUI architecture following MVVM pattern with reusable components. The app features a beautiful horizontal carousel showcasing travel destinations with country names and visa information.

**##Preview**

https://github.com/user-attachments/assets/7d3d5281-c174-4fd2-a17a-0cb2af36725d



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

The carousel is designed to work with **any number of images** (3, 5, 10, etc.). Simply add more destination objects to the `destinations` array in `ContentView.swift`:

```swift
private let destinations: [DestinationCard] = [
    DestinationCard(
        imageUrl: "https://media.istockphoto.com/id/845702822/photo/top-view-of-the-new-downtown-of-amman.jpg?s=612x612&w=0&k=20&c=Bm7uu-rw2jq-zl2zyNvMSy4ZyyZCQthJpec1x0brSUk=",
        countryName: "Dubai",
        visaCount: "53K+"
    ),
    DestinationCard(
        imageUrl: "https://i.guim.co.uk/img/media/55b58f9514a6ccb5a57d59d04151af12864acf69/0_374_5616_3370/master/5616.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=416add2213cc99b0e4b11206ea66407b",
        countryName: "Malaysia",
        visaCount: "32K+"
    ),
    DestinationCard(
        imageUrl: "https://i.pinimg.com/736x/19/92/bb/1992bb635a346c5c2ffc72ab56824391.jpg",
        countryName: "Thailand",
        visaCount: "25K+"
    ),
    // Add 4th image
    DestinationCard(
        imageUrl: "your-4th-image-url",
        countryName: "Country Name 4",
        visaCount: "XXK+"
    ),
    // Add 5th image
    DestinationCard(
        imageUrl: "your-5th-image-url",
        countryName: "Country Name 5",
        visaCount: "XXK+"
    )
]
```

**✨ No code changes required!** The carousel will automatically:
- Display the correct number of pagination indicators
- Handle navigation between all images
- Maintain proper drag boundaries (first image can't go left, last can't go right)
- Apply consistent layout and styling to all images

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
