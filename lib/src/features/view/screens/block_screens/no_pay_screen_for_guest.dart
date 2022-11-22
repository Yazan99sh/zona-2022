import 'package:flutter/material.dart';
import 'package:zona/src/features/view/components/components.dart';
import 'package:zona/src/features/view/screens/main_app_screens/home_layout_screen/home_layout_screen.dart';
import 'package:zona/src/utils/colors.dart';
import 'package:zona/src/utils/responsive.dart';

import '../../../../../generated/l10n.dart';

class NoPayForGuest extends StatelessWidget {
  const NoPayForGuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               FittedBox(
                child: Text(
                  S.current.guestNotAllowedToPay,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: Responsive.getScreenWidth(context),
                child: Components.defaultPrimaryButton(
                  text: S.current.homePage,
                  press: ()
                  {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.id, (route) => false);
                  },
                  color: AppColors.mainColor,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
