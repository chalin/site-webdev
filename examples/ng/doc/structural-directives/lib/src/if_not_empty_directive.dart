import 'package:angular/angular.dart';

@Directive(selector: '[myIfNotEmpty]')
void ifNotEmptyDirective(
  @Attribute('myIfNotEmpty') String attrValue,
  ViewContainerRef viewContainerRef,
  TemplateRef templateRef,
) {
  if (attrValue.isNotEmpty) {
    viewContainerRef.createEmbeddedView(templateRef);
  }
}
