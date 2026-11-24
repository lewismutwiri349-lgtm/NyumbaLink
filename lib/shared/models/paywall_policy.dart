/// What stays withheld from a tenant until payment, as decided by an
/// administrator for a listing (D16, ADR-011).
///
/// The landlord's phone number is always withheld until payment (D9) and is
/// therefore not part of this policy. Landlords cannot change this policy.
///
/// The defaults withhold everything until an administrator decides, which is
/// the safe choice. Whether the decision is per listing or platform-wide is
/// still an open question (Q15).
class PaywallPolicy {
  const PaywallPolicy({
    this.blurPhotos = true,
    this.hideExactLocation = true,
  });

  /// Show photographs blurred before payment.
  final bool blurPhotos;

  /// Hide the exact map location before payment.
  final bool hideExactLocation;
}
