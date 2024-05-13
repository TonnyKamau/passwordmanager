import 'package:equatable/equatable.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MenuModel extends Equatable {
  final icon;
  final String title;
  MenuModel({
    required this.icon,
    required this.title,
  });

  static List<MenuModel> menuItems = [
    MenuModel(icon: LucideIcons.home, title: 'Main'),
    // accounts menu
    MenuModel(icon: LucideIcons.user, title: 'Accounts'),
    //bank cards menu
    MenuModel(icon: LucideIcons.creditCard, title: 'Bank Cards'),
    //documents menu
    MenuModel(icon: LucideIcons.fileText, title: 'Documents'),
    //address
    MenuModel(icon: LucideIcons.mapPin, title: 'Address'),
    //Notes menu
    MenuModel(icon: LucideIcons.book, title: 'Notes'),
  ];

  @override
  List<Object> get props => [title, icon];
}
