import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/explore_cell.dart';
import 'package:online_groceries_admin/view/category_tab/category_add_screen.dart';
import 'package:online_groceries_admin/view_model/category_view_model.dart';

class CategoryTabScreen extends StatefulWidget {
  const CategoryTabScreen({super.key});

  @override
  State<CategoryTabScreen> createState() => _CategoryTabScreenState();
}

class _CategoryTabScreenState extends State<CategoryTabScreen> {
  final cVM = Get.put(CategoryViewModel());

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
          "Category",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cVM.clear();
              Get.to(() => const CategoryAddScreen());
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
          itemCount: cVM.listArr.length,
          itemBuilder: (context, index) {
            var cObj = cVM.listArr[index];

            return ExploreCell(
              cObj: cObj,
              onPressed: () {},
              onEdit: () {
                cVM.actionEdit(cObj);
              },
              onDelete: () {
                cVM.actionDelete(cObj);
              },
            );
          },
        ),
      ),
    );
  }
}
