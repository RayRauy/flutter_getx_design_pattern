import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          backgroundColor: Colors.blueAccent,
          title: Text("Home Screen", style: TextStyle(color: Colors.white),
          ),
          actions: [

            IconButton(onPressed: (){
              controller.onLogout();
            }, icon: Icon(Icons.logout))
          ],
        ),
        body:
        controller.loading.value == false? Text(""):
        Center(
          child: CircularProgressIndicator(
            color: Colors.cyan,
          ),
        )
        ,
      );
    });
  }

}
