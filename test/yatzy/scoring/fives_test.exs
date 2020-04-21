defmodule Yatzy.Scoring.FivesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Fives

  test "scoring a roll with a single five" do
    rule = %Fives{roll: [1, 2, 3, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 5
  end

  test "scoring a roll with no fives" do
    rule = %Fives{roll: [1, 2, 3, 4, 6]}
    score = Yatzy.Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple fives" do
    rule = %Fives{roll: [1, 2, 5, 5, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 15
  end
end
