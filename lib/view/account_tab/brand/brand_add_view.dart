import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/view_model/brand_view_model.dart';

class BrandAddView extends StatefulWidget {
  final bool isEdit;
  const BrandAddView({super.key, this.isEdit = false});

  @override
  State<BrandAddView> createState() => _BrandAddViewState();
}

class _BrandAddViewState extends State<BrandAddView> {
  final bVM = Get.put(BrandViewModel());

  @override
  void dispose() {
    Get.delete<BrandViewModel>();
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
              widget.isEdit ? "Edit Brand" : "Add New Brand",
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
                  title: "Brand Name",
                  placeholder: "Enter Name",
                  controller: bVM.txtBrandName.value),
            ),
            const SizedBox(
              height: 25,
            ),
            RoundButton(
                title: widget.isEdit ? "Update" : "Add",
                onPressed: () {
                  if (widget.isEdit) {
                    bVM.actionUpdate(() {
                      Navigator.pop(context);
                    });
                  } else {
                    bVM.actionAdd(() {
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
