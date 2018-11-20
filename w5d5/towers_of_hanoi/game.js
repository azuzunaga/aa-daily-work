const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {
  constructor() {
    this.tower = [[3, 2, 1], [], []];
  }

  promptMove() {
    let startMove, endMove;

    reader.question("Please choose a starting and ending tower",
                    function(answerSet) {
                      [startMove, endMove] = answerSet.split(", ").map(e => parseInt(e));
                      console.log(startMove, typeof(startMove), endMove, typeof(endMove));
                    });
  }
}

const game = new Game();
game.promptMove();
