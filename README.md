## iOS Bootcamp - Week 3 Exercise

This is a simple chat client using the [Parse SDK](https://parse.com/docs/ios_guide)

Time spent: `<Number of hours spent>`

### Features

#### Required

- Setup
  - [X] Create a new project.
  - [X] Create a Podfile, add the "Parse" pod, and run pod install.
    - pod "Parse"
  - [X] Configure Parse
    - Add an Objective-C bridging file. Guide: Importing Objective-C into Swift
    - Import Parse in the bridging file: #import <Parse/Parse.h>
    - In the AppDelegate, register Parse in the application:didFinishLaunchingWithOptions: function.
    - Parse.setApplicationId("DXsvTSLgsKT03gSSqy6V5KbLwVpgfEjmEsKzzQUP", clientKey: "BXAzmCJhMtIVWhLVEiKIMzPCA5XI0Nt9NwvAOPVd")
- [X] Create a LoginViewController
  - [X] Add an email text field, a password text field, a sign in button, and a sign up button.
  - [X] On sign in, attempt to sign in to Parse (display an alert on error)
  - [X] On sign up, attempt to sign up to Parse (display an alert on error)
    - [ ] Make the sign up/in buttons fade in and out
- [X] Create a ChatViewController
  - [X] Create a segue with an identifier from the LoginViewController (Ctrl-drag from the yellow circle to the ChatViewController). Upon successfully signing in or signing up, modally segue to the ChatViewController
  - [X] Add a text field and a button to compose a new message.
  - [X] When the user taps the button, create a new message in Parse.
    - Use the class name: Message (this is case sensitive).
    - Store the text of the text field in a key called text.
    - Call saveInBackgroundWithBlock and print when the message successfully saves.
- [X] Retrieving Messages
  - [X] Add a table view to the ChatViewController and a prototype cell that will contain the message.
  - [x] Create a refresh function that is run every second.
  - [X] Query Parse for all messages.
  - [X] Query the Message class using the findObjectsInBackground function. You can also sort by createdAt.


### Walkthrough

![Video Walkthrough](https://github.com/apfritts/ExerciseW3/raw/master/Screencast.gif)

