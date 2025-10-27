import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class SearchUsers {
  final UserRepository repository;

  SearchUsers(this.repository);

  Future<List<User>> call(String query) async {
    if (query.trim().isEmpty) {
      return await repository.getAllUsers();
    }
    return await repository.searchUsers(query);
  }
}