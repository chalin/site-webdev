// #docregion
import 'package:angular2/core.dart';

import 'car_components.dart';
import 'heroes_list_component.dart';
import 'heroes_service.dart';
import 'villains_list_component.dart';

@Component(
    selector: 'my-app',
    template: '''
      <label><input type="checkbox" [checked]="showHeroes"   (change)="showHeroes=!showHeroes">Heroes</label>
      <label><input type="checkbox" [checked]="showVillains" (change)="showVillains=!showVillains">Villains</label>
      <label><input type="checkbox" [checked]="showCars"     (change)="showCars=!showCars">Cars</label>

      <h1>Hierarchical Dependency Injection</h1>

      <heroes-list   *ngIf="showHeroes"></heroes-list>
      <villains-list *ngIf="showVillains"></villains-list>
      <my-cars       *ngIf="showCars"></my-cars>
    ''',
    directives: const [
      carComponents,
      HeroesListComponent,
      VillainsListComponent
    ],
    providers: const [
      carServices,
      HeroesService
    ])
class AppComponent {
  bool showCars = true;
  bool showHeroes = true;
  bool showVillains = true;
}