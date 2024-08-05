import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider_controller.dart';
import '../../../model/user_model.dart';
import '../../widegt/form_widget.dart';

class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.blueAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Add Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Image.asset(
                    "assets/images/book.png",
                    width: 140,
                    height: 140,
                  ),
                  SizedBox(height: 50),
                  CustomTextField(
                    controller: titleController,
                    labelText: "Title",
                    prefixIcon: Icons.title,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    labelText: "Description",
                    prefixIcon: Icons.description,
                  ),
                  SizedBox(height: 16.0),
                  MaterialButton(
                    minWidth: 300,
                    height: 50,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blueAccent,
                    onPressed: () {
                      final title = titleController.text.trim();
                      final description = descriptionController.text.trim();

                      if (title.isEmpty || description.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Please fill all fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white
                          ,
                          fontSize: 16.0,
                        );
                      } else {
                        final userModel = UserModel(
                          title: title,
                          description: description,
                        );

                        Provider.of<UserProvider>(context, listen: false)
                            .addUser(userModel);
                        Get.back();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
