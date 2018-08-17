# Introduction

This is final project for CS2048 Fall 2017.

Credit owned by Feng Qi(fq26)

A simple offline  photo-based blog app.

# Requirements
1. At least two view controller
2. On container view controller(tab bar, navigation view controller, split view etc.)
3. One shared model
4. One custom view where you overload the `drawRect` method and add custom drawing`drawRect`
5. At least one of the views must be laied out using AutoLayout
6. At least one animation

# Implementation Detail
1. Initial view controller is a tab bar controller which has three Scene : HOME, Add, PHOTO. You could redirect to specific scene by clicking the item.
    * HOME scene shows user's profile. Also allows user to edit their profile.
    * Add scene allows user to add new photo, and assign an `unique` name for the photo as well as some descriptions about this photo.
    * PHOTO scene shows all the photos the user currently has. Show detail description about the photo by tapping the image. Also allow user to delete.
2. HOME scene detail -- `FirstViewController.swift`
    * It shows profile image, the number of posts the user has, and the self-introduction of this user.
    * Click `Edit` to modify his/her profile.
3. Edit scene detail -- `settingsViewController.swift`, `settingTextView.swift`
    * `Bio` part, namely self introduction, is implemented by `TextView` with overloading `drawRect` function.
    * Data transfer between HOME and Edit scene is implemented by self-designed `backDelegate`.
    * `PickerView` is implemented to select gender, no keyboard input allowed.
4. Add scene detail -- `AddPhotoViewController.swift`
    * It enables user to upload a photo either from photo gallery or takn from camera(This has been tested using physical device.)
    * Make sure a unique name is assigned for the photo, cannot upload the user otherwise.
5. PHOTO scene detail -- `SecondViewController.swift`, `funcTableViewController.swift`, `funcTableViewCell.swift`
    * This scene is laied out using **AutoLayout** and **Animation**.
    * Show image description by tapping the image, retapping to disappear the corresponding image.
6. helper files
    * `FuncDatabase.swift` to simulate a simple database
    * `helper_func` contains some functions repeatedly used.
