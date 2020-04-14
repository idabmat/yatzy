defmodule YatzyTest do
  use ExUnit.Case
  doctest Yatzy

  test "starts the game" do
    assert Yatzy.new_game() == %{}
  end
end
