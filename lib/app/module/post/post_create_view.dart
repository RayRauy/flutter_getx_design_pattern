import 'package:flutter/material.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_create_request.dart';
import 'package:flutter_getx_design_pattern/app/module/post/post_controller.dart';
import 'package:get/get.dart';

class PostCreateView extends GetView<PostController> {
  PostCreateView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _bodyController = TextEditingController();
  final _imageController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Title"),
                  validator: (value) => value == null || value.isEmpty ? "Required" : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  maxLines: 2,
                ),
                TextFormField(
                  controller: _bodyController,
                  decoration: InputDecoration(labelText: "Body"),
                  maxLines: 4,
                ),
                TextFormField(
                  controller: _imageController,
                  decoration: InputDecoration(labelText: "Image URL"),
                ),
                TextFormField(
                  controller: _categoryIdController,
                  decoration: InputDecoration(labelText: "Category ID"),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _tagsController,
                  decoration: InputDecoration(labelText: "Tags (comma separated)"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var req = PostCreateRequest(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        body: _bodyController.text,
                        image: _imageController.text,
                        categoryId: int.tryParse(_categoryIdController.text),
                        tags: _tagsController.text.split(',').map((e) => e.trim()).toList(),
                      );
                      var success = await controller.createPost(req);
                      if (success) {
                        Get.back();
                        Get.snackbar("Success", "Post created successfully",
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar("Error", "Failed to create post",
                            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
