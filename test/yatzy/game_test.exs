defmodule Yatzy.GameTest do
  use ExUnit.Case, async: true

  alias Yatzy.Game
  alias Yatzy.Player
  alias Yatzy.Roll

  doctest Game

  test "creating a game without players" do
    assert_raise ArgumentError, fn ->
      Game.new([])
    end
  end

  test "creating a game a single player game" do
    game = Game.new(["Alice"])
    assert %{"Alice" => %Player{name: "Alice"}} = game.players
    assert game.current_player == "Alice"
  end

  test "creating a multi player game" do
    game = Game.new(["Alice", "Bob"], initial_player: "Bob")
    assert %{"Alice" => %Player{name: "Alice"}, "Bob" => %Player{name: "Bob"}} = game.players
    assert game.current_player == "Bob"
  end

  test "creating a game with duplicate player names" do
    assert_raise ArgumentError, fn ->
      Game.new(["Alice", "Bob", "Alice"])
    end
  end

  test "creating a game with blank player names" do
    assert_raise ArgumentError, fn ->
      Game.new([" ", "Alice"])
    end
  end

  test "rolling as the current player" do
    %Game{players: %{"Alice" => alice}} =
      Game.new(["Alice"])
      |> Game.roll("Alice")

    %Roll{dice: dice, counter: counter} = alice.current_roll
    assert dice != []
    assert counter == 1
  end

  test "rolling as a non existing player" do
    game = Game.new(["Alice"])
    assert Game.roll(game, "Bob") == game
  end

  test "rolling out of turn" do
    game = Game.new(["Alice", "Bob"], initial_player: "Alice")
    assert Game.roll(game, "Bob") == game
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

    assert %Game{current_player: "Alice"} = game
  end

  test "saving with a roll" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.roll("Alice", random: &roll_ones/1)
      |> Game.save("Alice", :ones)

    assert %Game{
             current_player: "Bob",
             players: %{"Alice" => %Player{current_roll: %Roll{counter: 0}}}
           } = game
  end

  test "saving with a roll as the last player" do
    game =
      Game.new(["Alice", "Bob", "Charlie"], initial_player: "Charlie")
      |> Game.roll("Charlie", random: &roll_ones/1)
      |> Game.save("Charlie", :ones)

    assert %Game{
             current_player: "Alice",
             players: %{"Charlie" => %Player{current_roll: %Roll{counter: 0}}}
           } = game
  end

  test "saving out of turn" do
    game =
      Game.new(["Alice", "Bob"], initial_player: "Alice")
      |> Game.roll("Alice", random: &roll_ones/1)
      |> Game.save("Bob", :ones)

    assert %Game{
             current_player: "Alice",
             players: %{"Alice" => %Player{current_roll: %Roll{counter: 1}}}
           } = game
  end

  defp roll_ones(_), do: 1
end
