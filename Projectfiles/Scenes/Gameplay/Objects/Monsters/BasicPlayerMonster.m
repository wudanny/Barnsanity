//
//  BasicPlayerMonster.m
//  AngryVeggie
//
//  Created by Danny on 6/21/13.
//
//

#import "BasicPlayerMonster.h"
#import "GameMechanics.h"
#import "math.h"

@implementation BasicPlayerMonster

- (void)spawnAt:(float) angleOfLocation
{
    //resume update and run animation
    [self stopAllActions];
    [self runAction:run];
    
    //set health
    self.hitPoints=self.hitPointsInit;
    
    //set location and move direction
    if([[GameMechanics sharedGameMechanics]game].difficulty==EASY){
        moveDirection=left;
        self.flipX=180;
    }else{
    if((angleOfLocation <=0 && angleOfLocation >= -90)||(angleOfLocation >270 && angleOfLocation < 359))
    {
        moveDirection=left;
        self.flipX=180;
    }else{
        moveDirection=right;
    }
    }
    //angle of the spawn
    angle= M_PI_2+CC_DEGREES_TO_RADIANS(angleOfLocation);
    
    // Select a spawn location
    float xPos=radiusToSpawn*cos(angle);
    float yPos=radiusToSpawn*sin(angle);
    
    //set the location
    self.position = CGPointMake(xPos, yPos);
    self.rotation=CC_RADIANS_TO_DEGREES(-angle+M_PI_2);
    
    
    // Finally set yourself to be visible, this also flag the enemy as "in use"
    self.visible = YES;
    self.move=TRUE;
    self.alive=TRUE;
    self.attacked=FALSE;
    self.attacking=FALSE;
    hitDidRun=FALSE;
    blinkDidRun=FALSE;
	
}

- (void)attack{
    // animation needs to be either done (isDone) or run for the first time (stabDidRun)
    if ((hitDidRun == FALSE) || [attack isDone])
    {
        [self runAction:attack];
        hitDidRun = TRUE;
    }
}

- (void)gotHit:(int)damage
{
    //deduct hitpoint by damage
    self.hitPoints -=damage;
    //if hitpoint is 0 or less then the monster dies
    if(self.hitPoints<=0){
        [[GameMechanics sharedGameMechanics]game].playerMonsterKilled=+1;
        [self destroy];
    }else if(blinkDidRun==FALSE || [blink isDone]){
        blinkDidRun=TRUE;
        [self runAction:blink];
    }
    
}


-(void)reset{
    [self destroy];
    
    int level=[[[[[GameMechanics sharedGameMechanics]game]levelsOfEverything] objectForKey:nameOfMonster] integerValue];
    if(level >= 0){
        NSDictionary *monsterInfo=[[[[[GameMechanics sharedGameMechanics]game]gameInfo] objectForKey:nameOfMonster]   objectAtIndex:level];
        self.hitPointsInit=[[monsterInfo objectForKey:@"Health"] integerValue];
        self.damage=[[monsterInfo objectForKey:@"Damage"]integerValue];
        speedAngle= [[monsterInfo objectForKey:@"Move Speed"] doubleValue]  * (M_PI/1860);
        self.areaOfEffect=[[monsterInfo objectForKey:@"AreaOfEffect"] boolValue];
        self.areaOfEffectDamage=[[monsterInfo objectForKey:@"AreaOfEffect Damage"]integerValue];
    }
}


@end

