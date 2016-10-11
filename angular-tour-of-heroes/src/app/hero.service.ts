import { Injectable } from '@angular/core';

import { Hero } from './hero';
import { HEROES } from './mock-heroes';


@Injectable()
export class HeroService
{
	// It is a promise to call us back later when the results are ready. 
	// We ask an asynchronous service to do some work and give it a callback function.
	getHeroes():Promise<Hero[]>
	{
		return Promise.resolve(HEROES);
	}

	getHeroesSlowly():Promise<Hero[]>
	{
		return new Promise<Hero[]>(resolve => setTimeout(resolve, 2000)) // delay 2 seconds
		.then(() => this.getHeroes());
	}
}