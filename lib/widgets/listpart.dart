import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordmanager/colors/colors.dart';

class ListPart extends StatelessWidget {
  const ListPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
             
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Recently added',
                      style: TextStyle(
                        color: sideMenuIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1,
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              'Item $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              'Subtitle $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: SvgPicture.asset(
                                'assets/user-shield-alt-1.svg',
                                width: 20,
                                height: 20,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ),
                            trailing: Text(
                              '$index',
                              style:  TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Favorites',
                      style: TextStyle(
                        color: sideMenuIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1,
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              'Item $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              'Subtitle $index',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: SvgPicture.asset(
                                'assets/user-shield-alt-1.svg',
                                width: 20,
                                height: 20,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ),
                            trailing: Text(
                              '$index',
                              style:  TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
