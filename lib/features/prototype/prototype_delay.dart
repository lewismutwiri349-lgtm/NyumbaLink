/// Stands in for a network call so loading states can be designed.
/// Removed in Phase 2, when the real backend is connected.
Future<void> simulateNetworkDelay() {
  return Future<void>.delayed(const Duration(milliseconds: 700));
}
