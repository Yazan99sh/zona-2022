// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current..');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: 'The current Language',
      args: [],
    );
  }

  /// `Continue as a Guest`
  String get continueAsAGuest {
    return Intl.message(
      'Continue as a Guest',
      name: 'continueAsAGuest',
      desc: 'Continue as a Guest',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: 'Sign In',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: 'Email address',
      args: [],
    );
  }

  /// `Please enter email`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter email',
      name: 'pleaseEnterEmail',
      desc: 'Please enter email',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Email',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: 'Please enter password',
      args: [],
    );
  }

  String get pleaseEnterPasswordMoreThan8 {
    return Intl.message(
      'Please enter password more than 8 chars',
      name: 'pleaseEnterPasswordMoreThan8',
      desc: 'Please enter password more than 8 chars',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get wrongEmailOrPassword {
    return Intl.message(
      'Wrong email or password',
      name: 'wrongEmailOrPassword',
      desc: 'Wrong email or password',
      args: [],
    );
  }

  /// `Logged successfully`
  String get loggedSuccessfully {
    return Intl.message(
      'Logged successfully',
      name: 'loggedSuccessfully',
      desc: 'Logged successfully',
      args: [],
    );
  }

  /// `Login attempt failed`
  String get loginAttemptFailed {
    return Intl.message(
      'Login attempt failed',
      name: 'loginAttemptFailed',
      desc: 'Login attempt failed',
      args: [],
    );
  }

  /// `please try again!`
  String get pleaseTryAgain {
    return Intl.message(
      'please try again!',
      name: 'pleaseTryAgain',
      desc: 'please try again!',
      args: [],
    );
  }

  /// `Sign in with`
  String get signInWith {
    return Intl.message(
      'Sign in with',
      name: 'signInWith',
      desc: 'Sign in with',
      args: [],
    );
  }

  /// `Sign in with`
  String get signInWithApple {
    return Intl.message(
      'Sign in with Apple',
      name: 'signInWithApple',
      desc: 'Sign in with apple',
      args: [],
    );
  }

  /// `Sign in with`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with google',
      name: 'signInWithGoogle',
      desc: 'Sign in with google',
      args: [],
    );
  }

  /// `Create a New Account?`
  String get createANewAccount {
    return Intl.message(
      'Create a New Account?',
      name: 'createANewAccount',
      desc: 'Create a New Account?',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: 'Sign Up',
      args: [],
    );
  }

  /// `Mr.`
  String get mr {
    return Intl.message(
      'Mr.',
      name: 'mr',
      desc: 'Mr.',
      args: [],
    );
  }

  /// `Mrs.`
  String get mrs {
    return Intl.message(
      'Mrs.',
      name: 'mrs',
      desc: 'Mrs.',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: 'First Name',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: 'Last Name',
      args: [],
    );
  }

  /// `Please enter first name`
  String get pleaseEnterFirstName {
    return Intl.message(
      'Please enter first name',
      name: 'pleaseEnterFirstName',
      desc: 'Please enter first name',
      args: [],
    );
  }

  /// `Please enter last name`
  String get pleaseEnterLastName {
    return Intl.message(
      'Please enter last name',
      name: 'pleaseEnterLastName',
      desc: 'Please enter last name',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: 'Phone number',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Please enter phone number',
      name: 'pleaseEnterPhoneNumber',
      desc: 'Please enter phone number',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: 'Gender',
      args: [],
    );
  }

  /// `Account created`
  String get accountCreated {
    return Intl.message(
      'Account created',
      name: 'accountCreated',
      desc: 'Account created',
      args: [],
    );
  }

  /// `Another account uses this email,`
  String get anotherAccountUsesThisEmail {
    return Intl.message(
      'Another account uses this email,',
      name: 'anotherAccountUsesThisEmail',
      desc: 'Another account uses this email,',
      args: [],
    );
  }

  /// connection error
  String get connectionError {
    return Intl.message(
      'Connection error',
      name: 'connectionError',
      desc: 'Connection Error',
      args: [],
    );
  }

  /// account deleted
  String get accountDeleted {
    return Intl.message(
      "Account has been deleted",
      name: 'accountDeleted',
      desc: 'Account deleted',
      args: [],
    );
  }

  /// logout
  String get loggedOut {
    return Intl.message(
      "Logged out",
      name: 'logout',
      desc: 'Logged out',
      args: [],
    );
  }



  /// `please try another one!`
  String get pleaseTryAnotherOne {
    return Intl.message(
      'please try another one!',
      name: 'pleaseTryAnotherOne',
      desc: 'please try another one!',
      args: [],
    );
  }

  /// `Failed to create account`
  String get failedToCreateAccount {
    return Intl.message(
      'Failed to create account',
      name: 'failedToCreateAccount',
      desc: 'Failed to create account',
      args: [],
    );
  }

  /// `Already Have An Account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already Have An Account?',
      name: 'alreadyHaveAnAccount',
      desc: 'Already Have An Account?',
      args: [],
    );
  }

  /// `Search Categories  ...`
  String get searchCategories {
    return Intl.message(
      'Search Categories  ...',
      name: 'searchCategories',
      desc: 'Search Categories  ...',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: 'All Categories',
      args: [],
    );
  }

  /// `I   Bookings`
  String get iBookings {
    return Intl.message(
      'I   Bookings',
      name: 'iBookings',
      desc: 'I   Bookings',
      args: [],
    );
  }

  /// `No Upcoming Orders!`
  String get noUpcomingOrders {
    return Intl.message(
      'No Upcoming Orders!',
      name: 'noUpcomingOrders',
      desc: 'No Upcoming Orders!',
      args: [],
    );
  }

  /// `Currently you don’t have any upcoming order. Place and track your orders from here.`
  String get currentlyNoUpcomingOrder {
    return Intl.message(
      'Currently you don’t have any upcoming order. Place and track your orders from here.',
      name: 'currentlyNoUpcomingOrder',
      desc:
          'Currently you don’t have any upcoming order. Place and track your orders from here.',
      args: [],
    );
  }

  /// `View all services`
  String get viewAllServices {
    return Intl.message(
      'View all services',
      name: 'viewAllServices',
      desc: 'View all services',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: 'Upcoming',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: 'History',
      args: [],
    );
  }

  /// `Draft`
  String get draft {
    return Intl.message(
      'Draft',
      name: 'draft',
      desc: 'Draft',
      args: [],
    );
  }

  /// `AC Installation`
  String get acInstallation {
    return Intl.message(
      'AC Installation',
      name: 'acInstallation',
      desc: 'AC Installation',
      args: [],
    );
  }

  /// `Reference Code: #D-571224`
  String get referenceCodeD571224 {
    return Intl.message(
      'Reference Code: #D-571224',
      name: 'referenceCodeD571224',
      desc: 'Reference Code: #D-571224',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: 'Status',
      args: [],
    );
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message(
      'Confirmed',
      name: 'confirmed',
      desc: 'Confirmed',
      args: [],
    );
  }

  /// `8:00-9:00 AM,  09 Dec`
  String get customDateTime {
    return Intl.message(
      '8:00-9:00 AM,  09 Dec',
      name: 'customDateTime',
      desc: '8:00-9:00 AM,  09 Dec',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: 'Schedule',
      args: [],
    );
  }

  /// `Westinghouse`
  String get westinghouse {
    return Intl.message(
      'Westinghouse',
      name: 'westinghouse',
      desc: 'Westinghouse',
      args: [],
    );
  }

  /// `Service providers`
  String get serviceProvider {
    return Intl.message(
      'Service providers',
      name: 'serviceProvider',
      desc: 'Service providers',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: 'Call',
      args: [],
    );
  }

  /// `Multi Mask Facial`
  String get multiMaskFacial {
    return Intl.message(
      'Multi Mask Facial',
      name: 'multiMaskFacial',
      desc: 'Multi Mask Facial',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: 'Pending',
      args: [],
    );
  }

  /// `Sindenayu`
  String get sindenayu {
    return Intl.message(
      'Sindenayu',
      name: 'sindenayu',
      desc: 'Sindenayu',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: 'Order Details',
      args: [],
    );
  }

  /// `View Bill`
  String get viewBill {
    return Intl.message(
      'View Bill',
      name: 'viewBill',
      desc: 'View Bill',
      args: [],
    );
  }

  /// `Created by:`
  String get createdBy {
    return Intl.message(
      'Created by:',
      name: 'createdBy',
      desc: 'Created by:',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: 'Time',
      args: [],
    );
  }

  /// `In way`
  String get inWay {
    return Intl.message(
      'In way',
      name: 'inWay',
      desc: 'In way',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: 'Delivered',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: 'Price',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: 'Location',
      args: [],
    );
  }

  /// `Open Map`
  String get openMap {
    return Intl.message(
      'Open Map',
      name: 'openMap',
      desc: 'Open Map',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: 'Notes',
      args: [],
    );
  }

  /// `You don't created any order yet`
  String get noCreatedOrderYet {
    return Intl.message(
      'You don\'t created any order yet',
      name: 'noCreatedOrderYet',
      desc: 'You don\'t created any order yet',
      args: [],
    );
  }

  /// `please create some!`
  String get pleaseCreateSome {
    return Intl.message(
      'please create some!',
      name: 'pleaseCreateSome',
      desc: 'please create some!',
      args: [],
    );
  }

  /// `No Orders!`
  String get noOrders {
    return Intl.message(
      'No Orders!',
      name: 'noOrders',
      desc: 'No Orders!',
      args: [],
    );
  }

  /// `You don't have any order yet, Please place one`
  String get noOrderYet {
    return Intl.message(
      'You don\'t have any order yet, Please place one',
      name: 'noOrderYet',
      desc: 'You don\'t have any order yet, Please place one',
      args: [],
    );
  }

  /// `AED`
  String get aED {
    return Intl.message(
      'AED',
      name: 'aED',
      desc: 'AED',
      args: [],
    );
  }

  /// `No Done orders!`
  String get noDoneOrders {
    return Intl.message(
      'No Done orders!',
      name: 'noDoneOrders',
      desc: 'No Done orders!',
      args: [],
    );
  }

  /// `No Cancelled orders!`
  String get noCancelledOrders {
    return Intl.message(
      'No Cancelled orders!',
      name: 'noCancelledOrders',
      desc: 'No Cancelled orders!',
      args: [],
    );
  }

  /// `Beauty parlour`
  String get beautyParlour {
    return Intl.message(
      'Beauty parlour',
      name: 'beautyParlour',
      desc: 'Beauty parlour',
      args: [],
    );
  }

  /// `at your home`
  String get atYourHome {
    return Intl.message(
      'at your home',
      name: 'atYourHome',
      desc: 'at your home',
      args: [],
    );
  }

  /// `Plumber & expart`
  String get plumberAndExpart {
    return Intl.message(
      'Plumber & expart',
      name: 'plumberAndExpart',
      desc: 'Plumber & expart',
      args: [],
    );
  }

  /// `nearby you`
  String get nearbyYou {
    return Intl.message(
      'nearby you',
      name: 'nearbyYou',
      desc: 'nearby you',
      args: [],
    );
  }

  /// `Professional home`
  String get professionalHome {
    return Intl.message(
      'Professional home',
      name: 'professionalHome',
      desc: 'Professional home',
      args: [],
    );
  }

  /// `cleaning`
  String get cleaning {
    return Intl.message(
      'cleaning',
      name: 'cleaning',
      desc: 'cleaning',
      args: [],
    );
  }

  /// `Verification code`
  String get verificationCode {
    return Intl.message(
      'Verification code',
      name: 'verificationCode',
      desc: 'Verification code',
      args: [],
    );
  }

  /// `We just send you a verify code to the email address '`
  String get weJustSendYouAVerifyCode {
    return Intl.message(
      'We just send you a verify code to the email address \'',
      name: 'weJustSendYouAVerifyCode',
      desc: 'We just send you a verify code to the email address \'',
      args: [],
    );
  }

  /// `'. check your inbox to get them`
  String get checkYourInbox {
    return Intl.message(
      '\'. check your inbox to get them',
      name: 'checkYourInbox',
      desc: '\'. check your inbox to get them',
      args: [],
    );
  }

  /// `Please fill up all fields.`
  String get pleaseFillUpAllFields {
    return Intl.message(
      'Please fill up all fields.',
      name: 'pleaseFillUpAllFields',
      desc: 'Please fill up all fields.',
      args: [],
    );
  }

  /// `Email verified! please login`
  String get emailVerified {
    return Intl.message(
      'Email verified! please login',
      name: 'emailVerified',
      desc: 'Email verified! please login',
      args: [],
    );
  }

  /// `Something went wrong! please try again`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong! please try again',
      name: 'somethingWentWrong',
      desc: 'Something went wrong! please try again',
      args: [],
    );
  }

  /// `Wrong OTP! please try again`
  String get wrongOTP {
    return Intl.message(
      'Wrong OTP! please try again',
      name: 'wrongOTP',
      desc: 'Wrong OTP! please try again',
      args: [],
    );
  }

  /// `Continue`
  String get continueContinue {
    return Intl.message(
      'Continue',
      name: 'continueContinue',
      desc: 'Continue',
      args: [],
    );
  }

  /// `Account creation verification code :: 😀 :: Zona`
  String get accountCreationVerificationCode {
    return Intl.message(
      'Account creation verification code :: 😀 :: Zona',
      name: 'accountCreationVerificationCode',
      desc: 'Account creation verification code :: 😀 :: Zona',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: 'Hello',
      args: [],
    );
  }

  /// `Here's the email verification code.`
  String get theEmailVerificationCode {
    return Intl.message(
      'Here\'s the email verification code.',
      name: 'theEmailVerificationCode',
      desc: 'Here\'s the email verification code.',
      args: [],
    );
  }

  /// `This code expires after 2 days.`
  String get thisCodeExpires {
    return Intl.message(
      'This code expires after 2 days.',
      name: 'thisCodeExpires',
      desc: 'This code expires after 2 days.',
      args: [],
    );
  }

  /// `Code: `
  String get code {
    return Intl.message(
      'Code: ',
      name: 'code',
      desc: 'Code: ',
      args: [],
    );
  }

  /// `If you are not trying to create an account on Zona`
  String get ifYouAreNotTryingToCreate {
    return Intl.message(
      'If you are not trying to create an account on Zona',
      name: 'ifYouAreNotTryingToCreate',
      desc: 'If you are not trying to create an account on Zona',
      args: [],
    );
  }

  /// `you can just ignore this email.`
  String get youCanJustIgnoreEmail {
    return Intl.message(
      'you can just ignore this email.',
      name: 'youCanJustIgnoreEmail',
      desc: 'you can just ignore this email.',
      args: [],
    );
  }

  /// `Sincerely`
  String get sincerely {
    return Intl.message(
      'Sincerely',
      name: 'sincerely',
      desc: 'Sincerely',
      args: [],
    );
  }

  /// `Zona Team`
  String get zonaTeam {
    return Intl.message(
      'Zona Team',
      name: 'zonaTeam',
      desc: 'Zona Team',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: 'Resend',
      args: [],
    );
  }

  /// `Re-send In`
  String get resendIn {
    return Intl.message(
      'Re-send In',
      name: 'resendIn',
      desc: 'Re-send In',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: 'Get Started',
      args: [],
    );
  }

  /// `Rate Zona Application`
  String get rateZonaApplication {
    return Intl.message(
      'Rate Zona Application',
      name: 'rateZonaApplication',
      desc: 'Rate Zona Application',
      args: [],
    );
  }

  /// `Your feedback will help us to make`
  String get yourFeedback {
    return Intl.message(
      'Your feedback will help us to make',
      name: 'yourFeedback',
      desc: 'Your feedback will help us to make',
      args: [],
    );
  }

  /// `improvements`
  String get improvements {
    return Intl.message(
      'improvements',
      name: 'improvements',
      desc: 'improvements',
      args: [],
    );
  }

  /// `No, Thanks`
  String get noThanks {
    return Intl.message(
      'No, Thanks',
      name: 'noThanks',
      desc: 'No, Thanks',
      args: [],
    );
  }

  /// `Rate in Store`
  String get rateInStore {
    return Intl.message(
      'Rate in Store',
      name: 'rateInStore',
      desc: 'Rate in Store',
      args: [],
    );
  }

  /// `Refer a Friend &`
  String get referFriend {
    return Intl.message(
      'Refer a Friend &',
      name: 'referFriend',
      desc: 'Refer a Friend &',
      args: [],
    );
  }

  /// `Get 50% off`
  String get get50Off {
    return Intl.message(
      'Get 50% off',
      name: 'get50Off',
      desc: 'Get 50% off',
      args: [],
    );
  }

  /// `- Get 50% off upto \$20 after your friend’s 1st order`
  String get get50OffUpto20 {
    return Intl.message(
      '- Get 50% off upto \\\$20 after your friend’s 1st order',
      name: 'get50OffUpto20',
      desc: '- Get 50% off upto \\\$20 after your friend’s 1st order',
      args: [],
    );
  }

  /// `Your friend gets 50% off on their 1st order`
  String get yourFriendGets50Off {
    return Intl.message(
      'Your friend gets 50% off on their 1st order',
      name: 'yourFriendGets50Off',
      desc: 'Your friend gets 50% off on their 1st order',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: 'Edit Profile',
      args: [],
    );
  }

  /// `Update your information below`
  String get updateYourInformation {
    return Intl.message(
      'Update your information below',
      name: 'updateYourInformation',
      desc: 'Update your information below',
      args: [],
    );
  }

  /// `Please add mobile number`
  String get pleaseAddMobileNumber {
    return Intl.message(
      'Please add mobile number',
      name: 'pleaseAddMobileNumber',
      desc: 'Please add mobile number',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobileNumber {
    return Intl.message(
      'Mobile number',
      name: 'mobileNumber',
      desc: 'Mobile number',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Save',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: 'Full Name',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: 'User Name',
      args: [],
    );
  }

  /// `Create Order`
  String get createOrder {
    return Intl.message(
      'Create Order',
      name: 'createOrder',
      desc: 'Create Order',
      args: [],
    );
  }

  /// `Please provide order information below`
  String get pleaseProvideOrderInformation {
    return Intl.message(
      'Please provide order information below',
      name: 'pleaseProvideOrderInformation',
      desc: 'Please provide order information below',
      args: [],
    );
  }

  /// `Please select a date`
  String get pleaseSelectADate {
    return Intl.message(
      'Please select a date',
      name: 'pleaseSelectADate',
      desc: 'Please select a date',
      args: [],
    );
  }

  /// `Please select a valid date`
  String get pleaseSelectValidDate {
    return Intl.message(
      'Please select a valid date',
      name: 'pleaseSelectValidDate',
      desc: 'Please select a valid date',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: 'Select Date',
      args: [],
    );
  }

  /// `Field Required`
  String get fieldRequired {
    return Intl.message(
      'Field Required',
      name: 'fieldRequired',
      desc: 'Field Required',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: 'Select Time',
      args: [],
    );
  }

  /// `Please set location`
  String get pleaseSetLocation {
    return Intl.message(
      'Please set location',
      name: 'pleaseSetLocation',
      desc: 'Please set location',
      args: [],
    );
  }

  /// `Location Set!`
  String get locationSet {
    return Intl.message(
      'Location Set!',
      name: 'locationSet',
      desc: 'Location Set!',
      args: [],
    );
  }

  /// `Map Location`
  String get mapLocation {
    return Intl.message(
      'Map Location',
      name: 'mapLocation',
      desc: 'Map Location',
      args: [],
    );
  }

  /// `Please add address`
  String get pleaseAddAddress {
    return Intl.message(
      'Please add address',
      name: 'pleaseAddAddress',
      desc: 'Please add address',
      args: [],
    );
  }

  /// `Full address`
  String get fullAddress {
    return Intl.message(
      'Full address',
      name: 'fullAddress',
      desc: 'Full address',
      args: [],
    );
  }

  /// `Please add a description`
  String get pleaseAddADescription {
    return Intl.message(
      'Please add a description',
      name: 'pleaseAddADescription',
      desc: 'Please add a description',
      args: [],
    );
  }

  /// `Write your notes here`
  String get writeYourNotesHere {
    return Intl.message(
      'Write your notes here',
      name: 'writeYourNotesHere',
      desc: 'Write your notes here',
      args: [],
    );
  }

  /// `Server didn't respond, please try again`
  String get serverDidNotRespond {
    return Intl.message(
      'Server didn\'t respond, please try again',
      name: 'serverDidNotRespond',
      desc: 'Server didn\'t respond, please try again',
      args: [],
    );
  }

  /// `Order created successfully`
  String get orderCreatedSuccessfully {
    return Intl.message(
      'Order created successfully',
      name: 'orderCreatedSuccessfully',
      desc: 'Order created successfully',
      args: [],
    );
  }

  /// `What you are looking`
  String get whatYouAreLooking {
    return Intl.message(
      'What you are looking',
      name: 'whatYouAreLooking',
      desc: 'What you are looking',
      args: [],
    );
  }

  /// `Search what you need...`
  String get searchWhatYouNeed {
    return Intl.message(
      'Search what you need...',
      name: 'searchWhatYouNeed',
      desc: 'Search what you need...',
      args: [],
    );
  }

  /// `for today`
  String get forToday {
    return Intl.message(
      'for today',
      name: 'forToday',
      desc: 'for today',
      args: [],
    );
  }

  /// `Beauty Services`
  String get beautyServices {
    return Intl.message(
      'Beauty Services',
      name: 'beautyServices',
      desc: 'Beauty Services',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: 'See All',
      args: [],
    );
  }

  /// `Cleaning Services`
  String get cleaningServices {
    return Intl.message(
      'Cleaning Services',
      name: 'cleaningServices',
      desc: 'Cleaning Services',
      args: [],
    );
  }

  /// `Car wash`
  String get carWash {
    return Intl.message(
      'Car wash',
      name: 'carWash',
      desc: 'Car wash',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Home',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: 'Payment Methods',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: 'Address',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message(
      'Pay Now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `Cash On Delivery`
  String get cashOndelivery {
    return Intl.message(
      'Cash On Delivery',
      name: 'cashOndelivery',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: 'Notifications',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: 'Offers',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: 'Support',
      args: [],
    );
  }

  /// `Colour Scheme`
  String get colourScheme {
    return Intl.message(
      'Colour Scheme',
      name: 'colourScheme',
      desc: 'Colour Scheme',
      args: [],
    );
  }

  /// `  Light`
  String get light {
    return Intl.message(
      '  Light',
      name: 'light',
      desc: '  Light',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: 'Dark',
      args: [],
    );
  }

  /// `CURRENT LOCATION`
  String get currentLocation {
    return Intl.message(
      'CURRENT LOCATION',
      name: 'currentLocation',
      desc: 'CURRENT LOCATION',
      args: [],
    );
  }

  /// `15A, James Street`
  String get jamesStreet {
    return Intl.message(
      '15A, James Street',
      name: 'jamesStreet',
      desc: '15A, James Street',
      args: [],
    );
  }

  /// `I Notifications`
  String get iNotifications {
    return Intl.message(
      'I Notifications',
      name: 'iNotifications',
      desc: 'I Notifications',
      args: [],
    );
  }

  /// `Recent `
  String get recent {
    return Intl.message(
      'Recent ',
      name: 'recent',
      desc: 'Recent ',
      args: [],
    );
  }

  /// `I Profile`
  String get iProfile {
    return Intl.message(
      'I Profile',
      name: 'iProfile',
      desc: 'I Profile',
      args: [],
    );
  }

  /// `Select Location`
  String get selectLocation {
    return Intl.message(
      'Select Location',
      name: 'selectLocation',
      desc: 'Select Location',
      args: [],
    );
  }

  /// `Save Address`
  String get saveAddress {
    return Intl.message(
      'Save Address',
      name: 'saveAddress',
      desc: 'Save Address',
      args: [],
    );
  }

  /// `No Notifications!`
  String get noNotifications {
    return Intl.message(
      'No Notifications!',
      name: 'noNotifications',
      desc: 'No Notifications!',
      args: [],
    );
  }

  /// `You don't have any notification yet. Please place order`
  String get youDoNotHaveNotificationYet {
    return Intl.message(
      'You don\'t have any notification yet. Please place order',
      name: 'youDoNotHaveNotificationYet',
      desc: 'You don\'t have any notification yet. Please place order',
      args: [],
    );
  }

  /// `Search by name, price..`
  String get searchByNamePrice {
    return Intl.message(
      'Search by name, price..',
      name: 'searchByNamePrice',
      desc: 'Search by name, price..',
      args: [],
    );
  }

  /// `Starts From`
  String get startsFrom {
    return Intl.message(
      'Starts From',
      name: 'startsFrom',
      desc: 'Starts From',
      args: [],
    );
  }

  /// `My Location`
  String get myLocation {
    return Intl.message(
      'My Location',
      name: 'myLocation',
      desc: 'My Location',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: 'Rate',
      args: [],
    );
  }

  /// `Rate Service`
  String get rateService {
    return Intl.message(
      'Rate Service',
      name: 'rateService',
      desc: 'Rate Service',
      args: [],
    );
  }

  /// `Type of Property`
  String get typeOfProperty {
    return Intl.message(
      'Type of Property',
      name: 'typeOfProperty',
      desc: 'Type of Property',
      args: [],
    );
  }

  /// `At Home`
  String get atHome {
    return Intl.message(
      'At Home',
      name: 'atHome',
      desc: 'At Home',
      args: [],
    );
  }

  /// `At Site`
  String get atSite {
    return Intl.message(
      'At Site',
      name: 'atSite',
      desc: 'At Site',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: 'Office',
      args: [],
    );
  }

  /// `Villa`
  String get vila {
    return Intl.message(
      'Villa',
      name: 'vila',
      desc: 'Villa',
      args: [],
    );
  }

  /// `Old`
  String get old {
    return Intl.message(
      'Old',
      name: 'old',
      desc: 'Old',
      args: [],
    );
  }

  /// `New`
  String get newNew {
    return Intl.message(
      'New',
      name: 'newNew',
      desc: 'New',
      args: [],
    );
  }

  /// `Service cost`
  String get serviceCost {
    return Intl.message(
      'Service cost',
      name: 'serviceCost',
      desc: 'Service cost',
      args: [],
    );
  }

  /// `Total cost`
  String get totalCost {
    return Intl.message(
      'Total cost',
      name: 'totalCost',
      desc: 'Total cost',
      args: [],
    );
  }

  /// `ColorPicker`
  String get colorPicker {
    return Intl.message(
      'ColorPicker',
      name: 'colorPicker',
      desc: 'ColorPicker',
      args: [],
    );
  }

  /// `Total:  AED`
  String get totalAED {
    return Intl.message(
      'Total:  AED',
      name: 'totalAED',
      desc: 'Total:  AED',
      args: [],
    );
  }

  /// `Bill Details`
  String get billDetails {
    return Intl.message(
      'Bill Details',
      name: 'billDetails',
      desc: 'Bill Details',
      args: [],
    );
  }

  /// `Save Draft`
  String get saveDraft {
    return Intl.message(
      'Save Draft',
      name: 'saveDraft',
      desc: 'Save Draft',
      args: [],
    );
  }

  /// `Book Now`
  String get bookNow {
    return Intl.message(
      'Book Now',
      name: 'bookNow',
      desc: 'Book Now',
      args: [],
    );
  }

  /// `Book Now`
  String get booking{
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: 'Booking',
      args: [],
    );
  }

  /// `Search by name, location..`
  String get searchByNameLocation {
    return Intl.message(
      'Search by name, location..',
      name: 'searchByNameLocation',
      desc: 'Search by name, location..',
      args: [],
    );
  }

  /// `I`
  String get i {
    return Intl.message(
      'I',
      name: 'i',
      desc: 'I',
      args: [],
    );
  }

  /// ` Providers`
  String get providers {
    return Intl.message(
      ' Providers',
      name: 'providers',
      desc: ' Providers',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: 'Recommended',
      args: [],
    );
  }

  /// `Products, `
  String get products {
    return Intl.message(
      'Products, ',
      name: 'products',
      desc: 'Products, ',
      args: [],
    );
  }

  /// `Explore!`
  String get explore {
    return Intl.message(
      'Explore!',
      name: 'explore',
      desc: 'Explore!',
      args: [],
    );
  }

  /// `Visit`
  String get visit {
    return Intl.message(
      'Visit',
      name: 'visit',
      desc: 'Visit',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: 'Product',
      args: [],
    );
  }

  /// `Password is Required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is Required',
      name: 'passwordIsRequired',
      desc: 'Password is Required',
      args: [],
    );
  }

  /// `Password must minimum eight characters`
  String get passwordMustMinimumEightCharacters {
    return Intl.message(
      'Password must minimum eight characters',
      name: 'passwordMustMinimumEightCharacters',
      desc: 'Password must minimum eight characters',
      args: [],
    );
  }

  /// `Password at least one uppercase letter, one lowercase letter and one number`
  String get passwordAtLeastOneUppercaseLetter {
    return Intl.message(
      'Password at least one uppercase letter, one lowercase letter and one number',
      name: 'passwordAtLeastOneUppercaseLetter',
      desc:
          'Password at least one uppercase letter, one lowercase letter and one number',
      args: [],
    );
  }

  /// `days ago`
  String get daysAgo {
    return Intl.message(
      'days ago',
      name: 'daysAgo',
      desc: 'days ago',
      args: [],
    );
  }

  /// `hours ago`
  String get hoursAgo {
    return Intl.message(
      'hours ago',
      name: 'hoursAgo',
      desc: 'hours ago',
      args: [],
    );
  }

  /// `minutes ago`
  String get minutesAgo {
    return Intl.message(
      'minutes ago',
      name: 'minutesAgo',
      desc: 'minutes ago',
      args: [],
    );
  }

  /// `seconds ago`
  String get secondsAgo {
    return Intl.message(
      'seconds ago',
      name: 'secondsAgo',
      desc: 'seconds ago',
      args: [],
    );
  }

  /// `just now`
  String get justNow {
    return Intl.message(
      'just now',
      name: 'justNow',
      desc: 'just now',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: 'Phone',
      args: [],
    );
  }

  /// `Your data is under processing, please be patient....`
  String get paymentLoadingMsg {
    return Intl.message(
      'Your data is under processing, please be patient....',
      name: 'paymentLoadingMsg',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePage {
    return Intl.message(
      'Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }
  /// `terms of use`
  String get termsOfUse {
    return Intl.message(
      'terms of use',
      name: 'termsOfUse',
      desc: 'terms of use',
      args: [],
    );
  }
  /// `delete account
  String get deleteAccount {
    return Intl.message(
      'delete account',
      name: 'deleteAccount',
      desc: 'delete account',
      args: [],
    );
  }

  /// `logout
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: 'logout',
      args: [],
    );
  }
  /// `privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'privacy policy',
      name: 'privacyPolicy',
      desc: 'privacy policy',
      args: [],
    );
  }
  /// `makeUp`
  String get makeUp {
    return Intl.message(
      'makeUp',
      name: 'makeUp',
      desc: 'makeUp',
      args: [],
    );
  }
  String get beautySalonService {
    return Intl.message(
      'beauty salon service',
      name: 'beautySalonService',
      desc: 'makeUp',
      args: [],
    );
  }
  String get carWasher {
    return Intl.message(
      'car washer',
      name: 'carWasher',
      desc: 'car washer',
      args: [],
    );
  }
  String get carWasherService {
    return Intl.message(
      'car washer Service',
      name: 'carWasherService',
      desc: '',
      args: [],
    );
  }
  String get cleaner {
    return Intl.message(
      'cleaner',
      name: 'cleaner',
      desc: '',
      args: [],
    );
  }
  String get onDemandHomeService {
    return Intl.message(
      'onDemand home service',
      name: 'onDemandHomeService',
      desc: '',
      args: [],
    );
  }
  String get skip {
    return Intl.message(
      'skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  String get guestNotAllowedToPay {
    return Intl.message(
      'guest not allowed to pay',
      name: 'guestNotAllowedToPay',
      desc: '',
      args: [],
    );
  }

  String get start {
    return Intl.message(
      'start',
      name: 'start',
      desc: '',
      args: [],
    );
  }
}




/// `Home Page`
// String get locationPermissionNotGiven {
//   return Intl.message(
//     'Home Page',
//     name: 'homePage',
//     desc: '',
//     args: [],
//   );
// }


class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
