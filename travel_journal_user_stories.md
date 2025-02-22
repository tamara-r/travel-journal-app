# Travel Journal App

## User Stories

### **Login & Registration**

**Acceptance Criteria:**
1. The user must enter `email`, `password`, `full name`, `phone number`, and an `optional profile picture`.
2. The password must be at least six characters long.
3. An error message is displayed if required fields are left empty.
4. After submitting the registration form, the user receives a **verification code via SMS**.
5. The user must enter the correct **verification code** to complete registration.
6. If verification is successful, the user is redirected to the `Home Feed` screen.
7. If the verification code is incorrect, an error message is displayed, and the user can request a new code.

**Priority:** High <br>
**Story Points:** 8 <br>
**Notes:**
- Passwords should be encrypted and stored securely.
- Phone number must be **validated** before sending the verification code.
- Consider implementing rate limiting to prevent abuse (e.g., too many code requests).
- Social login can still be considered in the future as an additional option.

---

#### **2️. Account Login**
**Title:**
_As a registered user, I want to log in with my email and password, so that I can access my account and my saved trips._

**Acceptance Criteria:**
1. The user can enter `email` and `password`.
2. If the credentials are incorrect, an error message is displayed.
3. If login is successful, the user is redirected to the `Home Feed`.
4. If the user is already logged in, they should be redirected to the `Home Feed` when opening the app.

**Priority:** High <br>
**Story Points:** 3 <br>
**Notes:**
- Ensure secure authentication using Firebase Auth.

---

#### **3️. Error Handling for Login**
**Title:**
_As a user, I want to receive an error message when I enter incorrect login credentials, so that I know what went wrong._

**Acceptance Criteria:**
1. If the email is not found, display `"This account does not exist."`
2. If the password is incorrect, display `"Invalid email or password."`
3. If the user tries to log in with an empty email or password field, display `"Please enter your email and password."`

**Priority:** Medium <br>
**Story Points:** 2 <br>
**Notes:**
- Implement a **Show Password** toggle for better usability.

---

#### **4️. Password Recovery**
**Title:**
_As a user, I want to reset my password if I forget it, so that I can regain access to my account._

**Acceptance Criteria:**
1. The user can click `"Forgot Password?"` and enter their email.
2. If the email exists, a `password reset link` is sent.
3. If the email is invalid, display `"No account found with this email."`
4. After submitting the reset request, display `"Check your email for reset instructions."`

**Priority:** High <br>
**Story Points:** 3 <br>
**Notes:**
- Consider adding an option for resetting passwords via phone number in the future.

---

#### **5️. Persistent Login**
**Title:**
_As a returning user, I want my login session to persist so that I don’t have to log in every time I open the app._

**Acceptance Criteria:**
1. The user stays logged in by default unless they manually log out.
2. If the user logs out, they are redirected to the `Login screen`.
3. Use **local storage** or an appropriate authentication state method for session persistence.

**Priority:** High <br>
**Story Points:** 4 <br>
**Notes:**
- Implement Firebase Auth built-in session persistence.
- Ensure that login state remains valid even after app restarts.

---

#### **6️. Logout**
**Title:**
_As a user, I want to be able to log out of my account._

**Acceptance Criteria:**
1. The user can log out from the `Settings` screen.
2. After logging out, the user is redirected to the `Login screen`.
3. All locally stored session data is cleared upon logout.

**Priority:** High <br>
**Story Points:** 2 <br>
**Notes:**
- Adding a confirmation dialog before logging out to prevent accidental logouts.
- Ensure that authentication tokens are cleared.

---

### **Home Feed**

The **Home Feed** is where users can discover, browse, and filter travel entries shared by others.

---

#### **1️. View Latest Shared Journeys**
**Title:**
_As a user, I want to see the latest shared travel experiences on my home feed so that I can explore new destinations and get inspiration._

**Acceptance Criteria:**
1. The home feed displays a list of recently shared journeys.
2. Each journey entry includes a `title`, `cover image`, `location (country/continent)`, `short description`, and `author name`.
3. Entries are sorted from `newest to oldest`.
4. Clicking on an entry navigates to the `Journey Details` screen.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Consider implementing pagination for performance optimization.

---

#### **2️. Filter Journeys by Continent or Country**
**Title:**
_As a user, I want to filter journeys by continent or country so that I can find travel experiences relevant to my interests._

**Acceptance Criteria:**
1. Users can select a `continent` from a dropdown to filter journeys.
2. Users can further refine the search by selecting a `specific country`.
3. The home feed updates in real-time to show only relevant journeys.
4. A `Clear Filters` button resets all filters and displays all journeys again.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Consider implementing autocomplete search for faster country selection.
- Store the last selected filter to persist when the user returns.

---

#### **3️. Search for a Journey by Title or Keyword**
**Title:**
_As a user, I want to search for journeys by title or keyword so that I can quickly find specific travel stories._

