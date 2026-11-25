# Firebase with Cloudinary

This Flutter app stores items in Firestore and uploads an optional item image to Cloudinary. The image's secure URL is saved in the item's `image_url` field and displayed beside the item. Existing items without an image still display normally.

## Cloudinary setup

1. In Cloudinary, find your **cloud name** on the dashboard.
2. In **Settings → Upload → Upload presets**, create an **unsigned** upload preset. Do not put an API secret in the Flutter app.
3. Copy `cloudinary.example.json` to `cloudinary.json` and fill in your cloud name and unsigned preset. `cloudinary.json` is ignored by Git.
4. Run the app with the configuration:

   ```sh
   flutter run --dart-define-from-file=cloudinary.json
   ```

In the add dialog, select **Upload Image** to choose and upload an image. Once it appears in the preview, save the item to write the Cloudinary URL to Firestore. An image is optional.
