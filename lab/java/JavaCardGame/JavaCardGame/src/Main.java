//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {

    public static void main(String[] args) {
        Game new_game = new Game();
        Player player1 = new Player("danny");
        Player player2 = new Player("morgan");

        new_game.startGame(player1, player2);
    }
}

/*
War Game, one player and one computer
Game
Cards


 */
