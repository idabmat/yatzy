defmodule Yatzy.PlayerTest do
  use ExUnit.Case, async: true
  doctest Yatzy.Player

  alias Yatzy.Player
  alias Yatzy.Roll
  alias Yatzy.Sheet

  test "creating a player" do
    assert Player.new("Alice") == %Player{name: "Alice", sheet: %Sheet{}, current_roll: %Roll{}}
  end

  test "rolling the dice" do
    %Player{current_roll: roll} = Player.new("Alice") |> Player.roll()
    assert roll.counter == 1
    assert length(roll.dice) != 0
  end

  test "rerolling all dice" do
    player =
      %Player{name: "Alice", current_roll: %Roll{dice: [2, 2, 2, 2, 2], counter: 1}}
      |> Player.roll(random: &roll_ones/1)

    assert player.current_roll.counter == 2
    assert player.current_roll.dice == [1, 1, 1, 1, 1]
  end

  test "rerolling some dice" do
    player =
      %Player{name: "Alice", current_roll: %Roll{dice: [2, 2, 2, 2, 2], counter: 1}}
      |> Player.roll(random: &roll_ones/1, reroll: [1, 2])

    assert player.current_roll.counter == 2
    assert player.current_roll.dice == [1, 1, 2, 2, 2]
  end

  test "saving a roll" do
    player =
      Player.new("Alice")
      |> Player.roll(random: &roll_ones/1)
      |> Player.save(:ones)

    assert player.sheet.ones.roll == %Roll{dice: [1, 1, 1, 1, 1], counter: 1}
    assert player.current_roll == %Roll{dice: [], counter: 0}
  end

  test "scoring a player without saved rolls" do
    player = Player.new("Alice")

    assert Player.score(player) == 0
  end

  test "scoring a player with saved rolls" do
    score =
      Player.new("Alice")
      |> Player.roll(random: &roll_ones/1)
      |> Player.save(:ones)
      |> Player.score()

    assert score == 5
  end

  defp roll_ones(_), do: 1
end
