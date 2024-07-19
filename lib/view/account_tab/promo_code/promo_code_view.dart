import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/promo_code_row.dart';
import 'package:online_groceries_admin/view_model/promo_code_view_model.dart';

class PromoCodeView extends StatefulWidget {
  const PromoCodeView({super.key});

  @override
  State<PromoCodeView> createState() => _PromoCodeViewState();
}

class _PromoCodeViewState extends State<PromoCodeView> {
  final promoVM = Get.put(PromoCodeViewModel());

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   Get.delete<PromoCodeViewModel>();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promoVM.apiList();
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
          "Promo Code",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              promoVM.actionOpenAddNew();
                
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
      body: Obx(() => promoVM.listArr.isEmpty
          ? Center(
              child: Text(
                "No Any Promo Code Available",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              itemBuilder: (context, index) {
                var obj = promoVM.listArr[index];
                return PromoCodeRow(
                  pObj: obj,
                  onTap: () {},
                  onDelete: () {
                    promoVM.actionDelete(obj);
                  },
                  onEdit: () {
                    promoVM.actionEdit(obj);
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black12,
                height: 1,
              ),
              itemCount: promoVM.listArr.length,
            )),
    );
  }
}