**Acceptance Criteria:**
1. A search bar is available at the top of the home feed.
2. Users can enter a `title`, `location`, or `keyword` related to a journey.
3. The search results dynamically update as the user types.
4. Clicking a search result navigates to the `Journey Details` screen.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Optimize API calls (e.g. use debouncing).

---

#### **4️. View Trending Destinations**
**Title:**
_As a user, I want to see a section for trending destinations so that I can explore the most popular travel spots._

**Acceptance Criteria:**
1. The **Trending Destinations** section displays a list of countries with the most shared journeys.
2. Each destination card includes the `country name`, `flag`, and the `number of journeys`.
3. Clicking on a destination applies a filter to show only journeys from that country within the Home Feed.

**Priority:** Medium <br>
**Story Points:** 5 <br>
**Notes:**
- Trending destinations should be determined based on a defined threshold (e.g., a country appears in X number of journeys within a set time frame).
- When a user clicks a Trending Destination, it will apply a filter in the Home Feed instead of opening a new page.
- Consider adding a Clear Filter button when filtering is active.

---

#### **5️. Save a Journey for Later (Favourites Tab)**
**Title:**
_As a user, I want to save a journey to a favourites list so that I can revisit it later._

**Acceptance Criteria:**
1. Each journey entry has a `Save` button (e.g., a heart or bookmark icon).
2. Clicking the button adds the journey to the `Favourites tab` on the Home screen.
3. Clicking again removes it from the saved list.
4. Saved journeys persist across app sessions.

**Priority:** Medium <br>
**Story Points:** 4 <br>
**Notes:**
- The Home screen will have tab navigation: `All Journeys` | `Favourites`.
- Consider storing saved journeys in local storage for offline access.

---


### **Journey Details**

The **Journey Details** screen allows users to view an individual trip with full details, including text, images, AI-powered summaries, and geolocation.

#### **1️. View Full Journey Details**
**Title:**
_As a user, I want to view the full details of a journey so that I can learn more about the trip._

**Acceptance Criteria:**
1. The user can see the 'author's name', `title`, `cover image`, and `date` of the journey.
2. The journey includes a `text description`, AI-generated `summary`, and `tags`.
3. Users can see `all uploaded images` in a gallery format.
4. The journey displays `country & continent information`.
5. A button allows users to `view the journey location on a map`.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Consider implementing offline access for previously viewed journeys.
- Consider implementing share option for each
- For now, clicking the author's name will not open a profile preview.

---

#### **2️. View Journey Location on a Map**
**Title:**
_As a user, I want to see the journey's location on a map so that I can visualize where it took place._

**Acceptance Criteria:**
1. A `"View on Map"` button is available in the Journey Details screen.
2. Clicking the button `opens a Google Maps modal` with a `pinned location`.
3. The user can `close the map` to return to the Journey Details screen.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- The map should open in a modal instead of navigating to another screen.
- Clicking the pin could allow for zooming in on the location.
- Consider allowing users to copy the location or open it in Google Maps externally.

---

#### **3️. View Additional Travel Notes (AI-Powered Tips & Tricks)**
**Title:**
_As a user, I want to see AI-powered travel tips and tricks related to a journey so that I can get useful insights._

**Acceptance Criteria:**
1. Below the journey description, there is a `section for AI-generated travel tips`.
2. Tips are `automatically generated` based on the journey's details.
3. Users can view `at least three relevant travel tips`.
4. If AI tips are not available, the section remains hidden.

**Priority:** Medium <br>
**Story Points:** 5 <br>
**Notes:**
- Use OpenAI API or a similar service to generate tips dynamically.
- Consider a "Regenerate Tips" button if users want to see different suggestions.

---

#### **4️. Browse Travel Photos in a Gallery**
**Title:**
_As a user, I want to browse a gallery of images from the journey so that I can see the trip visually._

**Acceptance Criteria:**
1. Users can see `thumbnail previews` of all uploaded images.
2. Clicking on an image opens it in a `full-screen gallery mode`.
3. Users can `swipe left or right` to navigate between images.
4. The gallery should allow `zooming in on photos`.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Ensure smooth transitions and loading performance for images.
- Ensure that images are properly formatted.
- Apply lazy loading to improve performance.

---

#### **5. Edit an Existing Journey**
**Title:**
_As a user, I want to edit my journey details so that I can update or correct my travel experiences._

**Acceptance Criteria:**
1. Users can `edit a journey` from either the `Profile page (dropdown)` or `Journey Details page`.
2. Users can `update the title, description, images, and location`.
3. Users can `toggle a journey between public and private` at any time.
4. Users can `publish a draft journey`.
5. Changes are saved and reflected immediately.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Drafts remain private until published.
- Published journeys can switch between public and private anytime.

