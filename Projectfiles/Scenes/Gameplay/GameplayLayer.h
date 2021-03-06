//
//  GameplayScene.h
//  _MGWU-SideScroller-Template_
//
//  Created by Benjamin Encz on 5/15/13.
//  Copyright (c) 2013 MakeGamesWithUs Inc. Free to use for all purposes.
//

#import "CCScene.h"
#import "PauseScreen.h"
#import "ScoreboardEntryNode.h"
#import "Ship.h"
#import "TimerDisplayNode.h"
#import "EnergyDisplayNode.h"
#import "World.h"
#import "AlertSign.h"

@class TimerDisplayNode;
@interface GameplayLayer : CCLayer <PauseScreenDelegate>
{
    //for rotation of the sprites
    CGFloat rotationVelocity;
    
    CGFloat deltaRotation;
    
    bool touchingworld;
    CGPoint previousTouch, currentTouch;
    CGSize screenSize;
    bool shipFire;
    BOOL shipFireToggle;
    ScoreboardEntryNode *pointsDisplayNode;
    // groups health, coins and points display
    CCNode *hudNode;
        
    /* Pause Button */
    CCMenu *pauseButtonMenu;
    CCMenuItemSprite *pauseButtonMenuItem;
    
    Game *game;
    
    /* used to trigger events, that need to run every X update cycles*/
    int updateCount;
    NSTimeInterval previousTime;
    NSTimeInterval currentTime;
    NSTimeInterval deltaTime;
    float degreePerTime;
    
    NSMutableArray *touchDeltas;
    int count;
    int sizeOfArray;
    
    AlertSign *barnUnderAttack;
    UITouch *touchWorld;
    World *planet;

}

// defines if the main menu shall be displayed, or if the game shall start directly. By default the menu is displayed.
@property (nonatomic, assign) BOOL ableToRotate;
@property (nonatomic, assign) BOOL ableToShoot;
@property (nonatomic, assign) BOOL showMainMenu;
@property (nonatomic, assign) BOOL touchHappened;
@property (nonatomic, assign) float radiusOfWorld;
@property (nonatomic) Ship *ship;
@property (nonatomic) MonsterButtonCache *monsterButton;
@property (nonatomic) CCNode *centerOfRotation;
@property (nonatomic) TimerDisplayNode *timer;
@property (nonatomic) EnergyDisplayNode *energy;
/**
 Tells the game to start
 */
- (void)startGame;

//going to different screens
-(void)pauseButtonPressed;
-(void)goTolevelSelection;
-(void)goToMainMenu;
-(void)goToStore;
-(void)goToEquip;
-(void)gotToConfirm;
-(void)shopTutorial;
-(void)goToOption;

// returns a GamePlayLayer, with an overlayed MainMenu
+ (id)scene;

// return a GamePlayLayer without a MainMenu
+ (id)noMenuScene;

// makes the Heads-Up-Display (healthInfo, pointInfo, etc.) appear. Can be animated.
- (void)showHUD;

// hides the Heads-Up-Display (healthInfo, pointInfo, etc.). Can be animated.
- (void)hideHUD;

- (void)disableGameplayButtons;
- (void)enableGamePlayButtons;

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
