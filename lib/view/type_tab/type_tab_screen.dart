import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/type_cell.dart';
import 'package:online_groceries_admin/view/type_tab/type_add_screen.dart';
import 'package:online_groceries_admin/view_model/type_view_model.dart';

class TypeTabScreen extends StatefulWidget {
  const TypeTabScreen({super.key});

  @override
  State<TypeTabScreen> createState() => _TypeTabScreenState();
}

class _TypeTabScreenState extends State<TypeTabScreen> {
  final tVM = Get.put(TypeViewModel());

  // @override
  // void dispose() {
  //   Get.delete<CategoryViewModel>();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Product Type",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              tVM.clear();
              Get.to(() => const TypeAddScreen());
            },
            icon: Image.asset(
              "assets/img/add.png",
              width: 20,
              height: 20,
              color: TColor.primary,
            ),
          ),
        ],
      ),
      body: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.95,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: tVM.listArr.length,
          itemBuilder: (context, index) {
            var tObj = tVM.listArr[index];

            return TypeCell(
              tObj: tObj,
              onPressed: () {},
              onEdit: () {
                tVM.actionEdit(tObj);
              },
              onDelete: () {
                tVM.actionDelete(tObj);
              },
            );
          },
        ),
      ),
    );
  }
}
