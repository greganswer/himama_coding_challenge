# HiMama Coding Challenge

- [Production](#production)
- [Overview](#overview)
- [Additional questions](#additional-questions)
  - [1. How did you approach this challenge?](#1-how-did-you-approach-this-challenge)
  - [2. What schema design did you choose and why?](#2-what-schema-design-did-you-choose-and-why)
  - [3. If you were given another day to work on this, how would you spend it?](#3-if-you-were-given-another-day-to-work-on-this-how-would-you-spend-it)
  - [4. What if you were given a month?](#4-what-if-you-were-given-a-month)
- [Design](#design)
  - [User Stories](#user-stories)
- [References](#references)

## Production

1. Visit https://mighty-sands-32926.herokuapp.com
1. The test email address is `jane@example.com` the password is `secret`
1. Test out the [User Stories](#user-stories) linked below

## Overview

An important part of the HiMama platform is to allow teachers to 
clock-in/clock-out of their daycare center. When a teacher arrives to work, 
they clock-in, when leave they clock-out, and the platform keeps track of these events.

Using Ruby on Rails (or equivalent MVC framework), build a basic MVP of a 
clock-in/out application, using traditional CRUD methods. The app should:

- Present a clock-in/out screen that will:
    - [ ] Allow a user to enter their name or log in
    - [x] Allow the user to clock either in or out
    - [x] Upon clock event, store this information
    - [x] Provide a list of all clock events with logged information

**Other things to consider:**
- [x] A teacher may need to clock in/out multiple times a day (e.g., for lunch)
- [ ] A clock event may need to be edited or deleted
- [x] Are there any validations or UI constraints.

**Code and working prototype:**
- [x] Upload the application code to a repo and provide the link.
- [x] Make the prototype available for testing by uploading to a free application server (such as Heroku) and provide the link.

## Additional questions

### 1. How did you approach this challenge?

1. Functionality first, design later. I want to make sure it works before I make it look good.
1. Write user stories to make sure I understand the behavior of the system
1. Create a data model for the `User` and `ClockEvent` models

### 2. What schema design did you choose and why?

**User:**

| Field           | Type         | Null | Key | Default | Extra          |
| --------------- | ------------ | ---- | --- | ------- | -------------- |
| id              | int          | NO   | PRI | NULL    | auto_increment |
| first_name      | varchar(255) | NO   |     | NULL    |                |
| last_name       | varchar(255) | NO   |     | 0       |                |
| email           | varchar(255) | NO   |     | NULL    | Unique         |
| password_digest | varchar(255) | NO   |     | NULL    |                |

**Clock Event:**

| Field        | Type     | Null | Key | Default | Extra          |
| ------------ | -------- | ---- | --- | ------- | -------------- |
| id           | int      | NO   | PRI | NULL    | auto_increment |
| clock_in_at  | datetime | NO   |     | NOW()   |                |
| clock_out_at | datetime | YES  |     | NULL    |                |

### 3. If you were given another day to work on this, how would you spend it? 

- Only allow logged in users to view any part of the app
- Add the ability to update/delete Clock Events
- Add confirmation for user clock out
- Handle additional scenarios clocking scenarios
    - If a user forgot to clock out yesterday and they want to clock in today, ask for confirmation
- Improve date format
- Additional unit and integration tests

### 4. What if you were given a month?

- Do user research to find out where and how they will be using this clock-in functionality
    - What device (desktop, laptop, tablet, phone, etc.)
    - Is it a shared device or does each user use they're personal device?
    - What's the environment like (noisy, fast-paced, unsecured, etc.)
- Is additional security necessary?
    - Strict password requirements (1 uppercase, 1 lowercase, 1 symbol)
    - 2 Factor authentication
    - We don't want people intentionally/unintentionally clocking hours for others
    - How about biometric devices? Finger print, facial recognition, retina, etc.
- Who should be allowed to update clock-in info and when?
    - Managers, supervisors, system admins, etc.
    - Should there be a time limit on when you can edit clock-in info?
- Does anyone need to be notified of clock-ins?
    - Who and why?
    - How up to date does the information have to be? (minutely, hourly, daily, etc.)
    - Who should be notified if someone doesn't clock-out?
    - Should someone be notified if a shift is longer than a certain number of hours
- How does this need to scale?
    - Each clock-in record will need a location ID if there will be multiple locations
- Is there a need for reporting?
    - Who will be looking at this data and why?
    - Do we need to track trends over time?
    - Where will this data be stored?
- Check with the payroll team to see if there's any missing info
    - The payroll system should store info like hourly rate
- On the Clock Events index page show which users are currently clocked in
- Determine how to allow users to login with their name
    - Full names are not guaranteed to be unique but emails are
- Allow users to filter and sort Clock Events
- Filter Clock Events by user permissions
    - Admins can see all users Clock Events, non-admins can only see their own
- Extract the UI to a Front-end framework like React
    - Make the components reusable and mobile friendly
- Change integer IDs to UUID (for scalability)
- Add internationalization 
- Use a Ruby gem like *Devise* for more robust authentication
    - Social login, password resets, etc.
- Add soft deletes for all models
- Additional refactoring

## Design

### User Stories

**Out of scope:**
- Account registration (database will be seeded with user info)
- Additional user CRUD
- Account status (whether or not the user is allowed to clock-in)
- Updating/Deleting Clock Event
- User permissions (who's allowed to do any of the above)
- Location ID for each Clock Event

**User clocks in/out**
```gherkin
Feature: User clocks in/out
  As a teacher
  I can clock-in/out
  So that I can track the hours that I've worked

  Background:
    Given I have an account

  # Basic scenarios

  Scenario: Clocked out user clocks in
    Given I'm clocked out
    When I try to clock in using valid login credentials
    Then I should see that I'm clocked in
    When I go to the Clock Events index page
    Then I should see a new Clock Event with the present clock in time

  Scenario: Clocked in user clocks out
    Given I'm already clocked in
    When I try to clock out using valid login credentials
    Then I should see that I'm clocked out
    When I go to the Clock Events index page
    Then I should see 1 Clock Event with the clock in and clock out times

  # Failure scenarios

  Scenario: Invalid name or login
    Given I'm clocked in or out
    When I try to clock in/out with invalid name/login
    Then I should see an unauthorized error message
    When I go the Clock Events index page
    Then I should see no new Clock Events

  Scenario: Invalid password
    Given I'm clocked in or out
    When I try to clock in/out with valid 
    And an invalid password
    Then I should see an unauthorized error message
    When I go the Clock Events index page
    Then I should see no new Clock Events

  # Special scenarios

  Scenario: Clocked in user clocks in again
    Given I'm already clocked in
    When I try to clock in again
    Then I should be asked to confirm that I want to clock in
    When I confirm
    Then I should see that I'm logged in
    When I go to the Clock Events index page
    Then I should see 2 Clock Events with Clock In times
    And both Clock Events should have no Clock Out times

  Scenario: Clocked out user clocks out again
    Given I'm clocked out
    When I try to clock out again
    Then I should see that I'm already clocked out
    When I go the Clock Events index page
    Then I should see no new Clock Events
```

**View Clock Events**
```gherkin
Feature: View Clock Events
  As a system administrator
  I can view the list of Clock Events
  So that I can review the hours worked by all teachers

  Scenario: 2 users have Clock Events
    Given there are 2 users in the system
    And both of them have logged in a few times
    When I go the Clock Events index page
    Then I should see the Clock Events for both users
```

## References

- [Stack Overflow - Time clock table design](https://bit.ly/2z1ZPMw)
- [Stack Overflow - Database design employee clocking in and out system](https://bit.ly/2KTK8ga)