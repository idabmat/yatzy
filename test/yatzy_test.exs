defmodule YatzyTest do
  use ExUnit.Case
  doctest Yatzy

  test "Playing a solo game" do
    game_state =
      Yatzy.new_game(["Alice"])
      |> Yatzy.roll("Alice")
      |> Yatzy.roll("Alice", fix: [4, 5])
      |> Yatzy.score("Alice", 1)
      |> Yatzy.end_game()

    assert game_state[:result] == "Alice won."
  end
end
