import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfUseScreen extends StatelessWidget {
  final Uri _url = Uri.parse('http://zona.ae/');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                child: Text(
                  'Zona APP - Terms and Conditions',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const FittedBox(
                  child: Text(
                'This Terms of Use agreement is effective as of: November 1, 2021.',
                style: TextStyle(color: Colors.black),
              )),
              const FittedBox(
                  child: Text(
                'Zona App FZ LLC (the "Company"), primarily operates, controls',
                style: TextStyle(color: Colors.black, fontSize: 25),
              )),
              const FittedBox(
                  child: Text(
                'and manages the Platform and the Services (as defined below)',
                style: TextStyle(color: Colors.black, fontSize: 25),
              )),
              const FittedBox(
                child: Text(
                  'PLEASE READ THE TERMS OF USE THOROUGHLY AND CAREFULLY.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const FittedBox(
                  child: Text(
                'ACCEPTANCE OF TERMS',
                style: TextStyle(fontSize: 20),
              )),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                  child: Text(
                      'The terms and conditions set forth below ("Terms of Use") and the Privacy Policy (as defined below) constitute a legally binding agreement between the Company and you. These Terms of Use contain provisions that define your limits, legal rights and obligations with respect to your use of and participation in (i) the Company website and mobile application, including the classified advertisements, forums, various email functions and internet links, and all content and Company’s services available through the Zona App mobile application (the “Application”), domain and sub-domains maintained by the Company and located at')),
              TextButton(
                onPressed: _launchUrl,
                child: const Text('http://zona.ae'),
              ),
              const SizedBox(
                  child: Text(
                      '(the “Site”) (the Application and the Site shall be collectively referred to herein as the "Platform"), and (ii) the online transactions between those users of the Platform who are offering services (each, a "Service Professional") and those users of the Platform who are obtaining services (each, a "Service User") through the Platform (such services, collectively, the "Services"). The Terms of Use described below incorporate the Privacy Policy and apply to all users of the Platform, including users who are also contributors of video content, information, private and public messages, advertisements, and other materials or Services on the Platform. You acknowledge that the Platform serves as a venue for the online distribution and publication of user submitted information between Service Professionals and Service Users, and, by using, visiting, registering for, and/or otherwise participating in this Platform, including the Services presented, promoted, and displayed on the Platform, and by clicking on "I have read and agree to the terms of use," you hereby certify that: (1) you are either a Service Professional or a prospective Service User, (2) you have the authority to enter into these Terms of Use, (3) you authorize the transfer of payment for Services requested through the use of the Platform, and (4) you agree to be bound by all terms and conditions of these Terms of Use and any other documents incorporated by reference herein. If you do not so agree to the foregoing, you should not click to affirm your acceptance thereof, in which case you are prohibited from accessing or using the Platform. If you do not agree to any of the provisions set forth in the Terms of Use, kindly discontinue viewing or participating in this Platform immediately.')),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                child: Text(
                    'YOU SPECIFICALLY AGREE THAT BY USING THE PLATFORM, YOU ARE AT LEAST 18 YEARS OF AGE AND YOU ARE COMPETENT UNDER LAW TO ENTER INTO A LEGALLY BINDING AND ENFORCEABLE CONTRACT'),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                child: Text(
                    'All references to "you" or "your," as applicable, mean the person that accesses, uses, and/or participates in the Platform in any manner. If you use the Platform or open an Account (as defined below) on behalf of a business, you represent and warrant that you have the authority to bind that business and your acceptance of the Terms of Use will be deemed an acceptance by that business and "you" and "your" herein shall refer to that business.'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Modifications to Terms of use and Privacy Policy',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                child: Text(
                    'The Company reserves the right, in its sole discretion, to change, modify, or otherwise amend the Terms of Use, and any other documents incorporated by reference herein for complying with legal and regulatory framework and for other legitimate business purposes, at any time, and the Company will post the amended Terms of Use, which are accessible in the Platform or at the domain of'),
              ),
              TextButton(
                onPressed: _launchUrl,
                child: const Text('http://zona.ae'),
              ),
              const SizedBox(
                  child: Text(
                      'It is your responsibility to review the Terms of Use for any changes and you are encouraged to check the Terms of Use frequently. Your use of the Platform following any amendment of the Terms of Use will signify your consent to and acceptance of any revised Terms of Use. If you do not agree to abide by these or any future Terms of Use, please do not use or access the Platform.')),
              const SizedBox(
                height: 5,
              ),
              const FittedBox(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                  "The Company takes reasonable measures to safeguard your personally identifiable information against unauthorized access. However, the Internet is not a secure medium and the privacy of your personal information can never be guaranteed. The Company has no control over the practices of third parties (e.g. website links to the Platform or third parties who misrepresent themselves as you or someone else). You agree that the Company may process your personal information that you provide to it for the purposes of providing the services on the Platform and for sending marketing communications to you. The Company has established a Privacy Policy that explains to users how their information is collected and used. The Privacy Policy is reference"),
            ],
          ),
        ),
      ),
    );
  }
}
