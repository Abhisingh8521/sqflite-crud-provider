import 'package:flutter/material.dart';
import 'package:flutter_learn/view/screen/update_user_data.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider_controller.dart';
import '../../../model/user_model.dart';
import '../add_data/add_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );

          userProvider.notifyListeners();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) {
          return FutureBuilder<List<UserModel>>(
            future: provider.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final users = snapshot.data ?? [];
                if (users.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Dismissible(
                            key: Key(user.id.toString()),
                            onDismissed: (direction) {
                              userProvider.deleteUser(user.id!);
                            },
                            background: Container(color: Colors.red),
                            child: ListTile(
                              title: Text(
                                ' ${user.title}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              subtitle: Text(
                                ' ${user.description}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: "edit",
                                    child: Text("edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: "delete",
                                    child: Text("delete"),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == "edit") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditUserScreen(user: user),
                                      ),
                                    );
                                  } else if (value == "delete") {
                                    userProvider.deleteUser(user.id!);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}