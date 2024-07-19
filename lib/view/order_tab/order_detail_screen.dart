import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/my_order_row.dart';
import 'package:online_groceries_admin/common_widget/order_item_row.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/model/my_order_model.dart';
import 'package:online_groceries_admin/view_model/order_view_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final MyOrderModel obj;
  const OrderDetailScreen({super.key, required this.obj});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final oVM = Get.find<OrderViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oVM.actionOpenOrderDetail(widget.obj);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 20,
            height: 20,
            color: TColor.primary,
          ),
        ),
        title: Text(
          "Order Details",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Order ID: #${widget.obj.orderId}",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        getPaymentStatus(widget.obj),
                        style: TextStyle(
                          color: getPaymentStatusColor(widget.obj),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.obj.createdDate}",
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        getOrderStatus(widget.obj),
                        style: TextStyle(
                          color: getOrderStatusColor(widget.obj),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${widget.obj.address ?? ""}, ${widget.obj.city ?? ""}, ${widget.obj.state ?? ""}, ${widget.obj.postalCode ?? ""}, ",
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Delivery Type: ",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          getDeliverType(widget.obj),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "Payment Type: ",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          getPaymentType(widget.obj),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var pObj = oVM.cartList[index];
                  return OrderItemRow(pObj: pObj);
                },
                itemCount: oVM.cartList.length,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 2)
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Amount:",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(widget.obj.totalPrice ?? 0).toStringAsFixed(2)}.",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Delivery Cost:",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$${(widget.obj.deliverPrice ?? 0).toStringAsFixed(2)}.",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Discount:",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "- \$${(widget.obj.discountPrice ?? 0).toStringAsFixed(2)}.",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      color: Colors.black12,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            " \$${(widget.obj.userPayPrice ?? 0).toStringAsFixed(2)}.",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            if (widget.obj.orderStatus == 1)
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: RoundButton(
                        title: "Accept",
                        onPressed: () {
                          oVM.apiOrderStatusChange(widget.obj.orderId ?? 0,
                              widget.obj.userId ?? 0, 2, () {
                            oVM.apiNewOrderList();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: RoundButton(
                        title: "Reject",
                        bgColor: Colors.red,
                        onPressed: () {
                          oVM.apiOrderStatusChange(widget.obj.orderId ?? 0,
                              widget.obj.userId ?? 0, 5, () {
                            oVM.apiNewOrderList();
                            oVM.apiCancelDeclineOrderList();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.obj.orderStatus == 2)
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: RoundButton(
                        title: "Delivered",
                        onPressed: () {
                          oVM.apiOrderStatusChange(widget.obj.orderId ?? 0,
                              widget.obj.userId ?? 0, 3, () {
                            oVM.apiNewOrderList();
                            oVM.apiCompleteOrderList();
                            oVM.apiCancelDeclineOrderList();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: RoundButton(
                        title: "Order Cancel",
                        bgColor: Colors.red,
                        onPressed: () {
                          oVM.apiOrderStatusChange(widget.obj.orderId ?? 0,
                              widget.obj.userId ?? 0, 4, () {
                            oVM.apiNewOrderList();

                            oVM.apiCancelDeclineOrderList();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
