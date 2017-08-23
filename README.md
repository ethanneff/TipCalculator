# Pre-work - *TipCalculator*

**TipCalculator** is a tip calculator application for iOS.

Submitted by: **Ethan neff**

Time spent: **5** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [ ] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] No Storyboards
- [x] App Icon 
- [x] Formatted input validations
- [x] Dismissible keyboard 
- [x] Persisted data
- [x] Decoupled modular design

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/AxvoeKn.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I personally like iOS development over Android or Hybrid development (ReactNative and Cordova). I appreciate the expectations of quality that comes with iOS development, and I enjoy opinionated nature of the platform - which makes development overall easier. In terms of under-the-hood, I have worked with the `.xml` of the Storyboard, I have made scripts which inject into the `project.pbxproj`, and I have interacted with the the underlying `Objective C` layers of the Apple frameworks. For new developers, these are some of the best resources that I use:
    - Learn iOS https://teamtreehouse.com/
    - Swift best practices https://github.com/raywenderlich/swift-style-guide
    - Swift linter https://github.com/realm/SwiftLint
    - Swift algorithms https://github.com/raywenderlich/swift-algorithm-club

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** Closures can capture the `self` instance which can cause a strong reference cycle (memory leak). Your best defense against this is to use a `[weak self]` in your closure response.

    ```swift
    resource.request().onComplete { [weak self] response in
      guard let strongSelf = self else {
        return
      }
      let model = strongSelf.updateModel(response)
      strongSelf.updateUI(model)
    }
    ```

## License

    Copyright [2017] Ethan Neff

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.