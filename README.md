# Speech to Text Demo (Swift)

This repository contains an example application to demonstrate how to use the Speech to Text functionality of the [Watson Developer Cloud Swift SDK](https://github.com/watson-developer-cloud/swift-sdk).

## Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 4.0+

## Dependency Management

This project uses [Carthage](https://github.com/Carthage/Carthage) to manage dependencies. You can install Carthage using [Homebrew](http://brew.sh/).

```
> brew install carthage
```

## Getting Started

1. Clone the repository: `git clone https://github.com/watson-developer-cloud/speech-to-text-swift.git`
2. Build the dependencies: `carthage update --platform iOS`. 
3. Copy `CredentialsExample.swift` to `Credentials.swift`: `cp CredentialsExample.swift Credentials.swift`
4. Open `Speech to Text.xcodeproj` in Xcode
5. Update your Speech to Text instance's credentials in `Credentials.swift`
6. Build and run the app!
