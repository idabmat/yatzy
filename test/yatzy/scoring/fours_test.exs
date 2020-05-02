defmodule Yatzy.Scoring.FoursTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Fours
  alias Yatzy.Scoring.Score

  test "scoring a roll with a single four" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    rule = %Fours{roll: roll}
    score = Score.execute(rule)

    assert score == 4
  end

  test "scoring a roll with no fours" do
    roll = %Roll{dice: [1, 2, 3, 3, 5]}
    rule = %Fours{roll: roll}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple fours" do
    roll = %Roll{dice: [3, 4, 4, 4, 5]}
    rule = %Fours{roll: roll}
    score = Score.execute(rule)

    assert score == 12
  end
end
