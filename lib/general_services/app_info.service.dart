import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

abstract class ApplicationInformationService {
  static PackageInfo? _packageInfo;

  // Constructor to initialize package info once
  ApplicationInformationService() {
    _initPackageInfo();
  }

  static Future<void> _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static Future<String> getAppName() async {
    // Ensure package info is initialized
    await _ensurePackageInfoInitialized();
    return _packageInfo!.appName;
  }

  static Future<String> getAppPackageName() async {
    await _ensurePackageInfoInitialized();
    return _packageInfo!.packageName;
  }

  static Future<String> getAppVersion() async {
    await _ensurePackageInfoInitialized();
    return _packageInfo!.version;
  }

  static Future<String> getAppDescription() async {
    // Load the pubspec.yaml file
    final pubspecContent = await rootBundle.loadString('pubspec.yaml');
    // Parse the YAML content
    final yamlMap = loadYaml(pubspecContent);
    // Extract the description
    final description = yamlMap['description'] as String;
    return description;
  }

  static Future<String> getAppBuildNumber() async {
    await _ensurePackageInfoInitialized();
    return _packageInfo!.buildNumber;
  }

  static Future<void> _ensurePackageInfoInitialized() async {
    // Wait for initialization if it hasn't completed
    if (_packageInfo == null) {
      await _initPackageInfo();
    }
  }
}
