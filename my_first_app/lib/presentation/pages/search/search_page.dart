import 'package:flutter/material.dart';

enum SearchFilter { users, pets, animalShelter, events }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  SearchFilter _selectedFilter = SearchFilter.users;

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

    // TODO: Replace with actual Firebase search results
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Searching in: $collectionName',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 3, // Placeholder count
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(_getFilterIcon()),
                  title: Text('${collectionName.substring(0, collectionName.length-1)} ${index + 1}'),
                  subtitle: Text('Search result for "${_searchController.text}"'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Navigate to detail page
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
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
  void _performSearch() {
    if (_searchController.text.isEmpty) {
      setState(() {});
      return;
    }

    // TODO: Implement actual Firebase search
    String collection = _getFirebaseCollectionName();
    print('Searching in $collection for: ${_searchController.text}');
    
    setState(() {});
  }

  // Get Firebase collection name
  String _getFirebaseCollectionName() {
    switch (_selectedFilter) {
      case SearchFilter.users:
        return 'users';
      case SearchFilter.pets:
        return 'pets';
      case SearchFilter.animalShelter:
        return 'animal_shelters';
      case SearchFilter.events:
        return 'events';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}