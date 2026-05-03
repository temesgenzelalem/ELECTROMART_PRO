import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers.dart';
import '../models/user_model.dart';

class ManageCustomersScreen extends ConsumerWidget {
  const ManageCustomersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersStreamProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF031427),
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        title: Row(
          children: const [
            Icon(Icons.people, color: Colors.blue),
            SizedBox(width: 8),
            Text('Manage Customers'),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => context.go('/admin-dashboard'),
        ),
      ),
      body: usersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Text('No customers found', style: TextStyle(color: Colors.white)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                color: Colors.black.withValues(alpha: 0.4),
                child: ListTile(
                  title: Text(user.email, style: const TextStyle(color: Colors.white)),
                  subtitle: user.name.isNotEmpty
                      ? Text(user.name, style: const TextStyle(color: Colors.grey))
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(context, ref, user),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.blue)),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, UserModel user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B2B3F),
        title: const Text('Delete Customer', style: TextStyle(color: Colors.white)),
        content: Text('Are you sure you want to delete ${user.email}?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(firestoreServiceProvider).deleteUser(user.id);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
