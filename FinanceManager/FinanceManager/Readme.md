Charts setup:
    1. Clone repository https://github.com/danielgindi/Charts/
    2. Go to Targets, General
    3. In frameworks, libraries and embeded content add Charts.framework with "+" button

Push-notifications setup:
    1. In terminal: sudo gem install cocoapods
    2. In project directory in terminal: "open Podfile", if not exist - "pod init"
    3. Chek if two pods are in file: "pod 'Firebase/Core'",  "pod 'Firebase/Messaging'"
    4. Run in terminal: "pod install"
    5. Install recommended target settings in workspace if needed
