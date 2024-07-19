import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/offer_product_cell.dart';
import 'package:online_groceries_admin/view_model/offer_view_model.dart';

class OfferTabScreen extends StatefulWidget {
  const OfferTabScreen({super.key});

  @override
  State<OfferTabScreen> createState() => _OfferTabScreenState();
}

class _OfferTabScreenState extends State<OfferTabScreen> {
  var pVM = Get.put(OfferViewModel());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pVM.apiList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    Get.delete<OfferViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Offer List",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => pVM.listArr.isEmpty
            ? Center(
                child: Text(
                  " No Offer",
                  style: TextStyle(
                    color: TColor.placeholder,
                    fontSize: 20,
                  ),
                ),
              )
            : GridView.builder(
                itemCount: pVM.listArr.length,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  var obj = pVM.listArr[index];

                  return OfferProductCell(
                    pObj: obj,
                    onPressed: () {},
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
