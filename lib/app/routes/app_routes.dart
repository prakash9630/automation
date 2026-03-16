// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const OTP = _Paths.OTP;
  static const PROJECT = _Paths.PROJECT;
  static const RECORD_DETAIL = _Paths.RECORD_DETAIL;
  static const COMMENTS = _Paths.COMMENTS;
  static const PAYMENT = _Paths.PAYMENT;
  static const FILES = _Paths.FILES;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const ATTENDANCE = _Paths.ATTENDANCE;
  static const VISITOR = _Paths.VISITOR;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const SPLASH = _Paths.SPLASH;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const OTP = '/otp';
  static const PROJECT = '/project';
  static const RECORD_DETAIL = '/record-detail';
  static const COMMENTS = '/comments';
  static const PAYMENT = '/payment';
  static const FILES = '/files';
  static const NOTIFICATIONS = '/notifications';
  static const ATTENDANCE = '/attendance';
  static const VISITOR = '/visitor';
  static const DASHBOARD = '/dashboard';
  static const SPLASH = '/splash';
}
