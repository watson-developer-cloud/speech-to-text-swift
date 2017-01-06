# Speech to Text Demo (Swift)

This repository contains an example application to demonstrate how to use the Speech to Text functionality of the [Watson Developer Cloud iOS SDK](https://github.com/watson-developer-cloud/ios-sdk).

## Requirements

- Swift 3.0+
- Xcode 8.0+
- iOS 8.0+

## Dependency Management

This project uses [Carthage](https://github.com/Carthage/Carthage) to manage dependencies. You can install Carthage using [Homebrew](http://brew.sh/).

```
> brew install carthage
```

## Getting Started

1. Clone the repository: `git clone https://github.com/watson-developer-cloud/speech-to-text-swift.git`
2. Build the dependencies: `carthage update --platform iOS`. Please note the project will be downloaded precompiled with Swift 3.0.0. If you are using a version greater than Swift 3.0.0, use the following command instead:
  `carthage update --platform iOS --no-use-binaries`. 
3. Copy `CredentialsExample.swift` to `Credentials.swift`: `cp CredentialsExample.swift Credentials.swift`
4. Open `Speech to Text.xcodeproj` in Xcode
5. Update your Speech to Text instance's credentials in `Credentials.swift`
6. Build and run the app!
