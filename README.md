# BarometerKit

![Version](https://img.shields.io/github/tag/hapticsoft/BarometerKit.svg)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)

Simple framework to access the iPhone barometric pressure sensor

## Usage

```swift
import BarometerKit

let barometer = = PhoneBarometer()

barometer.start() { newValue in
    print("Barometric pressure changed:(\newValue.kPa.floatValue)")
}


```

## Requirements

- iOS 11.0+
- Xcode 9 (Swift 4.0)

## Installation

BarometerKit is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "hapticsoft/BarometerKit"
