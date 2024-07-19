import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/common_widget/image_picker_view.dart';
import 'package:online_groceries_admin/common_widget/line_textfield.dart';
import 'package:online_groceries_admin/common_widget/popup_layout.dart';
import 'package:online_groceries_admin/common_widget/round_button.dart';
import 'package:online_groceries_admin/view_model/type_view_model.dart';

class TypeAddScreen extends StatefulWidget {
  final bool isEdit;
  const TypeAddScreen({super.key, this.isEdit = false});

  @override
  State<TypeAddScreen> createState() => _TypeAddScreenState();
}

class _TypeAddScreenState extends State<TypeAddScreen> {
  final tVM = Get.find<TypeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.isEdit ? "Edit Product Type" : "Add Product Type",
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
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Product Type Name",
                    placeholder: "Enter Type Name",
                    controller: tVM.txtName.value,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LineTextField(
                    title: "Type Color",
                    placeholder: "Enter Color ('AAAAAA')",
                    controller: tVM.txtColor.value,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        PopupLayout(
                          child: ImagePickerView(
                            didSelect: (newImage) {
                              tVM.image.value = File(newImage);
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: context.width - 40,
                      height: context.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 10)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: tVM.image.value != null
                            ? Image.file(
                                tVM.image.value!,
                                width: context.width - 40,
                                height: context.width - 40,
                                fit: BoxFit.contain,
                              )
                            : widget.isEdit
                                ? CachedNetworkImage(
                                    imageUrl: tVM.catObj.value.image ?? "",
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    width: context.width - 40,
                                    height: context.width - 40,
                                    fit: BoxFit.contain,
                                  )
                                : Icon(
                                    Icons.image,
                                    size: 100,
                                    color: TColor.secondaryText,
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundButton(
                      title: widget.isEdit ? "Update" : "Add",
                      onPressed: () {
                        if (widget.isEdit) {
                          tVM.actionUpdate(() {
                            Navigator.pop(context);
                          });
                        } else {
                          tVM.actionAdd(() {
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
