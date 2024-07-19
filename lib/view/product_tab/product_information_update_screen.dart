import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/dropdown.dart';
import 'package:online_groceries_admin/common_widget/image_picker_view.dart';
import 'package:online_groceries_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/view_model/product_view_model.dart';

import '../../common_widget/popup_layout.dart';

class ProductInfoUpdateScreen extends StatefulWidget {
  const ProductInfoUpdateScreen({super.key});

  @override
  State<ProductInfoUpdateScreen> createState() =>
      _ProductInfoUpdateScreenState();
}

class _ProductInfoUpdateScreenState extends State<ProductInfoUpdateScreen> {
  var pVM = Get.find<ProductViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Product",
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
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  LineTextField(
                      title: "Product Name",
                      placeholder: "Enter Name",
                      controller: pVM.txtName.value),
                  const SizedBox(
                    height: 15,
                  ),
                  LineTextField(
                      title: "Detail",
                      placeholder: "Enter Detail",
                      controller: pVM.txtDetail.value),
                  const SizedBox(
                    height: 15,
                  ),
                  Dropdown(
                      title: "Category",
                      placeholder: "Select Category",
                      valueList: pVM.categoryList,
                      titleKey: "cat_name",
                      selectValue: pVM.selectCategory.value,
                      didChange: (newVal) {
                        setState(() {
                          pVM.selectCategory.value = newVal as Map? ?? {};
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Dropdown(
                      title: "Brand",
                      placeholder: "Select Brand",
                      valueList: pVM.brandList,
                      titleKey: "brand_name",
                      selectValue: pVM.selectBrand.value,
                      didChange: (newVal) {
                        setState(() {
                          pVM.selectBrand.value = newVal as Map? ?? {};
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Dropdown(
                      title: "Type",
                      placeholder: "Select Type",
                      valueList: pVM.typeList,
                      titleKey: "type_name",
                      selectValue: pVM.selectType.value,
                      didChange: (newVal) {
                        setState(() {
                          pVM.selectType.value = newVal as Map? ?? {};
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  LineTextField(
                      title: "Unit Name",
                      placeholder: "Enter Unit Name",
                      controller: pVM.txtUnitName.value),
                  const SizedBox(
                    height: 15,
                  ),
                  LineTextField(
                    title: "Unit Value",
                    placeholder: "Enter Unit Value",
                    controller: pVM.txtUnitValue.value,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  LineTextField(
                      title: "Nutrition Weight",
                      placeholder: "Enter Nutrition Weight",
                      keyboardType: TextInputType.number,
                      controller: pVM.txtNutritionWeight.value),
                  const SizedBox(
                    height: 15,
                  ),
                  LineTextField(
                      title: "Price",
                      placeholder: "Enter Product Price",
                      keyboardType: TextInputType.number,
                      controller: pVM.txtPrice.value),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundButton(
                      title: "Update",
                      onPressed: () {
                        pVM.actionUpdate(() {
                          Navigator.pop(context);
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Nutrition List",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LineTextField(
                          title: "Nutrition Name",
                          placeholder: "Enter Name",
                          controller: pVM.txtNutritionName.value,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 120,
                        child: LineTextField(
                          title: "Value",
                          placeholder: "Enter Value",
                          controller: pVM.txtNutritionValue.value,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          pVM.actionNutritionAdd(() {});
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: TColor.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/img/add.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var obj = pVM.productNutritionList[index];
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                obj.nutritionName ?? "",
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              obj.nutritionValue ?? "",
                              style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                                onPressed: () {
                                  pVM.actionNutritionDelete(obj);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 1,
                          color: const Color(0xffE2E2E2),
                        )
                      ]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: pVM.productNutritionList.length,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Image List",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PopupLayout(
                              child: ImagePickerView(
                                didSelect: (newImage) {
                                  pVM.selectImage.value = File(newImage);
                                  pVM.actionImageAdd(() {});
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: TColor.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/img/add.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1),
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 2)
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: pVM.productImages[index].image ?? "",
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                ),
                                width: double.maxFinite,
                                height: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                pVM.actionImageDelete(pVM.productImages[index]);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: pVM.productImages.length,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
