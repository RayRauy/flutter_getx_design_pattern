import 'package:flutter/material.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Content.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_update_request.dart';
import 'package:flutter_getx_design_pattern/app/module/post/post_controller.dart';
import 'package:get/get.dart';

class PostUpdateView extends GetView<PostController> {
  PostUpdateView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _categoryIdController = TextEditingController();

  void _initFields(Content post) {
    _titleController.text = post.title ?? "";
    _descriptionController.text = post.description ?? "";
    _imageController.text = post.image ?? "";
    _categoryIdController.text = post.postCategory?.id?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final Content post = Get.arguments;
    _initFields(post);

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
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
                  controller: _imageController,
                  decoration: InputDecoration(labelText: "Image URL"),
                ),
                TextFormField(
                  controller: _categoryIdController,
                  decoration: InputDecoration(labelText: "Category ID"),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var req = PostUpdateRequest(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        image: _imageController.text,
                        categoryId: int.tryParse(_categoryIdController.text),
                      );
                      var success = await controller.updatePost(post.id!, req);
                      if (success) {
                        Get.back();
                        Get.snackbar("Success", "Post updated successfully",
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar("Error", "Failed to update post",
                            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Update"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
