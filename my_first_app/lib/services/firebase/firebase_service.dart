// Uncomment when Firebase packages are added
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/firebase_constants.dart';

class FirebaseService {
  // Uncomment when Firebase packages are installed
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Search methods for different collections
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    print('=== FIREBASE DEBUG START ===');
    print('Firebase search starting for query: "$query"');
    print('Using collection: ${FirebaseConstants.usersCollection}');
    print('Project ID: pawpal-da2d9');
    
    try {
      QuerySnapshot snapshot;
      
      if (query.trim().isEmpty) {
        print('Fetching all users (empty query)');
        // Get all users
        snapshot = await _firestore
            .collection(FirebaseConstants.usersCollection)
            .get(); // Remove limit for empty query to get all users
            
        print('Firebase query successful, found ${snapshot.docs.length} documents');
        
        // Debug: Print first document details if any
        if (snapshot.docs.isNotEmpty) {
          print('First document ID: ${snapshot.docs.first.id}');
          print('First document data: ${snapshot.docs.first.data()}');
        } else {
          print('No documents found - Users collection might be empty');
        }
        
        final results = snapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        }).toList();
        
        print('Returning ${results.length} results');
        print('=== FIREBASE DEBUG END ===');
        
        return results;
      } else {
        print('Searching users with query: $query');
        
        // Firebase text search is limited, so we'll get all documents and filter locally
        // This is acceptable for small datasets (< 1000 users)
        print('Getting all users for local filtering');
        snapshot = await _firestore
            .collection(FirebaseConstants.usersCollection)
            .get();
            
        print('Got ${snapshot.docs.length} total documents, now filtering locally');
        
        // Filter locally for case-insensitive search
        final filteredDocs = snapshot.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final name = (data[FirebaseConstants.userField] ?? '').toString().toLowerCase();
          final email = (data[FirebaseConstants.emailField] ?? '').toString().toLowerCase();
          final searchQuery = query.toLowerCase();
          
          return name.contains(searchQuery) || email.contains(searchQuery);
        }).toList();
        
        // Create a new QuerySnapshot-like structure with filtered results
        print('Found ${filteredDocs.length} matching documents after local filtering');
        
        // Return filtered results
        final results = filteredDocs.map((doc) => {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        }).toList();
        
        print('Returning ${results.length} results');
        print('=== FIREBASE DEBUG END ===');
        
        return results;
      }
      
    } catch (e) {
      print('Error searching users: $e');
      print('Falling back to mock data');
      // Fallback to mock data if Firebase fails
      return _getMockUsers(query);
    }
  }

  Future<List<Map<String, dynamic>>> searchPets(String query) async {
    try {
      // TODO: Implement Firebase search when needed
      return _getMockPets(query);
    } catch (e) {
      print('Error searching pets: $e');
      return _getMockPets(query);
    }
  }

  Future<List<Map<String, dynamic>>> searchAnimalShelters(String query) async {
    try {
      // TODO: Implement Firebase search when needed
      return _getMockShelters(query);
    } catch (e) {
      print('Error searching shelters: $e');
      return _getMockShelters(query);
    }
  }

  Future<List<Map<String, dynamic>>> searchEvents(String query) async {
    try {
      // TODO: Implement Firebase search when needed
      return _getMockEvents(query);
    } catch (e) {
      print('Error searching events: $e');
      return _getMockEvents(query);
    }
  }

  // Mock data methods (remove when Firebase is integrated)
  List<Map<String, dynamic>> _getMockUsers(String query) {
    return [
      {
        'id': '1',
        'User': 'UserTest1',
        'Email': 'UserTest1@gmail.com',
        'MobileNumber': 972555555,
        'Password': 'UserTest1'
      },
      {
        'id': '2', 
        'User': 'UserTest2',
        'Email': 'UserTest2@gmail.com',
        'MobileNumber': 972888888,
        'Password': 'UserTest2'
      },
      {
        'id': '3',
        'User': 'JohnDoe',
        'Email': 'john.doe@gmail.com', 
        'MobileNumber': 972111111,
        'Password': 'JohnDoe123'
      },
      {
        'id': '4',
        'User': 'JaneSmith',
        'Email': 'jane.smith@gmail.com',
        'MobileNumber': 972222222,
        'Password': 'JaneSmith456'
      }
    ].where((user) => 
      query.isEmpty || // Show all users if query is empty
      user['User'].toString().toLowerCase().contains(query.toLowerCase()) ||
      user['Email'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> _getMockPets(String query) {
    return [
      {'id': '1', 'name': 'Buddy', 'species': 'Dog', 'breed': 'Golden Retriever'},
      {'id': '2', 'name': 'Whiskers', 'species': 'Cat', 'breed': 'Persian'},
      {'id': '3', 'name': 'Max', 'species': 'Dog', 'breed': 'German Shepherd'},
    ].where((pet) => 
      query.isEmpty || // Show all pets if query is empty
      pet['name'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> _getMockShelters(String query) {
    return [
      {'id': '1', 'name': 'Happy Paws Shelter', 'location': 'Helsinki'},
      {'id': '2', 'name': 'Pet Haven', 'location': 'Tampere'},
      {'id': '3', 'name': 'Animal Rescue Center', 'location': 'Turku'},
    ].where((shelter) => 
      query.isEmpty || // Show all shelters if query is empty
      shelter['name'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> _getMockEvents(String query) {
    return [
      {'id': '1', 'name': 'Pet Adoption Fair', 'date': '2025-11-15'},
      {'id': '2', 'name': 'Dog Training Workshop', 'date': '2025-11-20'},
      {'id': '3', 'name': 'Cat Care Seminar', 'date': '2025-11-25'},
    ].where((event) => 
      query.isEmpty || // Show all events if query is empty
      event['name'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}