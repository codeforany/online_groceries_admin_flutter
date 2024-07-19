import 'package:flutter/material.dart';
import 'package:online_groceries_admin/common/color_extension.dart';
import 'package:online_groceries_admin/model/area_model.dart';

class AreaRow extends StatelessWidget {
  final AreaModel obj;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AreaRow(
      {super.key,
      required this.obj,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              obj.areaName ?? "",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit_square,
              color: TColor.primary,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
