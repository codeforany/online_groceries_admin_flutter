import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/view/order_tab/cancel_order_screen.dart';
import 'package:online_groceries_admin/view/order_tab/completed_order_screen.dart';
import 'package:online_groceries_admin/view/order_tab/new_order_screen.dart';
import 'package:online_groceries_admin/view_model/order_view_model.dart';

class OrderTabScreen extends StatefulWidget {
  const OrderTabScreen({super.key});

  @override
  State<OrderTabScreen> createState() => _OrderTabScreenState();
}

class _OrderTabScreenState extends State<OrderTabScreen>
    with SingleTickerProviderStateMixin {
  final oVM = Get.put(OrderViewModel());

  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;

      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
    Get.delete<OrderViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Orders",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1,
                ),
              ],
            ),
            child: TabBar(
                controller: controller,
                indicatorColor: TColor.primary,
                indicatorWeight: 2,
                labelColor: TColor.primary,
                labelStyle: TextStyle(
                  color: TColor.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: TColor.primaryText,
                unselectedLabelStyle: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(
                    text: "New",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Cancel",
                  )
                ]),
          ),
          const SizedBox(
            height: 1,
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                NewOrderScreen(),
                CompletedOrderScreen(),
                CancelOrderScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
