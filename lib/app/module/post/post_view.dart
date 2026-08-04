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
                    return Container(
                      child: Column(
                        children: [
                          Image.network("${post.image}"),
                          Text("${post.title}"),
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
