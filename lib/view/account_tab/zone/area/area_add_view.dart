import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/model/zone_model.dart';
import 'package:online_groceries_admin/view_model/area_view_model.dart';

class AreaAddView extends StatefulWidget {
  final ZoneModel obj;
  final bool isEdit;
  const AreaAddView({super.key,  this.isEdit = false, required this.obj});

  @override
  State<AreaAddView> createState() => _AreaAddViewState();
}

class _AreaAddViewState extends State<AreaAddView> {
  final aVM = Get.put(AreaViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aVM.actionLoadList(widget.obj);
  }

  @override
  void dispose() {
    Get.delete<AreaViewModel>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isEdit ? "Edit Area" : "Add New Area",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () => LineTextField(
                  title: "Area Name",
                  placeholder: "Enter Name",
                  controller: aVM.txtAreaName.value),
            ),
            const SizedBox(
              height: 25,
            ),
            RoundButton(
                title: widget.isEdit ? "Update" : "Add",
                onPressed: () {
                  if (widget.isEdit) {
                    aVM.actionUpdate(() {
                      Navigator.pop(context);
                    });
                  } else {
                    aVM.actionAdd(() {
                      Navigator.pop(context);
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
