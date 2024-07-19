import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/model/zone_model.dart';
import 'package:online_groceries_admin/view/account_tab/zone/area/area_add_view.dart';
import 'package:online_groceries_admin/view/account_tab/zone/area/area_row.dart';
import 'package:online_groceries_admin/view_model/area_view_model.dart';

class AreaView extends StatefulWidget {
  final ZoneModel obj;
  const AreaView({super.key, required this.obj});

  @override
  State<AreaView> createState() => _AreaViewState();
}

class _AreaViewState extends State<AreaView> {
  final aVM = Get.put(AreaViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aVM.actionLoadList(widget.obj);
  }

  @override
  void dispose() {
    Get.delete<AreaViewModel>(); // TODO: implement dispose
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
          "Area",
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
                AreaAddView(
                  obj: widget.obj,
                ),
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
            () => aVM.listArr.isEmpty
                ? Center(
                    child: Text(
                      "Area is Empty",
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
                      var obj = aVM.listArr[index];

                      return AreaRow(
                        obj: obj,
                        onEdit: () {
                          aVM.actionEdit(obj);
                        },
                        onDelete: () {
                          aVM.actionDelete(obj);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: aVM.listArr.length),
          )
        ],
      ),
    );
  }
}
