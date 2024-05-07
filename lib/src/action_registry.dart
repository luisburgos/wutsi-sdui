import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'logger.dart';

typedef SDUIActionFactory = Future<String?> Function(
  BuildContext context,
  Map<String, dynamic>? data,
);

/// Registry for 3rd party Actions
class SDUIActionRegistry {
  static final SDUIActionRegistry _singleton = SDUIActionRegistry._internal();
  final Map<String, SDUIActionFactory> _factories = {};
  final Logger _logger = LoggerFactory.create('SDUIActionRegistry');

  SDUIActionRegistry._internal();

  factory SDUIActionRegistry() {
    return _singleton;
  }

  static SDUIActionRegistry getInstance() => _singleton;

  bool register(String type, SDUIActionFactory factory) {
    String key = type.toLowerCase();
    if (_factories.containsKey(key)) {
      _logger.w('Action already registered, registration skipped: $type');
      return false;
    } else {
      _logger.i('Registering Action: $type');
      _factories[key] = factory;
      return true;
    }
  }

  Future<String?>? execute(
    String type,
    BuildContext context,
    Map<String, dynamic>? data,
  ) {
    SDUIActionFactory? factory = _factories[type.toLowerCase()];
    return factory?.call(context, data);
  }
}
