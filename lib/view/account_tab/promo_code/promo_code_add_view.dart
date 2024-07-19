import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common/extension.dart';
import 'package:online_groceries_admin/common_widget/line_text_button.dart';
import 'package:online_groceries_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/view_model/promo_code_view_model.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dt;

class PromoCodeAddScreen extends StatefulWidget {
  final bool isEdit;
  const PromoCodeAddScreen({super.key, this.isEdit = false});

  @override
  State<PromoCodeAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<PromoCodeAddScreen> {
  final pVM = Get.find<PromoCodeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.isEdit ? "Edit Promo Code" : "Add Promo Code",
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
                  if (!widget.isEdit)
                    const SizedBox(
                      height: 25,
                    ),
                  if (!widget.isEdit)
                    LineTextField(
                      title: "Promo Code",
                      placeholder: "Enter Promo Code",
                      controller: pVM.txtCode.value,
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Title",
                    placeholder: "Enter Promo Code Title",
                    controller: pVM.txtTitle.value,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Description",
                    placeholder: "Enter Promo Code Description",
                    controller: pVM.txtDescription.value,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Promo Code Type",
                        style: TextStyle(
                            color: TColor.textTittle,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  pVM.selectType.value = 0;
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      pVM.selectType.value == 0
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      color: TColor.primary,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Fixed",
                                      style: TextStyle(
                                          color: TColor.textTittle,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  pVM.selectType.value = 1;
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      pVM.selectType.value == 1
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      color: TColor.primary,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Percentage(%)",
                                      style: TextStyle(
                                          color: TColor.textTittle,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        color: const Color(0xffE2E2E2),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Offer Price",
                    placeholder: "Enter Offer",
                    controller: pVM.txtOfferPrice.value,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Min Order Amount",
                    placeholder: "Enter Min Order Amount",
                    controller: pVM.txtMinOrderAmount.value,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Max Discount Amount",
                    placeholder: "Enter Max Discount Amount",
                    controller: pVM.txtMaxDiscountAmount.value,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundButton(
                      title: widget.isEdit ? "Update" : "Add",
                      onPressed: () {
                        if (widget.isEdit) {
                          pVM.actionUpdate(() {
                            Navigator.pop(context);
                          });
                        } else {
                          pVM.actionAdd(() {
                            Navigator.pop(context);
                          });
                        }
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
