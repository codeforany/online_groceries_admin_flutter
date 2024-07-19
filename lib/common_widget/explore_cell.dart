import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/model/category_model.dart';

class ExploreCell extends StatelessWidget {
  final CategoryModel cObj;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExploreCell(
      {super.key,
      required this.cObj,
      required this.onPressed,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: cObj.color ?? TColor.primary, width: 1),
          color: (cObj.color ?? TColor.primary).withOpacity(0.25),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: cObj.image ?? "",
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: 120,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    cObj.catName ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: cObj.color ?? TColor.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, -2))
                  ]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onEdit,
                    child: const SizedBox(
                      width: 40,
                      height: 30,
                      child: Icon(
                        Icons.edit_square,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onDelete,
                    child: const SizedBox(
                      width: 40,
                      height: 30,
                      child: Icon(
                        Icons.delete,
                        color: Colors.black,
                        size: 20,
                      ),
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
