// #docregion
import 'package:angular2/core.dart';

@Component(
    selector: 'my-heroes',
    // #docregion template
    template: '''
      <h2>Heroes</h2>
      <p>Get your heroes here</p>
    '''
    // #enddocregion template
)
class HeroesComponent { }
