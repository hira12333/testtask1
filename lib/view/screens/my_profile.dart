import 'package:flutter/material.dart';
import 'package:test_task/constants/app_sizes.dart';
import 'package:test_task/constants/color.dart';
import 'package:test_task/constants/style.dart';
import 'package:test_task/imagePaths/assets.dart';
import 'package:test_task/view/reusable_widgets/simple_app_bar.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context: context, title: 'Hira Zaheer'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: rounded(kSecondaryColor),
                  height: 88,
                  child: Row(
                    children: [
                      Padding(
                        padding: AppSizes.DEFAULT_HORIZONTAL,
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: 62,
                            width: 62,
                            decoration: circle(kGrey3Color)),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Hira Zaheer',
                            style: mystyle(14, FontWeight.bold, kPrimaryColor),
                          ),
                          subtitle: Column(children: [
                            Row(
                              children: [
                                Text(
                                  'zaheerhira2200@gmail.com',
                                  style: mystyle(
                                      12, FontWeight.bold, kPrimaryColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '+923185106643',
                                  style: mystyle(
                                      12, FontWeight.bold, kPrimaryColor),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Image.asset(
                          Assets.imagesSettings,
                          height: 18,
                        ),
                        title: Text(
                          'Kontoinstallningar',
                          style: mystyle(12, FontWeight.bold, kBlackColor),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Image.asset(
                          Assets.imagesMena,
                          height: 18,
                        ),
                        title: Text(
                          'Mina betalmetoder',
                          style: mystyle(12, FontWeight.bold, kBlackColor),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Image.asset(
                          Assets.imagesSupport,
                          height: 18,
                        ),
                        title: Text(
                          'Support',
                          style: mystyle(12, FontWeight.bold, kBlackColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
