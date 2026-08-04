import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_design_pattern/app/module/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
              ),
              Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.pop(context);
                      Get.toNamed("/posts");
                    },
                    leading: Icon(Icons.post_add, color: Colors.white, size: 32,),
                    title: Text("List Posts", style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.navigate_next, color: Colors.white,),
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
          title: Text("Home Screen", style: TextStyle(color: Colors.white)),
          actions: [IconButton(onPressed: () {
            controller.onLogout();
          }, icon: Icon(Icons.logout))],
        ),
        body: controller.loading.value == false
            ? Text("")
            : Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
      );
    });
  }
}
