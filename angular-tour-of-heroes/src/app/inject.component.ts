import { Component, ComponentResolver, ViewChild, ViewContainerRef, 
    ComponentFactory, ComponentRef } from '@angular/core';

@Component({
    selector: 'inject-component',
    inputs: ['model'],
    template: `
        <div #toreplace></div>
    `
})
export class InjectComponent {
    model: any;
    @ViewChild('toreplace', {read: ViewContainerRef}) toreplace;
    componentRef: ComponentRef<any>;

    constructor(private resolver: ComponentResolver) {}

    ngOnInit() {
        this.resolver.resolveComponent(this.createWrapper()).then((factory:ComponentFactory<any>) => {
            this.componentRef = this.toreplace.createComponent(factory);
        });
    }
    createWrapper(): any {
        var model = this.model;
        @Component({
            selector: model.selector + '-wrapper',
            directives: [ model.directives ],
            template: '<' + model.selector + ' [model]="model"></' + model.selector + '>'
        })
        class Wrapper {
            model: any = model;
        }

        return Wrapper;
    }
}