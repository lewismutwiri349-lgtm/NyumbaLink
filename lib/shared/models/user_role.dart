/// Roles a person can choose when registering in the main app.
///
/// Administrator is deliberately absent: admin identity is never selectable
/// or creatable from this app (D14, NFR-SEC-04). Administration is a separate
/// application.
enum UserRole {
  tenant,
  landlord;

  String get label => switch (this) {
        UserRole.tenant => 'Tenant',
        UserRole.landlord => 'Landlord',
      };
}
