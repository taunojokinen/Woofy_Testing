class FirebaseConstants {
  // Project configuration
  static const String projectId = 'pawpal-da2d9';
  
  // Collection names - matching your Firebase structure
  static const String usersCollection = 'Users'; // Capital U as in your Firebase
  static const String petsCollection = 'Pets'; // Capital P as in your Firebase
  static const String animalSheltersCollection = 'animal_shelters';
  static const String eventsCollection = 'events';
  
  // Field names for Users collection (matching your Firebase structure)
  static const String userField = 'Name'; // Changed from 'User' to 'Name'
  static const String emailField = 'Email';
  static const String mobileNumberField = 'MobileNumber';
  static const String passwordField = 'Password';
  
  // Additional field names for other collections
  static const String nameField = 'name';
  static const String descriptionField = 'description';
  static const String locationField = 'location';
  static const String createdAtField = 'createdAt';
  static const String updatedAtField = 'updatedAt';
  
  // Storage paths
  static const String userImagesPath = 'user_images';
  static const String petImagesPath = 'pet_images';
  static const String shelterImagesPath = 'shelter_images';
  static const String eventImagesPath = 'event_images';
}