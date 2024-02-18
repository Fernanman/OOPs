### How the script editor works
Since the game is oriented around programming to accomplish puzzles, I think it's fitting to have the instructions to be in the short form of documentation.
The script editor works on a stack that the last instructrion that was entered will be the first that will be attempted to be executed.
The syntax was inspired by python. The player can move by calling the methods: walk, run, jump, and idle. Each method takes an integer parameter dictating the direction (1 for right and -1 for left).
If statemnts can be used to tell the player what to do when traading certain ground. Possible terrain colors are: black, red, blue, and green.

### Examples
1) player.walk(1) -> Will move the player to the right unconditionally.
2) if player on black: player.walk(1) -> Moves the player to the right when on black terrain
3) if player on black: player.walk(1)
   if player on green: player.jump(1) -> Will cause the player to walk on black terrain and jump when encountering green terrain.
