defmodule Yatzy.GameTest do
  use ExUnit.Case, async: true

  alias Yatzy.Game
  alias Yatzy.Player
  alias Yatzy.Result
  alias Yatzy.Roll

  doctest Game

  test "creating a game without players" do
    assert_raise ArgumentError, fn ->
      Game.new([])
    end
  end

  test "creating a game a single player game" do
    assert %Game{
             players: %{"Alice" => %Player{name: "Alice"}},
             current_player: "Alice",
             result: :pending
           } = Game.new(["Alice"])
  end

  test "creating a multi player game" do
    assert %Game{
             players: %{"Alice" => %Player{name: "Alice"}, "Bob" => %Player{name: "Bob"}},
             current_player: "Bob",
             result: :pending
           } = Game.new(["Alice", "Bob"], initial_player: "Bob")
  end

  test "creating a game with duplicate player names" do
    assert_raise ArgumentError, fn -> Game.new(["Alice", "Bob", "Alice"]) end
  end

  test "creating a game with blank player names" do
    assert_raise ArgumentError, fn -> Game.new([" ", "Alice"]) end
  end

  test "rolling as the current player" do
    game = Game.new(["Alice"]) |> Game.roll("Alice")

    assert %Roll{dice: dice, counter: 1} = game.players["Alice"].current_roll
    assert length(dice) > 0
  end

  test "rolling as a non existing player" do
    game = Game.new(["Alice"])
    assert Game.roll(game, "Bob") == game
  end

  test "rolling out of turn" do
    game = Game.new(["Alice", "Bob"], initial_player: "Alice")
    assert Game.roll(game, "Bob") == game
  end

  test "rolling a finished game" do
    game = Game.new(["Alice", "Bob"], initial_player: "Alice") |> Game.finish()
    assert Game.roll(game, "Alice") == game
  end

  test "rerolling dice" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.roll("Alice")
      |> Game.roll("Alice", random: &roll_ones/1, reroll: [1, 2, 3, 4, 5])

    assert %Roll{dice: [1, 1, 1, 1, 1], counter: 2} = game.players["Alice"].current_roll
  end

  test "saving an unthrown roll" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.save("Alice", :ones)

    assert game.current_player == "Alice"
  end

  test "saving with a roll" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.roll("Alice", random: &roll_ones/1)
      |> Game.save("Alice", :ones)

    assert %Game{
             current_player: "Bob",
             players: %{"Alice" => %Player{name: "Alice", current_roll: %Roll{counter: 0}}},
             result: :pending
           } = game
  end

  test "saving with a roll as the last player" do
    game =
      Game.new(["Alice", "Bob", "Charlie"], initial_player: "Charlie")
      |> Game.roll("Charlie", random: &roll_ones/1)
      |> Game.save("Charlie", :ones)

    assert %Game{
             current_player: "Alice",
             players: %{"Charlie" => %Player{name: "Charlie", current_roll: %Roll{counter: 0}}},
             result: :pending
           } = game
  end

  test "saving out of turn" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.roll("Alice", random: &roll_ones/1)
      |> Game.save("Bob", :ones)

    assert %Game{
             current_player: "Alice",
             players: %{"Alice" => %Player{name: "Alice", current_roll: %Roll{counter: 1}}},
             result: :pending
           } = game
  end

  test "saving a finished game" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.roll("Alice", random: &roll_ones/1)
      |> Game.finish()
      |> Game.save("Alice", :ones)

    assert %Game{
             current_player: "Alice",
             players: %{
               "Alice" => %Player{
                 name: "Alice",
                 current_roll: %Roll{counter: 1, dice: [1, 1, 1, 1, 1]}
               }
             },
             result: %Result{winners: ["Alice", "Bob"], type: :draw, status: :aborted}
           } = game
  end

  test "finishing a game" do
    game = Game.new(["Alice"]) |> Game.finish()
    assert %Result{winners: ["Alice"], type: :win, status: :aborted} == game.result
  end

  defp roll_ones(_), do: 1
end
