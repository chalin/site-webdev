// #docregion
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/angular_components.dart';

import 'src/hero.dart';
import 'src/hero_switch_components.dart';
import 'src/if_not_empty_directive.dart';
import 'src/unless_directive.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: const ['app_component.css'],
  directives: const [
    CORE_DIRECTIVES,
    formDirectives,
    heroSwitchComponents,
    ifNotEmptyDirective,
    materialDirectives,
    UnlessDirective
  ],
  providers: const [materialProviders],
)
class AppComponent {
  final List<Hero> heroes = mockHeroes;
  Hero hero;
  bool condition = false;
  final List<String> logs = [];
  bool showSad = true;
  String status = 'ready';

  AppComponent() {
    hero = heroes[0];
  }

  // #docregion trackByHero
  num trackById(num index, Hero hero) => hero.id;
  // #enddocregion trackByHero
}
