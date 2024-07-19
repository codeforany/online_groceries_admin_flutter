import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/view/account_tab/brand/brand_view.dart';
import 'package:online_groceries_admin/view/account_tab/promo_code/promo_code_view.dart';
import 'package:online_groceries_admin/view/account_tab/zone/zone_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/account_row.dart';
import '../../view_model/splash_view_model.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final splashVM = Get.find<SplashViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(
                      "assets/img/u1.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Code For Any",
                            style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.edit,
                            color: TColor.primary,
                            size: 18,
                          )
                        ],
                      ),
                      Text(
                        "codeforany@gmail.com",
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 16),
                      )
                    ],
                  ))
                ],
              ),
            ),
            const Divider(
              color: Colors.black26,
              height: 1,
            ),
            AccountRow(
              title: "Brands",
              icon: "assets/img/a_order.png",
              onPressed: () {
                Get.to( () => const BrandView() );
              },
            ),

            AccountRow(
              title: "Zone",
              icon: "assets/img/a_order.png",
              onPressed: () {
                Get.to(() => const ZoneView());
              },
            ),
            
            AccountRow(
              title: "Promo Code",
              icon: "assets/img/a_promocode.png",
              onPressed: () {

                Get.to( () => const PromoCodeView() );
                //  Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const PromoCodeView()));
              },
            ),
            AccountRow(
              title: "Notifications",
              icon: "assets/img/a_noitification.png",
              onPressed: () {
                // Get.to(() => const NotificationListView() );
                
              },
            ),
            AccountRow(
              title: "Help",
              icon: "assets/img/a_help.png",
              onPressed: () {},
            ),
            AccountRow(
              title: "About",
              icon: "assets/img/a_about.png",
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      splashVM.logout();
                    },
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19)),
                    minWidth: double.maxFinite,
                    elevation: 0.1,
                    color: const Color(0xffF2F3F2),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log Out",
                              style: TextStyle(
                                  color: TColor.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset(
                            "assets/img/logout.png",
                            width: 20,
                            height: 20,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
