import { Component,OnInit } from '@angular/core';
import { Hero } from './hero';
import { HeroService } from './hero.service';

@Component({
  //selector: 'app-root',
  selector: 'my-heroes',
  templateUrl: './heroes.component.html',
  styleUrls: ['./heroes.component.css']
})
export class HeroesComponent implements OnInit {
  title = 'Tour of Heroes'
  heroes:Hero[];

  selectedHero:Hero;

  // Dependency Injection
  constructor(private heroService:HeroService) 
  {
      this.getHeroes();
  }

  ngOnInit():void
  {
      this.getHeroes();
  }

  getHeroes():void
  {
      //this.heroService.getHeroes().then(heroes => this.heroes = heroes);
      this.heroService.getHeroesSlowly().then(heroes => this.heroes = heroes);
  }

  onSelect(hero:Hero):void
  {
      this.selectedHero = hero;
  }
}

