import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/my_order_row.dart';
import 'package:online_groceries_admin/view/order_tab/order_detail_screen.dart';
import 'package:online_groceries_admin/view_model/order_view_model.dart';

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({super.key});

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final oVM = Get.find<OrderViewModel>();

    return Scaffold(
      body: Obx(
        () => oVM.completeOrderArr.isEmpty
            ? Center(
                child: Text(
                  "No Order",
                  style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                itemBuilder: (context, index) {
                  var obj = oVM.completeOrderArr[index];
                  return MyOrderRow(mObj: obj, onTap: () {
                    Get.to(() => OrderDetailScreen(obj: obj));
                  });
                },
                itemCount: oVM.completeOrderArr.length,
              ),
      ),
    );
  }
}
