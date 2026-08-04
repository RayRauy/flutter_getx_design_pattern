import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/post/repository/post_repository.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_create_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_update_request.dart';

import '../../cores/models/post/Content.dart';

class PostController extends GetxController{
  final postRepository = Get.find<PostRepository>();
  var loading = false.obs;
  var list = <Content>[].obs;

  void onCreate() {
    Get.toNamed("/post-create");
  }

  void onUpdate(Content post) {
    Get.toNamed("/post-update", arguments: post);
  }

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  void getAllPosts() async{
    loading.value = true;
    var response = await postRepository.getAllPost();
    if(response.isNotEmpty){
      list.value = response;
    }
    loading.value = false;
  }

  Future<bool> createPost(PostCreateRequest req) async {
    loading.value = true;
    var result = await postRepository.createPost(req);
    if (result) {
      getAllPosts(); // Refresh list after create
    }
    loading.value = false;
    return result;
  }

  Future<bool> updatePost(int id, PostUpdateRequest req) async {
    loading.value = true;
    var result = await postRepository.updatePost(id, req);
    if (result) {
      getAllPosts(); // Refresh list after update
    }
    loading.value = false;
    return result;
  }

  Future<bool> deletePost(int id) async {
    loading.value = true;
    var result = await postRepository.deletePost(id);
    if (result) {
      getAllPosts(); // Refresh list after delete
    }
    loading.value = false;
    return result;
  }
}