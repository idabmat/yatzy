defmodule YatzyTest do
  use ExUnit.Case
  doctest Yatzy

  test "starting a game without players" do
    assert Yatzy.new_game([]) == {:error, "Specify some players"}
  end

  test "starting a game with empty player name" do
    assert Yatzy.new_game(["  ", "Bob"]) == {:error, "Player names can't be blank"}
  end

  test "starting a game with duplicate players" do
    assert Yatzy.new_game(["Alice", "Alice"]) == {:error, "Players must have distinct names"}
  end

  test "playing a solo game" do
    {:ok, game_state} = Yatzy.new_game(["Alice"])

    game =
      game_state
      |> Yatzy.roll("Alice")
      |> Yatzy.roll("Alice", reroll: [4, 5])
      |> Yatzy.save("Alice", :ones)
      |> Yatzy.end_game()

    assert %{winners: ["Alice"], type: :win, status: :aborted} = game.result
  end

  test "playing a multiplayer game" do
    {:ok, game_state} = Yatzy.new_game(["Alice", "Bob", "Charlie"])
    %{current_player: player} = game_state

    game =
      game_state
      |> Yatzy.roll(player)
      |> Yatzy.save(player, :chance)
      |> Yatzy.end_game()

    assert %{winners: [player], type: :win, status: :aborted} = game.result
  end
end
