import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/view/account_tab/brand/brand_add_view.dart';
import 'package:online_groceries_admin/view/account_tab/brand/brand_row.dart';
import 'package:online_groceries_admin/view_model/brand_view_model.dart';

class BrandView extends StatefulWidget {
  const BrandView({super.key});

  @override
  State<BrandView> createState() => _BrandViewState();
}

class _BrandViewState extends State<BrandView> {
  final bVM = Get.put(BrandViewModel());

  @override
  void dispose() {
    Get.delete<BrandViewModel>(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 20,
            height: 20,
          ),
        ),
        title: Text(
          "Brands",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.bottomSheet(
                const BrandAddView(),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );

              setState(() {});
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
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(
            () => bVM.listArr.isEmpty
                ? Center(
                  child: Text(
                      "Brand is Empty",
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                )
                : ListView.separated(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    itemBuilder: (context, index) {
                      var obj = bVM.listArr[index];

                      return BrandRow(
                        obj: obj,
                        onEdit: () {
                          bVM.actionEdit(obj);
                        },
                        onDelete: () {
                          bVM.actionDelete(obj);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: bVM.listArr.length),
          )
        ],
      ),
    );
  }
}
