import 'package:equatable/equatable.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MenuModel extends Equatable {
  final icon;
  final String title;
  const MenuModel({
    required this.icon,
    required this.title,
  });

  static List<MenuModel> menuItems = [
    const MenuModel(icon: LucideIcons.home, title: 'Main'),
    // accounts menu
    const MenuModel(icon: LucideIcons.user, title: 'Accounts'),
    //bank cards menu
    const MenuModel(icon: LucideIcons.creditCard, title: 'Bank Cards'),
    //documents menu
    const MenuModel(icon: LucideIcons.fileText, title: 'Documents'),
    //address
    const MenuModel(icon: LucideIcons.mapPin, title: 'Address'),
    //Notes menu
    const MenuModel(icon: LucideIcons.book, title: 'Notes'),
  ];

  @override
  List<Object> get props => [title, icon];
}
