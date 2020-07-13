Original App Design Project - README Template
===

# 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app that automically notifies some select contacts of a user when the user is in a danger and presses a button.

### App Evaluation
- **Category:** Security
- **Mobile:** Mobile is essential for the requirement of location tracking. The app uses maps to access the location of the owner. Also uses sound recording to capture surrounding sounds.
- **Story:** Allows users to share their location with select contacts when the are in a dangerous situation
- **Market:** anyone can use this app. it's especially beneficial to people who live in a high crime areas or anyone who wants to feel safe.
- **Habit:** Users can add as many contacts they want to and can remove any contact at anytime.
- **Scope:** The app has a lot of optional features that can be incorporated to make it even more powerful. The stripped down version will focus on basic functionality with periodic updates to meet the wider goal. Future updates could include the ability to capture pictures of the surrounding, ability to notify uses in realtime when they enter a high crime area. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users can sign in
* Users can sign up
* Users can logout
* Users can see their profile page
* Users can add contacts to the app
* Users can see a map view of their location
* A setting page

**Optional Nice-to-have Stories**
* App can automatically record surrounding audio when a user initials the panic button
* App can take photos of surrroundings

### 2. Screen Archetypes
* login Screen
   * User Can Login
* Map Screen
  * Users Can view their location on map
* Sign up Screen
    * user can register for the app
* Profile Screen
    * User can see their profile details
* Settings
    * User can change some settings to suit want they prefare
* FindMe Screen
  * Users can trigger the tracking of thier location here. 
  * Shows history from previous tracking
* Contact Screen
  * Users can add and remove their designated contacts
 * create screen
    * Users can take photo
  
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile
* Map
* FindMe

**Flow Navigation** (Screen to Screen)
* login Screen
   * FindMe Screen
   * sign up
* Sign up Screen
    * FindMe Screen
    * create Screen
* Profile Screen
    * Camera Screen
 * Settings Screen
     * None
 * FindME Screen
    * None

## Wireframes
<img src="https://i.imgur.com/KEqmgti.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
**Model : User**
| property   | type   | description        |
|------------|--------|--------------------|
| first name | string | first name of user |
| last name  | string | last name of user  |
| email      | string | email of user      |
| password   | string | password of user   |
| country    | string | country of user    |
| image      | file   | profile photo      |

**Model: Contact**
| property   | type   | description        |
|------------|--------|--------------------|
| first name | string | first name of user |
| last name  | string | last name of user  |
| email      | string | email of user      |
| telephoneNo| string | password of user   |


### Networking
**login Screen**

log user in

     [PFUser logInWithUsernameInBackground:@"myname" password:@"mypass"
      block:^(PFUser *user, NSError *error) {
        if (user) {
          // Do stuff after successful login.
        } else {
          // The login failed. Check error to see why.
        }
    }];
    
**Sign up Screen**

 (Create/POST) Create a new user object
 
    - (void)myMethod {
        PFUser *user = [PFUser user];
        user.username = @"my name";
        user.password = @"my pass";
        user.email = @"email@example.com";
        // other fields can be set just like with PFObject
        user[@"phone"] = @"415-392-0202";

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
          if (!error) {   // Hooray! Let them use the app now.
          } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
          }
        }];
    }
**Profile Screen**

* (Read/GET) Query logged in user object

**contacts Screen**

* (Read/GET) Query logged in user object for contacts


