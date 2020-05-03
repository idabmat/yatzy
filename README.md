![Elixir CI](https://github.com/idabmat/yatzy/workflows/Elixir%20CI/badge.svg)
# Yatzy

An implementation of the Yatzy game.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `yatzy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:yatzy, "~> 1.0.0"}
  ]
end
```

## Usage

Start a game with `Yatzy.new_game(["Alice", "Bob"])`. This return the game state. All subsequent
interactions are done by providing the game state:
- `Yatzy.roll(game_State, "Alice")` to roll all dice for a player.
- `Yatzy.roll(game_state, "Alice", reroll: [1, 2, 3])` to reroll only the 1st, 2nd and 3rd dice.
- `Yatzy.save(game_state, "Alice", :ones)` to save the current roll under a given line in the
    player's score sheet. This also terminates that player's turn.
- `Yatzy.end_game(game_state)` to finish the game. The game state returned will include the final
    result including the name of the winners and whether it was a clear win or a draw.

## Documentation

Documentation can be found at [https://hexdocs.pm/yatzy](https://hexdocs.pm/yatzy).
