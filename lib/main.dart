import 'package:flutter/material.dart';
import 'package:flutter_getx_design_pattern/app/module/post/post_update_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/login/login_binding.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/login/login_view.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/register/register_binding.dart';
import 'package:flutter_getx_design_pattern/app/module/auth/register/register_view.dart';
import 'package:flutter_getx_design_pattern/app/module/home/home_binding.dart';
import 'package:flutter_getx_design_pattern/app/module/home/home_view.dart';
import 'package:flutter_getx_design_pattern/app/module/post/post_binding.dart';
import 'package:flutter_getx_design_pattern/app/module/post/post_view.dart';
import 'package:flutter_getx_design_pattern/app/module/post/repository/post_repository.dart';
import 'package:flutter_getx_design_pattern/app/module/post/repository/post_repository_impl.dart';
import 'package:flutter_getx_design_pattern/app/module/splash/splash_binding.dart';
import 'package:flutter_getx_design_pattern/app/module/splash/splash_view.dart';

import 'app/cores/network/api_network_service.dart';
import 'app/cores/network/api_network_service_impl.dart';
import 'app/module/auth/repository/auth_repository.dart';
import 'app/module/auth/repository/auth_repository_impl.dart';
import 'app/module/post/post_create_view.dart';

Future<void> main() async {
  await GetStorage.init();

  Get.lazyPut<ApiNetworkService>(()=> ApiNetworkServiceImpl(), fenix: true);
  Get.lazyPut<AuthRepository>(()=> AuthRepositoryImpl(), fenix: true);
  Get.lazyPut<PostRepository>(()=> PostRepositoryImpl(), fenix: true);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Getx Design Pattern',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      //Generate Route
      getPages: [
        GetPage(name: "/", page: ()=> SplashView(), binding: SplashBinding(), transition: Transition.leftToRight),
        GetPage(name: "/home", page: ()=> HomeView(), binding: HomeBinding(), transition: Transition.leftToRight),
        GetPage(name: "/login", page: ()=> LoginView(), binding: LoginBinding(), transition: Transition.leftToRight),
        GetPage(name: "/register", page: ()=> RegisterView(), binding: RegisterBinding(), transition: Transition.leftToRight),
        GetPage(name: "/posts", page: ()=> PostView(), binding: PostBinding(), transition: Transition.leftToRight),
        GetPage(name: "/post-create", page: ()=> PostCreateView(), binding: PostBinding(), transition: Transition.leftToRight),
        GetPage(name: "/post-update", page: ()=> PostUpdateView(), binding: PostBinding(), transition: Transition.leftToRight)
      ],
    );
  }
}