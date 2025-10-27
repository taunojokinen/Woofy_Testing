import 'package:flutter/material.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../data/models/user_model.dart';
import '../user/user_detail_page.dart';

enum SearchFilter { users, pets, animalShelter, events }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  SearchFilter _selectedFilter = SearchFilter.users;
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load initial data when page opens
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search input field
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Enter search term...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _performSearch();
              },
            ),
            const SizedBox(height: 20),
            
            // Filter section
            const Text(
              'Search in:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Filter chips
            Wrap(
              spacing: 8.0,
              children: [
                _buildFilterChip(
                  label: 'Users',
                  icon: Icons.person,
                  filter: SearchFilter.users,
                ),
                _buildFilterChip(
                  label: 'Pets',
                  icon: Icons.pets,
                  filter: SearchFilter.pets,
                ),
                _buildFilterChip(
                  label: 'Animal Shelters',
                  icon: Icons.home,
                  filter: SearchFilter.animalShelter,
                ),
                _buildFilterChip(
                  label: 'Events',
                  icon: Icons.event,
                  filter: SearchFilter.events,
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Results section
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Back to Home',
        child: const Icon(Icons.home),
      ),
    );
  }

  // Helper method to build filter chips
  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required SearchFilter filter,
  }) {
    final isSelected = _selectedFilter == filter;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = filter;
        });
        _performSearch();
      },
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  // Helper method to build search results
  Widget _buildSearchResults() {
    String collectionName = _getCollectionName();
    
    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getFilterIcon(),
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Search in $collectionName',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter a search term to find results',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term in $collectionName',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Found ${_searchResults.length} results in $collectionName',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final result = _searchResults[index];
              return Card(
                child: ListTile(
                  leading: Icon(_getFilterIcon()),
                  title: Text(_getTitle(result)),
                  subtitle: Text(_getSubtitle(result)),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    if (_selectedFilter == SearchFilter.users) {
                      // Navigate to user detail page
                      final user = UserModel.fromJson(result);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailPage(user: user),
                        ),
                      );
                    } else {
                      // TODO: Navigate to other detail pages
                      print('Tapped on: ${_getTitle(result)}');
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getTitle(Map<String, dynamic> result) {
    switch (_selectedFilter) {
      case SearchFilter.users:
        return result['Name'] ?? result['User'] ?? 'Unknown User'; // Support both field names
      case SearchFilter.pets:
        return result['name'] ?? 'Unknown Pet';
      case SearchFilter.animalShelter:
        return result['name'] ?? 'Unknown Shelter';
      case SearchFilter.events:
        return result['name'] ?? 'Unknown Event';
    }
  }

  String _getSubtitle(Map<String, dynamic> result) {
    switch (_selectedFilter) {
      case SearchFilter.users:
        return result['Email'] ?? '';
      case SearchFilter.pets:
        return '${result['species']} - ${result['breed']}';
      case SearchFilter.animalShelter:
        return result['location'] ?? '';
      case SearchFilter.events:
        return result['date'] ?? '';
    }
  }

  // Get collection name based on selected filter
  String _getCollectionName() {
    switch (_selectedFilter) {
      case SearchFilter.users:
        return 'Users';
      case SearchFilter.pets:
        return 'Pets';
      case SearchFilter.animalShelter:
        return 'Animal Shelters';
      case SearchFilter.events:
        return 'Events';
    }
  }

  // Get icon based on selected filter
  IconData _getFilterIcon() {
    switch (_selectedFilter) {
      case SearchFilter.users:
        return Icons.person;
      case SearchFilter.pets:
        return Icons.pets;
      case SearchFilter.animalShelter:
        return Icons.home;
      case SearchFilter.events:
        return Icons.event;
    }
  }

  // Perform search based on selected filter
  void _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> results;
      String query = _searchController.text; // Allow empty queries to show all mock data

      switch (_selectedFilter) {
        case SearchFilter.users:
          results = await _firebaseService.searchUsers(query);
          break;
        case SearchFilter.pets:
          results = await _firebaseService.searchPets(query);
          break;
        case SearchFilter.animalShelter:
          results = await _firebaseService.searchAnimalShelters(query);
          break;
        case SearchFilter.events:
          results = await _firebaseService.searchEvents(query);
          break;
      }

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Search failed: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}