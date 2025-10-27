import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.user),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit user page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit user functionality coming soon')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User avatar
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  user.user.isNotEmpty ? user.user[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // User details cards
            _buildDetailCard(
              icon: Icons.person,
              title: 'Username',
              value: user.user,
            ),
            const SizedBox(height: 12),
            
            _buildDetailCard(
              icon: Icons.email,
              title: 'Email',
              value: user.email,
            ),
            const SizedBox(height: 12),
            
            _buildDetailCard(
              icon: Icons.phone,
              title: 'Mobile Number',
              value: user.mobileNumber.toString(),
            ),
            const SizedBox(height: 12),
            
            if (user.createdAt != null)
              _buildDetailCard(
                icon: Icons.calendar_today,
                title: 'Member Since',
                value: _formatDate(user.createdAt!),
              ),
            
            const Spacer(),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement call functionality
                      _showCallDialog(context);
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Call'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement email functionality
                      _showEmailDialog(context);
                    },
                    icon: const Icon(Icons.email),
                    label: const Text('Email'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Call User'),
          content: Text('Do you want to call ${user.mobileNumber}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement actual calling functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Calling ${user.mobileNumber}...')),
                );
              },
              child: const Text('Call'),
            ),
          ],
        );
      },
    );
  }

  void _showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Email'),
          content: Text('Do you want to send an email to ${user.email}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement actual email functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening email to ${user.email}...')),
                );
              },
              child: const Text('Email'),
            ),
          ],
        );
      },
    );
  }
}