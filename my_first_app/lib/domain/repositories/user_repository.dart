import '../entities/user.dart';

abstract class UserRepository {
  // Get all users
  Future<List<User>> getAllUsers();
  
  // Search users by query (username or email)
  Future<List<User>> searchUsers(String query);
  
  // Get user by ID
  Future<User?> getUserById(String id);
  
  // Get user by email
  Future<User?> getUserByEmail(String email);
  
  // Create new user
  Future<String> createUser(User user);
  
  // Update user
  Future<void> updateUser(User user);
  
  // Delete user
  Future<void> deleteUser(String id);
  
  // Check if email exists
  Future<bool> emailExists(String email);
  
  // Authenticate user
  Future<User?> authenticateUser(String email, String password);
}