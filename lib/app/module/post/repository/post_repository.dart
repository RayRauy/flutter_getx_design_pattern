import 'dart:ffi';

import 'package:flutter_getx_design_pattern/app/cores/models/post/PostResponse.dart';

import '../../../cores/models/post/Content.dart';

abstract class PostRepository {
  Future<List<Content>> getAllPost({String? page, String? limit, String? status});
}