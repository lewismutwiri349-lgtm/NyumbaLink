import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/prototype/design_gallery_screen.dart';

/// Root widget of the tenant and landlord app.
///
/// Phase 1, step 1A: the home screen is a temporary design gallery. It is
/// replaced by the welcome screen in step 1B.
class NyumbaLinkApp extends StatelessWidget {
  const NyumbaLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      home: const DesignGalleryScreen(),
    );
  }
}
