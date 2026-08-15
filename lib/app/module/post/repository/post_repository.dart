import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_create_request.dart';
import 'package:flutter_getx_design_pattern/app/cores/models/post/Post_update_request.dart';
import '../../../cores/models/post/Content.dart';

abstract class PostRepository {
  Future<List<Content>> getAllPost({String? page, String? limit, String? status});
  Future<bool> createPost(PostCreateRequest req);
  Future<bool> updatePost(int id, PostUpdateRequest req);
  Future<bool> deletePost(int id);
}