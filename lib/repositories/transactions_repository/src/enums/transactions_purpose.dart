enum TransactionPurpose {
  rent,
  autoInsurance,
  healthInsurance,
  medicalCosts,
  electricity,
  water,
  sanitation,
  internet,
  carPayment,
  gasoline,
  publicTransportation,
  food,
  clothing,
  gym,
  movies,
  homeDecor,
  alcohol,
  largePurchase,
  none,
}

TransactionPurpose stringToTransactionPurpose(String value) {
  if (value == 'rent') {
    return TransactionPurpose.rent;
  } else if (value == 'autoInsurance') {
    return TransactionPurpose.autoInsurance;
  } else if (value == 'healthInsurance') {
    return TransactionPurpose.healthInsurance;
  } else if (value == 'medicalCosts') {
    return TransactionPurpose.medicalCosts;
  } else if (value == 'electricity') {
    return TransactionPurpose.electricity;
  } else if (value == 'water') {
    return TransactionPurpose.water;
  } else if (value == 'sanitation') {
    return TransactionPurpose.sanitation;
  } else if (value == 'internet') {
    return TransactionPurpose.internet;
  } else if (value == 'carPayment') {
    return TransactionPurpose.carPayment;
  } else if (value == 'gasoline') {
    return TransactionPurpose.gasoline;
  } else if (value == 'publicTransportation') {
    return TransactionPurpose.publicTransportation;
  } else if (value == 'food') {
    return TransactionPurpose.food;
  } else if (value == 'clothing') {
    return TransactionPurpose.clothing;
  } else if (value == 'gym') {
    return TransactionPurpose.gym;
  } else if (value == 'movies') {
    return TransactionPurpose.movies;
  } else if (value == 'homeDecor') {
    return TransactionPurpose.homeDecor;
  } else if (value == 'alcohol') {
    return TransactionPurpose.alcohol;
  } else if (value == 'largePurchase') {
    return TransactionPurpose.largePurchase;
  } else {
    return TransactionPurpose.none;
  }
}
