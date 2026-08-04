import 'dart:convert';
import 'dart:ffi';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:flutter_getx_design_pattern/app/module/post/repository/post_repository.dart';

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
}