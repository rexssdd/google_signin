FIREBASE AUTH / GOOGLE SIGN IN — REPLICATION OF THE SECOND PPT

Based on "Firebase with GoogleSignIn And Email verification.pptx"
Continues the original Firebase Notes CRUD task without redesigning the Notes UI.

lib/
  auth_service.dart  - Google, email/password registration and login, sign out
  register.dart      - Register UI; sendEmailVerification() after registering
  login.dart         - Email/password and Google sign-in UI
  main.dart          - Firebase initialization and auth stream navigation
  home_page.dart     - Original Notes interface, plus logout in the AppBar
  crud_service.dart  - Original Notes Firestore CRUD operations

firebase_options.dart must be generated with: flutterfire configure

As shown in the PPT:
1. Firebase Console > Authentication > Sign-in method: enable Email/Password and Google.
2. For Android, add the app's SHA-1 and SHA-256 fingerprints to Firebase project settings.
   In android/ run: .\gradlew signingReport (Windows).
3. Download updated google-services.json to android/app/.
4. Install dependencies:
   flutter pub add firebase_core cloud_firestore firebase_auth
   flutter pub add google_sign_in:^6.1.0
5. Run flutterfire configure, then flutter run.

NOTICE: Google Sign-In SDK APIs differ across major versions. The slide uses
GoogleSignIn() / signIn(), which matches google_sign_in 6.x, not 7.x.
FlutterFire-generated firebase_options.dart and your project's Firebase setup
cannot be reproduced from the slides alone.

Faithfulness note: Screenshots show portions of source code rather than providing
machine-readable complete files. The UI/feature flow and visible code conventions
were followed; exact source-byte identity cannot be guaranteed.
The PPT does not implement a mandatory email-verified gate; this replica sends
an email verification link but does not add an unrequested gate.
