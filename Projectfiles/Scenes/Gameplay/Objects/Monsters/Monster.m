//
//  Monster.m
//  Veg_V_Fruit
//
//  Created by Danny on 6/28/13.
//  Copyright (c) 2013 MakeGamesWithUs Inc. All rights reserved.
//

#import "Monster.h"
#import "GameMechanics.h"


@implementation Monster
- (id)initWithMonsterPicture
{
    @throw @"- (id)initWithMonsterPicture has to be implemented in Subclass.";
}

- (void)spawnAt:(float) angleOfLocation
{
    @throw @"- (void)spawnAt has to be implemented in Subclass.";
}

- (void)attack{
    @throw @"- (void)attack has to be implemented in Subclass.";
}

- (void)gotHit:(int)damage
{
    @throw @"- (void)gotHit has to be implemented in Subclass.";
}

-(void)changePosition{
    //move the monster M_PI/480 in a direction
    float deltaSpeed;
    if([[GameMechanics sharedGameMechanics]game].difficulty==HARD){
        deltaSpeed=(M_PI/5850);
    }else{
        deltaSpeed=(M_PI/5000);
    }
    if(self.moveDirection==left){
        self.angle+=speed* deltaSpeed;
        self.angle=fmodf(self.angle+2*M_PI, 2*M_PI);
        self.hitZoneAngle1=self.angle+self.hitZone;
        self.hitZoneAngle1=fmodf(self.hitZoneAngle1+2*M_PI, 2*M_PI);
        self.hitZoneAngle2=self.angle;
        self.hitZoneAngle2=fmodf(self.hitZoneAngle2+2*M_PI, 2*M_PI);
    }else{
        self.angle-=speed* deltaSpeed;
        self.angle=fmodf(self.angle+2*M_PI, 2*M_PI);
        self.hitZoneAngle1=self.angle;
        self.hitZoneAngle1=fmodf(self.hitZoneAngle1+2*M_PI, 2*M_PI);
        self.hitZoneAngle2=self.angle-self.hitZone;
        self.hitZoneAngle2=fmodf(self.hitZoneAngle2+2*M_PI, 2*M_PI);
    }
    
    self.boundingZoneAngle1=self.angle+self.boundingZone;
    self.boundingZoneAngle1=fmodf(self.boundingZoneAngle1+2*M_PI, 2*M_PI);
    self.boundingZoneAngle2=self.angle-self.boundingZone;
    self.boundingZoneAngle2=fmodf(self.boundingZoneAngle2+2*M_PI, 2*M_PI);
    
    
    float deltaX=self.radiusToSpawn*cos(self.angle);
    float deltaY=self.radiusToSpawn*sin(self.angle);
    CGPoint newPosition = ccp(deltaX, deltaY);
    
    
    self.rotation=CC_RADIANS_TO_DEGREES(-self.angle+M_PI_2);
    
    [self setPosition:newPosition];
}

-(void) destroy{
    //turn invisible
    self.visible = FALSE;
    self.alive=FALSE;
    self.move=FALSE;
    self.position = ccp(-MAX_INT, 0);
    
    //stop all actions and pause update
    [self stopAllActions];
    
}


@end
