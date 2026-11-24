import 'listing_status.dart';
import 'paywall_policy.dart';

/// A rental listing as the prototype screens see it.
///
/// PROTOTYPE ONLY: [landlordPhone] is held on the device here so screens can
/// be designed. In the real system the number is never delivered to a device
/// before payment is confirmed (NFR-SEC-05, enforced by the server).
class PropertyListing {
  const PropertyListing({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.rentKes,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaName,
    required this.landlordPhone,
    required this.photoCount,
    required this.status,
    this.paywallPolicy = const PaywallPolicy(),
  });

  final String id;
  final String title;
  final String description;

  /// Free text for now: listing categories are an open question (Q14).
  final String category;

  /// Monthly rent in whole Kenyan shillings.
  final int rentKes;

  /// A bedsitter or single room has 0 bedrooms.
  final int bedrooms;
  final int bathrooms;
  final String areaName;
  final String landlordPhone;

  /// Number of photographs. The prototype draws placeholders, not images.
  final int photoCount;
  final ListingStatus status;
  final PaywallPolicy paywallPolicy;
}
