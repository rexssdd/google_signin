import 'package:firebase_core/firebase_core.dart';

/// Run `flutterfire configure` to replace this with your project's settings.
/// Alternatively, supply these values using --dart-define.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
    const appId = String.fromEnvironment('FIREBASE_APP_ID');
    const messagingSenderId = String.fromEnvironment(
      'FIREBASE_MESSAGING_SENDER_ID',
    );
    const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
    if (apiKey.isEmpty ||
        appId.isEmpty ||
        messagingSenderId.isEmpty ||
        projectId.isEmpty) {
      throw StateError(
        'Firebase is not configured. Register this app in your Firebase project, '
        'then run flutterfire configure and restart the app.',
      );
    }
    return const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
      storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
      iosBundleId: String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID'),
    );
  }
}
