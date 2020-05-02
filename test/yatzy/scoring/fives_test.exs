defmodule Yatzy.Scoring.FivesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Fives
  alias Yatzy.Scoring.Score

  test "scoring a roll with a single five" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    rule = %Fives{roll: roll}
    score = Score.execute(rule)

    assert score == 5
  end

  test "scoring a roll with no fives" do
    roll = %Roll{dice: [1, 2, 3, 4, 6]}
    rule = %Fives{roll: roll}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple fives" do
    roll = %Roll{dice: [1, 2, 5, 5, 5]}
    rule = %Fives{roll: roll}
    score = Score.execute(rule)

    assert score == 15
  end
end
