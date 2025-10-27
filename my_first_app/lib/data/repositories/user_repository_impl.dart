import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../services/firebase/firebase_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseService firebaseService;

  UserRepositoryImpl(this.firebaseService);

  @override
  Future<List<User>> getAllUsers() async {
    try {
      final usersData = await firebaseService.searchUsers(''); // Empty query gets all
      return usersData.map((userData) => UserModel.fromJson(userData)).toList();
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    try {
      final usersData = await firebaseService.searchUsers(query);
      return usersData.map((userData) => UserModel.fromJson(userData)).toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  @override
  Future<User?> getUserById(String id) async {
    try {
      // TODO: Implement when Firebase is integrated
      final allUsers = await getAllUsers();
      return allUsers.where((user) => user.id == id).firstOrNull;
    } catch (e) {
      throw Exception('Failed to get user by ID: $e');
    }
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    try {
      final allUsers = await getAllUsers();
      return allUsers.where((user) => user.email == email).firstOrNull;
    } catch (e) {
      throw Exception('Failed to get user by email: $e');
    }
  }

  @override
  Future<String> createUser(User user) async {
    try {
      // TODO: Implement actual Firebase creation
      // For now, simulate creation
      final newId = DateTime.now().millisecondsSinceEpoch.toString();
      return newId;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      // TODO: Implement when Firebase is integrated
      throw UnimplementedError('Update user not implemented yet');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      // TODO: Implement when Firebase is integrated
      throw UnimplementedError('Delete user not implemented yet');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<bool> emailExists(String email) async {
    try {
      final user = await getUserByEmail(email);
      return user != null;
    } catch (e) {
      throw Exception('Failed to check if email exists: $e');
    }
  }

  @override
  Future<User?> authenticateUser(String email, String password) async {
    try {
      final user = await getUserByEmail(email);
      if (user != null && user.password == password) {
        return user;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to authenticate user: $e');
    }
  }
}