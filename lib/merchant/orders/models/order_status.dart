enum OrderStatus { readyToShip, notavailable }

Map<OrderStatus, String> orderStatusMap = {
  OrderStatus.readyToShip: "Ready for shipping",
  OrderStatus.notavailable: "Not available"
};
Map<OrderStatus, String> orderStatusApiKeys = {
  OrderStatus.readyToShip: "ready_to_ship",
  OrderStatus.notavailable: "not_available"
};
