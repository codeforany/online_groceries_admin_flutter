import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common/extension.dart';
import 'package:online_groceries_admin/common_widget/line_text_button.dart';
import 'package:online_groceries_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/model/product_detail_model.dart';
import 'package:online_groceries_admin/view_model/offer_view_model.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dt;

class OfferAddScreen extends StatefulWidget {
  final ProductDetailModel obj;
  const OfferAddScreen({super.key, required this.obj});

  @override
  State<OfferAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<OfferAddScreen> {
  final pVM = Get.put(OfferViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Offer",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Obx(
              () => Column(
                children: [
                  LineTextButton(
                      title: "Start Date",
                      placeholder: "Select Date",
                      value: pVM.selectStartDate.value.stringFormat(),
                      onPressed: () {
                        dt.DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            theme: dt.DatePickerTheme(
                              itemStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              doneStyle: TextStyle(
                                color: TColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ), onChanged: (date) {
                          pVM.selectStartDate.value = date;
                        }, onConfirm: (date) {
                          pVM.selectStartDate.value = date;
                        },
                            onCancel: () {},
                            currentTime: DateTime.now(),
                            locale: dt.LocaleType.en);
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextButton(
                      title: "End Date",
                      placeholder: "Select Date",
                      value: pVM.selectEndDate.value.stringFormat(),
                      onPressed: () {
                        dt.DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            theme: dt.DatePickerTheme(
                              itemStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              doneStyle: TextStyle(
                                color: TColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ), onChanged: (date) {
                          pVM.selectEndDate.value = date;
                        }, onConfirm: (date) {
                          pVM.selectEndDate.value = date;
                        },
                            onCancel: () {},
                            currentTime: DateTime.now(),
                            locale: dt.LocaleType.en);
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Offer Price ( \$${ widget.obj.price ?? "" } ) ",
                    placeholder: "Enter Offer",
                    controller: pVM.txtPrice.value,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundButton(
                      title: "Add",
                      onPressed: () {
                        pVM.actionAdd(widget.obj, () {
                          Navigator.pop(context);
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
