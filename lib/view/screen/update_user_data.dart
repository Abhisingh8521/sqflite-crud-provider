import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../controller/provider_controller.dart';
import '../../model/user_model.dart';
import '../widegt/form_widget.dart';

class EditUserScreen extends StatefulWidget {
  final UserModel user;

  const EditUserScreen({super.key, required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.user.title);
    _descriptionController =
        TextEditingController(text: widget.user.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Edit User Detils',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/book.png",
                width: 140,
                height: 140,
              ),
              const SizedBox(height: 50),
              CustomTextField(
                controller: _titleController,
                labelText: "Title",
                prefixIcon: Icons.title,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                controller: _descriptionController,
                labelText: "Description",
                prefixIcon: Icons.description,
              ),
              const SizedBox(height: 20.0),
              MaterialButton(
                minWidth: 300,
                height: 50,
                color: Colors.blueAccent,
                shape: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  widget.user.title = _titleController.text;
                  widget.user.description = _descriptionController.text;

                  try {
                    await userProvider.updateUser(widget.user);
                    Fluttertoast.showToast(
                      msg: "User updated successfully!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    print("Failed to update user: $e");
                    Fluttertoast.showToast(
                      msg: "Failed to update user: $e",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
