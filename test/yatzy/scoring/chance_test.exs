defmodule Yatzy.Scoring.ChanceTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Chance
  alias Yatzy.Scoring.Score

  test "with anything" do
    roll = %Roll{dice: [1, 2, 3, 5, 6]}
    scoring = %Chance{roll: roll}

    assert Score.execute(scoring) == 17
  end

  test "with a pair" do
    roll = %Roll{dice: [1, 2, 2, 5, 6]}
    scoring = %Chance{roll: roll}

    assert Score.execute(scoring) == 16
  end

  test "with three of a kind" do
    roll = %Roll{dice: [1, 2, 2, 2, 6]}
    scoring = %Chance{roll: roll}

    assert Score.execute(scoring) == 13
  end

  test "with four of a kind" do
    roll = %Roll{dice: [1, 2, 2, 2, 2]}
    scoring = %Chance{roll: roll}

    assert Score.execute(scoring) == 9
  end

  test "with five of a kind" do
    roll = %Roll{dice: [2, 2, 2, 2, 2]}
    scoring = %Chance{roll: roll}

    assert Score.execute(scoring) == 10
  end
end
