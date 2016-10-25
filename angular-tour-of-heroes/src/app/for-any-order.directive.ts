import { Directive, Input, Component, DoCheck,
         IterableDiffers, ChangeDetectorRef, IterableDiffer } from '@angular/core';
import { TemplateRef, ViewContainerRef, ViewRef } from '@angular/core';

@Directive({ 
    selector: '[forAnyOrder]',
    inputs:['forAnyOrderOf']
})
export class ForAnyOrder implements DoCheck
{
    private collection:any;
    private differ:IterableDiffer;

    private viewMap:Map<any, ViewRef> = new Map<any, ViewRef>();

    
    constructor(private changeDetector:ChangeDetectorRef,
                private differs:IterableDiffers,
                private template:TemplateRef<any>,
                private viewContainer:ViewContainerRef)
    {
    }

    set forAnyOrderOf(coll:any)
    {
        this.collection = coll;

        if (coll && !this.differ)
        {
            // find method returns a factory for the correct type of differ
            this.differ = this.differs.find(coll).create(this.changeDetector);
        }
    }

    ngDoCheck()
    {
        if (this.differ)
        {
            const changes = this.differ.diff(this.collection);

            if (changes)
            {
                changes.forEachAddedItem((change) => {
                    // we use the view container and the template together to construct and attach a new view.
                    const view = this.viewContainer.createEmbeddedView(this.template);
                    view.context.$implicit = change.item;
                    this.viewMap.set(change.item, view);
                    this.viewContainer.createEmbeddedView(this.template);
                });
                changes.forEachRemovedItem((change) => {
                    // 1. Get the view from our map.
                    // 2. 
                });
            }
        }
    }
}

/*
    <template forAnyOrder #thing [forAnyOrderOf] = "allTheThings">
        <div> {{ thing }} </div>
    </template>

 */
@Component({
    selector: 'my-component',
    template: `
        <div *forAnyOrder="#thing of allTheThings">
            {{thing}}
        </div>
    `
})
class MyComponent
{
    allTheThings = [1,2,3];

}