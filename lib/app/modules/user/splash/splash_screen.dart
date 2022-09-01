import 'package:flutter/material.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/gosheno-logo2.png',
                  width: 200,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(right: 20),
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/gosheno-logo-typo.png',
                      width: width * 0.3 - 10,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: width * 0.44,
                      child: Text(
                        'پر فروش ترین کتاب های موفقیت و کسب و کار',
                        style: kBodyMedium.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/GitigetLogo.gif',
                      width: width * 0.2,
                    ),
                  ],
                ),

            ),
          ),
        ],
      ),
    );
  }
}
