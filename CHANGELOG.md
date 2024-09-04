## Unreleased

- Added support for handling `logout()` method asynchronously using Kotlin coroutines on Android.
- Ensured `logout()` function, which is a suspend function, is called within a coroutine to avoid errors on Android.
- Implemented error handling for `logout()` on Android to capture and handle exceptions during the logout process.

## Unreleased

* Initial release of `hubspot_flutter`.
* Basic features for initializing HubSpot SDK, opening the chat view, setting user identity, setting chat properties, and logging out (Android only).
* **iOS** support is not yet available.