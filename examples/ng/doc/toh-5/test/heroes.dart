// #docregion
@Tags(const ['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_tour_of_heroes/heroes_component.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'heroes_po.dart';

NgTestFixture<HeroesComponent> fixture;
HeroesPO po;

final mockRouter = new MockRouter();

class MockRouter extends Mock implements Router {}

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<HeroesComponent>().addProviders([
    provide(Router, useValue: mockRouter),
    HeroService,
  ]);

  setUp(() async {
    fixture = await testBed.create();
    po = await fixture.resolvePageObject(HeroesPO);
  });

  tearDown(disposeAnyRunningTest);

  group('Basics:', basicTests);
  group('Selected hero:', selectedHeroTests);
}

void basicTests() {
  test('title', () async {
    expect(await po.title, 'My Heroes');
  });

  test('hero count', () async {
    await fixture.update();
    expect(po.heroes.length, 10);
  });

  test('no selected hero', () async {
    expect(await po.selectedHero, null);
  });
}

void selectedHeroTests() {
  const targetHero = const {'id': 15, 'name': 'Magneta'};

  setUp(() async {
    await po.clickHero(4);
    po = await fixture.resolvePageObject(HeroesPO);
  });

  test('is selected', () async {
    expect(await po.selectedHero, targetHero);
  });

  test('show mini-detail', () async {
    expect(
        await po.myHeroNameInUppercase, equalsIgnoringCase(targetHero['name']));
  });

  test('go to detail', () async {
    await po.gotoDetail();
    verify(mockRouter.navigate([
      'HeroDetail',
      {'id': '${targetHero['id']}'}
    ]));
  });

  test('select another hero', () async {
    await po.clickHero(0);
    po = await fixture.resolvePageObject(HeroesPO);
    final heroData = {'id': 11, 'name': 'Mr. Nice'};
    expect(await po.selectedHero, heroData);
  });
}
