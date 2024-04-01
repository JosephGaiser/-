# PACHINKO

A simple proof of concept for a pachinko themed game implemented in godot 4

### IMPLEMENTATION

* Uses drop in physics replacement [box2d](https://godotengine.org/asset-library/asset/2007)

### GAMEPLAY MECHANICS

* Play field
    * The play-field will be considered the enemy
    * The play-field will have a health value
    * The play-field will have a capture system
    * The play-field will have a jackpot system
    * The play-field will have a launch system
    * Pegs will be used to alter the balls trajectory as they fall
    * Walls will be used to block the balls from falling off the stage
    * Cups will be used to capture balls
* Launch System
    * The player will have a limited number of balls
    * Balls will be stored in a hopper
    * The player will have a launcher to launch balls
    * The launcher will have an adjustable angle
    * The launcher will have an adjustable force
* Player System
    * The players balls will serve as their health
    * When the player runs out of balls, the game is over
    * If an enemy is defeated, the player wins
* Enemy System
    * The play-field will be considered the enemy
    * The play-field will have a health value
    * An enemy will be defeated when the health reaches 0
* Capture system
    * When a ball hits a cup, the cup will capture the ball
    * Captured Balls are returned to the hopper
    * Capturing balls will decrease the health of the stage
    * Balls that fall off the stage are lost
    * Cups can be configured to be crit capture cups
        * Crit capture cups will spin the jackpot system
        * Crit capture cups will do lots of damage to the stage
        * Crit capture cups will return more balls to the player
* Jackpot System
    * Top of the board will show 3 digits
    * When a crit capture occurs, the digits will spin
    * If the digits all match, the player will receive a jackpot
    * Jackpots will give the player a lot of balls

### SCREENSHOTS

![image](https://github.com/JosephGaiser/pachinko/assets/35605126/25fe4976-17c1-44b5-8cb2-bf68d771ff3c)
