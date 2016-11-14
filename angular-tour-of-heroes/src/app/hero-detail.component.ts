import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location } from '@angular/common';

import { HeroService } from './hero.service';
import { Hero } from './Hero';

@Component({
	selector: 'my-hero-detail',
	templateUrl: './hero-detail.component.html',
	styleUrls: ['hero-detail.component.css']
})

export class HeroDetailComponent implements OnInit
{
	//@Input()
	hero:Hero;

	constructor
	(
		private heroService: HeroService,
		private route: ActivatedRoute,
		private location:Location
	){}

	ngOnInit():void
	{
		this.route.params.forEach((params:Params) =>
		{
			// + can convert the route parameter value to a number.
			let id = +params['id'];
			
			this.heroService.getHero(id)
				.then(hero => this.hero = hero);
		});
	}

	goBack():void
	{
		this.location.back();
	}

	save(): void 
	{
		this.heroService.update(this.hero)
						.then(() => this.goBack());
	}
}