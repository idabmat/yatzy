defmodule Yatzy.Scoring.ThreesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Threes

  test "scoring a roll with a single three" do
    rule = %Threes{roll: [1, 2, 3, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 3
  end

  test "scoring a roll with no threes" do
    rule = %Threes{roll: [1, 2, 2, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple threes" do
    rule = %Threes{roll: [3, 3, 3, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 9
  end
end
