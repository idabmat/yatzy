defmodule Yatzy.Scoring.TwosTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Score
  alias Yatzy.Scoring.Twos

  test "scoring a roll with a single two" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    rule = %Twos{roll: roll}
    score = Score.execute(rule)

    assert score == 2
  end

  test "scoring a roll with no twos" do
    roll = %Roll{dice: [1, 1, 3, 4, 5]}
    rule = %Twos{roll: roll}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple twos" do
    roll = %Roll{dice: [2, 2, 2, 4, 5]}
    rule = %Twos{roll: roll}
    score = Score.execute(rule)

    assert score == 6
  end
end
