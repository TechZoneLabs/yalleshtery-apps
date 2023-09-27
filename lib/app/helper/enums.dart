enum Status { sleep, initial, loading, loaded, updating, updated, error }

enum TempProductsType { lastest, bestSeler, other }

enum SortStatus { lh, hl, newAdded }

enum DefaultStatus { yes, no }

enum MapStatus {
  uninitialized,
  initializing,
  initialized,
  restLocation,
  dataSelected,
}

enum LocationStatus {
  sleep,
  checkPermission,
  permissionDenied,
  permissionAlways,
}
