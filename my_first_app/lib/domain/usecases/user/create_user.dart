import '../../entities/user.dart';
import '../../repositories/user_repository.dart';
import '../../../core/errors/exceptions.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<String> call(User user) async {
    // Validate user data
    if (user.user.trim().isEmpty) {
      throw ValidationException('Username cannot be empty');
    }
    
    if (user.email.trim().isEmpty) {
      throw ValidationException('Email cannot be empty');
    }
    
    if (user.password.trim().isEmpty) {
      throw ValidationException('Password cannot be empty');
    }
    
    // Check if email already exists
    final emailExists = await repository.emailExists(user.email);
    if (emailExists) {
      throw ValidationException('Email already exists');
    }
    
    // Create user
    return await repository.createUser(user);
  }
}