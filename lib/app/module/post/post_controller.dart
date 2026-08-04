import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/post/repository/post_repository.dart';

import '../../cores/models/post/Content.dart';

class PostController extends GetxController{
  final postRepository = Get.find<PostRepository>();
  var loading = false.obs;
  var list = <Content>[].obs;

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
}