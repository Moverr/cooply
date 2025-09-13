
class CoopCalculator {
  // Default values
  static const double _defaultLoss = 0.15;
  static const double _defaultSpace = 0.16; // layers (m²/bird)
  static const double _defaultClimate = 1.15;

  /// Enum to identify coop types
  static const CoopType = {
    'deepLitter': 'DEEP_LITTER',
    'cage': 'CAGE',
    'freeRange': 'FREE_RANGE',
    'other': 'OTHER',
  };

  /// Default capacity calculator
  static double calculateCapacity(double grossAreaM2) {
    return calculateCapacityWithFactors(
      grossAreaM2,
      _defaultLoss,
      _defaultSpace,
      _defaultClimate,
    );
  }

  /// Calculate capacity by coop type
  static double calculateCapacityByType(double grossAreaM2, String type) {
    switch (type) {
      case 'CAGE':
        return calculateCapacityWithFactors(grossAreaM2, 0.05, 0.05, 1.05);
      case 'FREE_RANGE':
        return calculateCapacityWithFactors(grossAreaM2, 0.15, 0.20, 1.20);
      case 'DEEP_LITTER':
      case 'OTHER':
      default:
        return calculateCapacityWithFactors(grossAreaM2, 0.15, 0.16, 1.15);
    }
  }

  /// Main capacity calculation
  static double calculateCapacityWithFactors(
      double grossAreaM2,
      double lossFraction,
      double spacePerBirdM2,
      double climateFactor,
      ) {
    final usableArea = grossAreaM2 * (1 - lossFraction);
    final adjustedSpace = spacePerBirdM2 * climateFactor;
    return (usableArea / adjustedSpace);
  }
}

/***
 * EXAMPLE
    int deepLitter = CoopCalculator.calculateCapacityByType(coopArea, 'DEEP_LITTER');
    int cage = CoopCalculator.calculateCapacityByType(coopArea, 'CAGE');
    int freeRange = CoopCalculator.calculateCapacityByType(coopArea, 'FREE_RANGE');

    print("Deep Litter capacity: $deepLitter birds");
    print("Cage capacity: $cage birds");
    print("Free Range capacity: $freeRange birds");

 */

