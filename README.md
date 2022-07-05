# FinanceManager
-----------------
Course project
-----------------
Subject: OOP
-----------------
Functional:
-----------------
1. Editable expense list with categories and watermarks
2. Priority categories list
3. Editable debts list
4. Statistics with chart (considers average fuel expenses if you have a car) 
5. Password protection, backup codes and backup question
6. Tips depending on selected finance strategy
7. Editable personal data and settings
-----------------
Charts setup:
-----------------
1. Clone repository https://github.com/danielgindi/Charts/
2. Go to Targets, General
3. In frameworks, libraries and embeded content add Charts.framework with "+" button
-----------------
Push-notifications setup:
-----------------
1. In terminal: sudo gem install cocoapods
2. In project directory in terminal: "open Podfile", if not exist - "pod init"
3. Chek if two pods are in file: "pod 'Firebase/Core'",  "pod 'Firebase/Messaging'"
4. Run in terminal: "pod install"
5. Install recommended target settings in workspace if needed
