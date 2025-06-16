import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

abstract class NavigationService {
  void pushNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String>? pathParameters,
  });

  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void navigateBack({required BuildContext context});

  Future<void> launchUrl({
    required String urlString,
    required bool external,
  });
}

class GoRouterNavigationService extends NavigationService
    with NavigationServiceMixins {
  GoRouterNavigationService();

  @override
  void pushNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.pushNamed(
        uri,
        extra: data,
      );

  @override
  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String>? pathParameters,
  }) =>
      context.goNamed(
        uri,
        extra: data,
        pathParameters: pathParameters ?? {},
      );

  @override
  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.goNamed(uri, extra: data);

  @override
  void navigateBack({required BuildContext context}) => context.pop();
}

mixin NavigationServiceMixins implements NavigationService {
  @override
  Future<void> launchUrl({
    required String urlString,
    required bool external,
  }) async {
    if (await launcher.canLaunchUrl(Uri.parse(urlString))) {
      await launcher.launchUrl(
        Uri.parse(urlString),
        mode: external
            ? launcher.LaunchMode.externalApplication
            : launcher.LaunchMode.inAppWebView,
      );
    }
  }
}
