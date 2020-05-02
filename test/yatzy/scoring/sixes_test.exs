defmodule Yatzy.Scoring.SixesTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Score
  alias Yatzy.Scoring.Sixes

  test "scoring a roll with a single six" do
    rule = %Sixes{roll: [1, 2, 3, 4, 6]}
    score = Score.execute(rule)

    assert score == 6
  end

  test "scoring a roll with no sixes" do
    rule = %Sixes{roll: [1, 2, 3, 4, 5]}
    score = Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple sixes" do
    rule = %Sixes{roll: [1, 2, 6, 6, 6]}
    score = Score.execute(rule)

    assert score == 18
  end
end