---

#### **6. Delete a Journey**
**Title:**
_As a user, I want to delete my journey so that I can remove it permanently._

**Acceptance Criteria:**
1. Users can access a `delete option` from the `Profile page (dropdown)` or `Journey Details page`.
2. Clicking delete `opens a confirmation dialog`:
   - `"Are you sure you want to delete this journey? This action cannot be undone."`
3. If confirmed, the journey is `permanently removed`.

**Priority:** High <br>
**Story Points:** 3 <br>
**Notes:**
- Deletion is irreversible (no restore from trash option).

---

#### **7. Toggle Journey Visibility**
**Title:**
_As a user, I want to change my journey between public and private so that I control who can see it._

**Acceptance Criteria:**
1. Users can `toggle visibility (public/private)` from the `Profile page (dropdown)` or `Journey Details page`.
2. If set to `private`, the journey is only visible to the user.
3. If set to `public`, it appears on the Home Feed.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Journeys can switch between public and private at any time.

---

### **User Profile**
The **User Profile** screen allows users to view and edit their personal information, see their shared journeys, and manage their travel history.

#### **1️. View & Edit Profile Information**
**Title:**
_As a user, I want to view and edit my profile details so that I can update my personal information._

**Acceptance Criteria:**
1. Users can see their `profile picture`, `full name`, `username`, `bio`, and `phone number`.
2. Users can `edit` any of these fields.
3. Clicking `Save` updates the profile and reflects changes immediately.
4. Users can `upload or change their profile picture`.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Consider validating username uniqueness before saving.
- Consider adding filters for shared journeys (e.g., private, shared, by country, etc.).
---

#### **2️. View My Shared Journeys**
**Title:**
_As a user, I want to see a list of all my shared journeys so that I can keep track of my past trips._

**Acceptance Criteria:**
1. Users can see a `list of journeys they have shared`.
2. Each journey displays its `title`, `date`, `cover image`, and `country`.
3. Clicking on a journey `opens the Journey Details screen`.

**Priority:** High <br>
**Story Points:** 3 <br>
**Notes:**
- The list should be sorted by most recent first.
- Consider adding filters for list of journeys.

---

### **Add Journey User Stories**

The `Add Journey` screen allows users to document their travel experiences with details like text, images, geolocation, and privacy settings.

#### **1️ Create a New Journey**
**Title:**
_As a user, I want to add a new journey so that I can document my travel experience._

**Acceptance Criteria:**
1. Users can enter a `title`, `text description`, and optional `tags`.
2. Users can `upload multiple images` for the journey.
3. Users can select a `country` and `continent` from a dropdown.
4. Users can `set the journey as personal (private) or public`.
5. A `"Save"` button saves the journey, and public journeys appear on the Home Feed.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Private journeys will be visible only to the user in their profile.
- Public journeys appear on the Home Feed and can be discovered by others.
- Consider video uploads.

---

#### **2️. Set Journey Location on a Map**
**Title:**
_As a user, I want to tag my journey with a location on a map so that I can geotag my travels._

**Acceptance Criteria:**
1. Users can **select a location** using `Google Maps`.
2. Users can **adjust the map pin** to set an exact location.
3. The location appears in the journey details once saved.

**Priority:** Medium <br>
**Story Points:** 4 <br>
**Notes:**
- The map should open in a modal instead of a separate screen.
- Consider allowing users to copy the location or open it externally in Google Maps.

---

#### **3️. AI-Generated Summary & Tags**
**Title:**
_As a user, I want AI to generate a summary and relevant tags for my journey so that I can describe it better._

**Acceptance Criteria:**
1. Users can `click a button` to generate a summary using AI.
2. AI extracts `keywords/tags` based on the journey text.
3. Users can edit or remove AI-generated tags before saving.

**Priority:** Medium <br>
**Story Points:** 5 <br>
**Notes:**
- Use OpenAI API or a similar model for summaries.
- Ensure AI-generated text is editable before saving.

---

#### **4️. Upload Travel Photos**
**Title:**
_As a user, I want to upload multiple travel photos to my journey so that I can visually document my experience._

**Acceptance Criteria:**
1. Users can `upload multiple images` at once.
2. Users can `preview and delete` images before saving.
3. The uploaded images are `stored securely`.
4. The first uploaded image becomes the `cover image`.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Consider image compression to reduce file size.
- Allow drag-and-drop image uploads (optional).

---

#### **5️. Save & Publish Journey**
**Title:**
_As a user, I want to save my journey as a draft or publish it immediately so that I can complete it later._

**Acceptance Criteria:**
1. Users can choose to `save the journey as a draft` or publish it.
2. Drafts are `only visible` to the user.
3. Once published, `public journeys` appear on the Home Feed.

