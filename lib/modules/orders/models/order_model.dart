enum OrderStatus { delivered }

class OrderModel {
  final String id;
  final String date;
  final double amount;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
  });
}

List<OrderModel> orderModelList = [
  OrderModel(
    id: '1947034',
    date: "05-12-2023",
    amount: 950,
    status: OrderStatus.delivered,
  ),
  OrderModel(
    id: '1947034',
    date: "05-12-2023",
    amount: 950,
    status: OrderStatus.delivered,
  ),
  OrderModel(
    id: '1947034',
    date: "05-12-2023",
    amount: 950,
    status: OrderStatus.delivered,
  ),
  OrderModel(
    id: '1947034',
    date: "05-12-2023",
    amount: 950,
    status: OrderStatus.delivered,
  ),
];
