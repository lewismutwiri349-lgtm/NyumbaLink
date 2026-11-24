/// Listing lifecycle states (Constitution Art. 17). Allowed transitions are
/// not yet defined (SOFTWARE_REQUIREMENTS, "Listing status lifecycle").
enum ListingStatus {
  submitted,
  pending,
  approved,
  rejected,
  suspended,
  occupied;

  String get label => switch (this) {
        ListingStatus.submitted => 'Submitted',
        ListingStatus.pending => 'Pending review',
        ListingStatus.approved => 'Approved',
        ListingStatus.rejected => 'Rejected',
        ListingStatus.suspended => 'Suspended',
        ListingStatus.occupied => 'Occupied',
      };
}
