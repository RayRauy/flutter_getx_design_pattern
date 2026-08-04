import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/post/post_controller.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: Text("List Post", style: TextStyle(color: Colors.white)),
        actions: [IconButton(onPressed: () {
          controller.onCreate();
        }, icon: Icon(Icons.add))],
      ),
      body: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: controller.loading.value == true
              ? Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                )
              : ListView.builder(
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    var post = controller.list[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (post.image != null && post.image!.isNotEmpty)
                            Image.network(
                              "${post.image}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${post.title}",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => controller.onUpdate(post),
                                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Post",
                                      middleText: "Are you sure you want to delete this post?",
                                      textConfirm: "Delete",
                                      textCancel: "Cancel",
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors.red,
                                      onConfirm: () async {
                                        Get.back(); // Close dialog
                                        var success = await controller.deletePost(post.id!);
                                        if (success) {
                                          Get.snackbar("Success", "Post deleted successfully",
                                              snackPosition: SnackPosition.BOTTOM);
                                        } else {
                                          Get.snackbar("Error", "Failed to delete post",
                                              snackPosition: SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white);
                                        }
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text(post.description ?? ''),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }
}
