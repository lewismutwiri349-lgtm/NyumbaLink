/// PROVISIONAL fee for viewing a rental, for screen design only.
///
/// Bands follow decision D8 with the unresolved 5,001 to 6,000 gap filled as
/// 600 (open question Q1). In the real system the amount is calculated on
/// the server from the `fee_tiers` table and the client can never set it
/// (FR-PAY-01).
int provisionalFeeForRentKes(int rentKes) {
  if (rentKes <= 3000) {
    return 200;
  }
  if (rentKes <= 5000) {
    return 500;
  }
  return 600;
}
