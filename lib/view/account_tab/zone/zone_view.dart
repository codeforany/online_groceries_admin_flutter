import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/view/account_tab/zone/area/area_view.dart';
import 'package:online_groceries_admin/view/account_tab/zone/zone_add_view.dart';
import 'package:online_groceries_admin/view/account_tab/zone/zone_row.dart';
import 'package:online_groceries_admin/view_model/zone_view_model.dart';

class ZoneView extends StatefulWidget {
  const ZoneView({super.key});

  @override
  State<ZoneView> createState() => _ZoneViewState();
}

class _ZoneViewState extends State<ZoneView> {
  final bVM = Get.put(ZoneViewModel());

  @override
  void dispose() {
    Get.delete<ZoneViewModel>(); // TODO: implement dispose
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
          "Zone",
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
                const ZoneAddView(),
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
                      "Zone is Empty",
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

                      return ZoneRow(
                        obj: obj,
                        onPressed: (){
                          Get.to( () => AreaView(obj: obj) );
                        },
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
