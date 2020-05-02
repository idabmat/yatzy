defmodule Yatzy.Scoring.ThreeOfAKindTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Score
  alias Yatzy.Scoring.ThreeOfAKind

  test "with a pair" do
    roll = [1, 1, 2, 3, 4]
    scoring = %ThreeOfAKind{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with 3 2s" do
    roll = [1, 2, 2, 2, 3]
    scoring = %ThreeOfAKind{roll: roll}

    assert Score.execute(scoring) == 6
  end

  test "with 4 2s" do
    roll = [1, 2, 2, 2, 2]
    scoring = %ThreeOfAKind{roll: roll}

    assert Score.execute(scoring) == 6
  end

  test "with 5 2s" do
    roll = [2, 2, 2, 2, 2]
    scoring = %ThreeOfAKind{roll: roll}

    assert Score.execute(scoring) == 6
  end

  test "with a full house" do
    roll = [1, 1, 2, 2, 2]
    scoring = %ThreeOfAKind{roll: roll}

    assert Score.execute(scoring) == 6
  end
end
