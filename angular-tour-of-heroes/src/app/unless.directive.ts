import { Directive, Input } from '@angular/core';
import { TemplateRef, ViewContainerRef } from '@angular/core';

@Directive({ selector: '[myUnless]' })
export class UnlessDirective
{
    constructor(
        private templateRef:TemplateRef<any>,
        private viewContainer: ViewContainerRef
    ){}

    @Input() set myUnless(condition: boolean)
    {
        if (!condition)
        {
            this.viewContainer.createEmbeddedView(this.templateRef);
        }
        else
        {
            this.viewContainer.clear();
        }
    }
}

/** 
 * 
 * 
 * 
<p *myUnless="condition">
  condition is false and myUnless is true.
</p>
<p *myUnless="!condition">
  condition is true and myUnless is false.
</p>

<!-- Examples (A) and (B) are the same -->
<!-- (A) *ngIf paragraph -->
<p *ngIf="condition">
  Our heroes are true!
</p>
<!-- (B) [ngIf] with template -->
<template [ngIf]="condition">
  <p>
    Our heroes are true!
  </p>
</template>
<hr>
<!-- Examples (A) and (B) are the same -->
<!-- (A) *ngFor div -->
<div *ngFor="let hero of heroes">{{ hero }}</div>
<!-- (B) ngFor with template -->
<template ngFor let-hero [ngForOf]="heroes">
  <div>{{ hero }}</div>
</template>
 * 
*/