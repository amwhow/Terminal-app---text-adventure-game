# Text Adventure game Terminal App

## Installation and Setup
1. Install Ruby, see instructions [here](https://www.ruby-lang.org/en/documentation/installation/)  
   
2. Install [git](https://git-scm.com/downloads)  
   
3. Type the command below to clone the game app to your local directory  
```bash
git clone https://github.com/amwhow/Terminal-app---text-adventure-game.git
```  
4. Run the `setup` file to install necessary files  
   
5. Run the `startgame` file to start

## Software Development Plan  
1. **What the application will do**  
   This is a choice-based text adventure game for purely leisure purpose. You will experience a couple of stories about your journey into a jungle. Making right choices, winning battles and finishing mini-games will lead you to finish this game. There are also multiple types of enemies to fight with, and a boss to beat at the end. Hope you will enjoy it!  
  
2. **Problem this app will solve and why am I developing it**  
   This is a game for fun, it is worth to try if you like text adventure games. If you have learnt Ruby, you can also access to the source code and add some flavour to your own character or to the enemies. I missed the time when I first played those text-adventure games so I tried to remake one by my self.  
  
3. **Target audience**  
   Anyone who like to play games, beginner developers wants to explore more possibilities of Ruby, or anyone just want to kill some time.

4. **How to use**  
   Players can follow easy in-game instructions which will navigate them across the game. There are also some easy to read help commands that will assist players to understand the game better. 
    

## Features  
1. **Text layout feature:**  
- Center text function can measure the width and height of player's terminal window and center the text accordingly. It is used to many occasions such as system prompt in battle, welcome prompt, gameover prompt and the end of the game. 
- Press any key to continue function is also deployed to this game to create smooth game story read experience.   

2. **Story feature:**  
- By hitting any key, player can see the next line of the story and there will be choices to make, leading player to different paths of the game.

3. **Battle feature:**  
- Turn-based battle system: Player and enemy will take turn to attack each other, and if any party's HP falls down to zero or below, battle ends and the result will be prompt to the screen.  
- Attack value change and fluctuation: After the player wins every battle, the attack value will increase depend on which enemy the player defeats. The increase will keep throughout the game. Also the damage will be fluctuating in a small range around your attack value, this also apply to all enemies.  

4. **Save & load feature:**  
- The player can save game data at specific point of game, typically after each battle and important choice. This will create a .yml file in the save data folder with player's name and save time.  
- If there's existing saving files, players can load any one of them at the beginning of the game. After loading, the story will jump to the certain save point and the player stats will be updated accordingly as well.


## Project Management

I used Trello to manage the tasks for this project.

Here is a link to [my trello board](https://trello.com/b/HLiXNBXP/terminal-text-adventure-game).




