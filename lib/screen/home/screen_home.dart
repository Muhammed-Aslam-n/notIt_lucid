import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/common_headers.dart';
import '../../widgets/common_text.dart';

dynamic height, width;

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff3b4254),
        // floatingActionButton: floatingAB(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    ListTile(
                      horizontalTitleGap: -5,
                      minVerticalPadding: 12,
                      leading: Image.asset(
                        "assets/icons/AppIcon2.png",
                        height: 80,
                        width: 60,
                      ),
                      isThreeLine: true,
                      title: Text(
                        "SchoLoger",
                        style: TextStyle(
                          fontFamily: "font6",
                          fontSize: 35,
                          foreground: Paint()..shader = linearGradient,
                        ),
                      ),
                      subtitle: Text(
                        "\t\t\t\t\t\t\t\t\tImpression Matters",
                        style: TextStyle(
                          fontFamily: "font3",
                          fontSize: 10,
                          foreground: Paint()..shader = linearGradient,
                        ),
                      ),
                      
                    ),
                    sizedh2,
                    const SizedBox(
                      height: 30,
                    ),
                    CommonHeaders(
                      text:
                          "Welcome , ${AuthController.authController.userName}",
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonText(
                      text: "Create, Edit and Update all your Student Records",
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}
