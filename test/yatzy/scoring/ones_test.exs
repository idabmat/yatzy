defmodule Yatzy.Scoring.OnesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Ones
  alias Yatzy.Scoring.Score

  test "scoring a roll with a single one" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    rule = %Ones{roll: roll}
    score = Score.execute(rule)

    assert score == 1
  end

  test "scoring a roll with no ones" do
    roll = %Roll{dice: [2, 2, 3, 4, 5]}
    rule = %Ones{roll: roll}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple ones" do
    roll = %Roll{dice: [1, 1, 1, 4, 5]}
    rule = %Ones{roll: roll}
    score = Score.execute(rule)

    assert score == 3
  end
end
