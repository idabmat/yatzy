defmodule Yatzy.Scoring.ThreesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Score
  alias Yatzy.Scoring.Threes

  test "scoring a roll with a single three" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    rule = %Threes{roll: roll}
    score = Score.execute(rule)

    assert score == 3
  end

  test "scoring a roll with no threes" do
    roll = %Roll{dice: [1, 2, 2, 4, 5]}
    rule = %Threes{roll: roll}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple threes" do
    roll = %Roll{dice: [3, 3, 3, 4, 5]}
    rule = %Threes{roll: roll}
    score = Score.execute(rule)

    assert score == 9
  end
end
