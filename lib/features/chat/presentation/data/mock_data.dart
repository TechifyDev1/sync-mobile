import '../../../status/presentation/model/status_list.dart';

final List<StatusList> statusLists = [
  StatusList(
    id: "1",
    name: "John Doe",
    profileImageUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    time: DateTime.now().subtract(const Duration(minutes: 5)),
    isViewed: false,
  ),
  StatusList(
    id: "2",
    name: "Jane Smith",
    profileImageUrl: "https://randomuser.me/api/portraits/women/2.jpg",
    time: DateTime.now().subtract(const Duration(hours: 1)),
    isViewed: false,
  ),
  StatusList(
    id: "3",
    name: "Alice Johnson",
    profileImageUrl: "https://randomuser.me/api/portraits/women/3.jpg",
    time: DateTime.now().subtract(const Duration(hours: 1)),
    isViewed: false,
  ),
  StatusList(
    id: "4",
    name: "Bob Brown",
    profileImageUrl: "https://randomuser.me/api/portraits/men/4.jpg",
    time: DateTime.now().subtract(const Duration(hours: 2)),
    isViewed: true,
  ),
  StatusList(
    id: "5",
    name: "Charlie Davis",
    profileImageUrl: "https://randomuser.me/api/portraits/men/5.jpg",
    time: DateTime.now().subtract(const Duration(hours: 3)),
    isViewed: true,
  ),
  StatusList(
    id: "6",
    name: "Bob Davis",
    profileImageUrl: "https://randomuser.me/api/portraits/men/6.jpg",
    time: DateTime.now().subtract(const Duration(hours: 5)),
    isViewed: true,
  ),
];
