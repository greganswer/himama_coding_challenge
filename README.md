# HiMama Coding Challenge

An important part of the HiMama platform is to allow teachers to 
clock-in/clock-out of their daycare center. When a teacher arrives to work, 
they clock-in, when leave they clock-out, and the platform keeps track of these events.

Using Ruby on Rails (or equivalent MVC framework), build a basic MVP of a 
clock-in/out application, using traditional CRUD methods. The app should:

- Present a clock-in/out screen that will:
    - [ ] Allow a user to enter their name or log in
    - [ ] Allow the user to clock either in or out
    - [ ] Upon clock event, store this information
    - [ ] Provide a list of all clock events with logged information

**Other things to consider:**
- [ ] A teacher may need to clock in/out multiple times a day (e.g., for lunch)
- [ ] A clock event may need to be edited or deleted
- [ ] Are there any validations or UI constraints.

**Code and working prototype:**
- [ ] Upload the application code to a repo and provide the link.
- [ ] Make the prototype available for testing by uploading to a free application server (such as Heroku) and provide the link.

**Out of scope:**
- Account registration (database will be seeded with user info)
- Account status (whether or not the user is allowed to clock-in)
- Updating/Deleting clock events
- User permissions (who's allowed to do any of the above)
- Location ID for each Clock Event

## Additional questions

### 1. How did you approach this challenge?

1. Functionality first, design later. I want to make sure it works before I make it look good.
1. Write user stories to make sure I understand the behavior of the system
1. Create a data model for the `User` and `ClockEvent` models

### 2. What schema design did you choose and why?

### 3. If you were given another day to work on this, how would you spend it? 

- Only allow logged in users to view any part of the app
- Add the ability to update/delete Clock Events
- Add confirmation for user clock out
- Handle additional scenarios clocking scenarios
    - If a user forgot to clock out yesterday and they want to clock in today, ask for confirmation

### 4. What if you were given a month?

- Do user research to find out where and how they will be using this clock-in functionality
    - What device (desktop, laptop, tablet, phone, etc.)
    - Is it a shared device or does each user use they're personal device?
    - What's the environment like (noisy, fast-paced, unsecured, etc.)
- Is additional security necessary?
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
