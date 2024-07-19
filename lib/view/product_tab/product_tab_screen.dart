import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/product_cell.dart';
import 'package:online_groceries_admin/view/offer_tab/offer_add_screen.dart';
import 'package:online_groceries_admin/view/product_tab/product_add_screen.dart';
import 'package:online_groceries_admin/view_model/product_view_model.dart';

class ProductTabScreen extends StatefulWidget {
  const ProductTabScreen({super.key});

  @override
  State<ProductTabScreen> createState() => _ProductTabScreenState();
}

class _ProductTabScreenState extends State<ProductTabScreen> {
  var pVM = Get.put(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Product List",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Get.to(() => const ProductAddScreen());
              },
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: TColor.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/img/add.png",
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => GridView.builder(
          itemCount: pVM.listArr.length,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 2,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            var obj = pVM.listArr[index];

            return ProductCell(
              pObj: obj,
              onPressed: () async {
                await Get.to(() => OfferAddScreen(obj: obj));
                pVM.apiList();
              },
              onEdit: () {
                pVM.actionEdit(obj);
              },
              onDelete: () {
                pVM.actionDelete(obj);
              },
            );
          },
        ),
      ),
    );
  }
}
