defmodule Yatzy.Scoring.OnesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Ones
  alias Yatzy.Scoring.Score

  test "scoring a roll with a single one" do
    rule = %Ones{roll: [1, 2, 3, 4, 5]}
    score = Score.execute(rule)

    assert score == 1
  end

  test "scoring a roll with no ones" do
    rule = %Ones{roll: [2, 2, 3, 4, 5]}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple ones" do
    rule = %Ones{roll: [1, 1, 1, 4, 5]}
    score = Score.execute(rule)

    assert score == 3
  end
end