**Priority:** High <br>
**Story Points:** 4 <br>
**Notes:**
- Consider implementation of an autosave.
- Users should be able to `edit and publish a draft later`.

---


### **Report Page**

#### **1. View Travel Statistics**
**Title:**
_As a user, I want to see an overview of my travel progress so that I can track the places I’ve explored._

**Acceptance Criteria:**
1. The Report Page displays the total number of journeys created.
2. The user can see the number of countries they have visited.
3. The user can see the number of continents they have explored.
4. The data updates automatically when a new journey is added.

**Priority:** Medium <br>
**Story Points:** 4 <br>
**Notes:**
- Consider adding visual charts or graphs to represent progress.
- Consider displaying the most frequently visited country.
- Consider adding badges or achievements for milestones (e.g., "Visited 10 Countries!").
- Future updates could include a map visualization with highlighted visited countries.

---

### **Settings Menu**

#### **1️. Access Settings Menu**
**Title:**
_As a user, I want to access the settings menu so that I can manage my account and preferences._

**Acceptance Criteria:**
1. Users can access the `Settings menu` from the `Profile page`.
2. The menu includes the following options:
   - `Edit Profile`
   - `Manage Notifications`
   - `Delete Account`
3. Tapping any option **navigates to the corresponding settings screen**.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Consider adding a Privacy Settings.

---

### **Settings**

#### **1️. Update Profile Information**
**Title:**
_As a user, I want to update my profile details so that I can customize my account information._

**Acceptance Criteria:**
1. Users can update `name`, `username`, `email`, and `profile picture`.
2. Clicking `"Save"` updates and reflects changes immediately.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Consider validating **username uniqueness** before saving.

---

#### **2️. Manage Notification Preferences**
**Title:**
_As a user, I want to manage my notification settings so that I can control when and how I receive reminders._

**Acceptance Criteria:**
1. Users can `enable or disable` notifications.
2. Users can set `reminder times` (`morning`, `afternoon`, `evening`).
3. Users receive a notification `only for selected time slots`.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Consider adding a weekly summary notification.

---

#### **3️. Delete My Account**
**Title:**
_As a user, I want to delete my account so that I can remove my data from the app._

**Acceptance Criteria:**
1. Users can access a `"Delete Account"` option from Settings.
2. Clicking delete opens a confirmation dialog
3. If confirmed, the user’s account is permanently deleted.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Ensure deletion is irreversible with a warning message - `"Are you sure? This will permanently delete your account and data."`.
- Maybe require password confirmation before deletion.

---

### **Notifications**

#### **1️. Receive Daily Travel Inspiration Notification**
**Title:**
_As a user, I want to receive a daily travel inspiration notification so that I can stay engaged with new journeys._

**Acceptance Criteria:**
1. Users receive a `daily notification` featuring a random public journey from the Home Feed.
2. The notification includes the `journey title` and `author name`.
3. Tapping the notification opens the Journey Details screen.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Consider allowing users to disable this notification in Settings.

---

#### **2️. Get Notified When a New Story is Published**
**Title:**
_As a user, I want to receive a notification when a new journey is published so that I can stay updated on recent travels._

**Acceptance Criteria:**
1. Users receive a notification when a new public journey is published.
2. The notification includes the `journey title` and `author name`.
3. Tapping the notification opens the Journey Details screen.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Consider limiting notifications to one per day max to avoid spam.

---

#### **3️. Reminder to Log a New Journey**
**Title:**
_As a user, I want to receive a reminder to log my travels so that I don’t forget to document my experiences._

**Acceptance Criteria:**
1. Users receive a reminder notification once per week if they haven’t logged a journey in the last 7 days.
2. The notification says:
   - `"Haven't logged a journey recently? Add your latest trip now!"`
3. Tapping the notification opens the Add Journey screen.

**Priority:** Medium <br>
**Story Points:** 3 <br>
**Notes:**
- Allow users to disable this notification in Settings.

---

### **Integrate Persistent Data**
**Title:**
_As a user, I want my data to be saved persistently so that I don’t lose my journeys and settings._

**Acceptance Criteria:**
1. User data (journeys, profile details, preferences) is stored in `Firebase Firestore`.
2. Journeys remain accessible even after app restarts.
3. Changes to settings (e.g., notification preferences) are saved persistently.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Firebase Firestore will be used for real-time cloud storage

---

### **Integrate External APIs**
**Title:**
_As a user, I want the app to use external APIs so that I can enhance my travel experience._

**Acceptance Criteria:**
1. `Google Maps API` is integrated for journey location tagging.
2. `OpenAI API` is used to generate journey summaries and travel tips.
3. API responses are handled properly, ensuring smooth UX.

**Priority:** High <br>
**Story Points:** 5 <br>
**Notes:**
- Google Maps API is used for geolocation and map visualization.
- OpenAI API is used for AI-powered text processing (summaries, tags, tips).

---
