# CallBlock

CallBlocking test app which can block specific numbers from calling you and identify pre-added numbers as suspicious calls.

# Motivation

This is a coding test project made as part of job application for telecommunication mobile software company.

# Features

- Block specific numbers from calling you, add numbers you wish to block programmatically or inside app 
- Add identification to suspicious numbers (programmatically)

# Installation

Download files and then run CallBlock.xcworkspace

# Tests

For testing purposes you can change phoneNumbers array(numbers you wish to block) and phoneNumbers2 array(numbers with identification) vallues inside CallDirectoryHandler.swift.

If you want to add real telephone numbers you must add prefix with country and area code.

For example if you wish to add landline number from Split,Croatia your number should be in this format .. (+38521 XXX XXX)

# Contribute

If given more time I could add some more features: 

● Allow user to remove blocked number from list

● Local notification when app blocks a call 

● More stylish UI for blocked numbers list 

● add info/tutorial on App's first run

So there are a few ideas to upgrade this project!

# Section for my Project reviewer

● Deliver the application via Hockey, Diawi or similar service - I checked out these services and didn't see any 
point in delivering app through their services, so maybe you could tell me why are they so special? :)

● Block all calls except those received from Contacts - apparently WHITELISTING is not available in CallKit?

● Block texts based on some criteria - not allowed with third party apps
