import 'package:flutter/material.dart';

import 'app.dart';

/// Entry point of the tenant and landlord app.
///
/// The administration section is a separate application with its own entry
/// point (ADR-002, founder decision D14). Nothing administrative is
/// reachable from here.
void main() {
  runApp(const NyumbaLinkApp());
}
