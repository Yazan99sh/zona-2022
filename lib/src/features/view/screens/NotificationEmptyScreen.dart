import 'package:flutter/material.dart';
import 'package:zona/generated/l10n.dart';
import 'package:zona/src/utils/responsive.dart';

class NotificationEmptyScreen extends StatelessWidget {
  const NotificationEmptyScreen({Key? key}) : super(key: key);

  static String id = "notification-empty";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        color: const Color(0xF9F9F9FF),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Responsive.getScreenWidth(context) * 0.25,
                height: Responsive.getScreenHeight(context) * 0.25,
                child: Image.asset("assets/images/Notification.png"),
              ),
              const SizedBox(
                height: 40,
              ),
              FittedBox(
                child: Text(
                  S.current.noNotifications,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.current.youDoNotHaveNotificationYet,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(176, 176, 176, 1),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: Responsive.getScreenWidth(context) * 0.6,
                height: Responsive.getScreenHeight(context) * 0.075,
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: const Color.fromRGBO(41, 48, 60, 1),
                  onPressed: () {},
                  child: Text(
                    S.current.viewAllServices,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
