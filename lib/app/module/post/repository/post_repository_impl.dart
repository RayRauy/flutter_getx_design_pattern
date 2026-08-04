import 'dart:convert';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:flutter_getx_design_pattern/app/module/post/repository/post_repository.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_create_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_update_request.dart';

import '../../../cores/constants/constant_uri.dart';
import '../../../cores/models/post/Content.dart';
import '../../../cores/models/post/PostResponse.dart';
import '../../../cores/network/api_network_service.dart';

class PostRepositoryImpl extends PostRepository{
  final apiNetWorkService = Get.find<ApiNetworkService>();

  @override
  Future<List<Content>> getAllPost({String? page, String? limit, String? status}) async {
    List<Content> list = [];
    var responseBody = await apiNetWorkService.get(
      "${ConstantUri.listPostPath}?page=${page ?? 0}&size=${limit ?? 10}&status=${status ?? 'ACT'}",
    );
    if(responseBody != null){
      PostResponse postResponse = PostResponse.fromJson(jsonDecode(responseBody));
      if(postResponse.data != null && postResponse.data!.content!.isNotEmpty){
        list = postResponse.data!.content ?? [];
      }
    }
    return list;
  }

  @override
  Future<bool> createPost(PostCreateRequest req) async {
    var responseBody = await apiNetWorkService.post(ConstantUri.listPostPath, req.toJson());
    return responseBody != null;
  }

  @override
  Future<bool> updatePost(int id, PostUpdateRequest req) async {
    var responseBody = await apiNetWorkService.put("${ConstantUri.listPostPath}/$id", req.toJson());
    return responseBody != null;
  }

  @override
  Future<bool> deletePost(int id) async {
    var responseBody = await apiNetWorkService.delete("${ConstantUri.listPostPath}/$id");
    return responseBody != null;
  }
}
