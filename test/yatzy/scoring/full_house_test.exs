defmodule Yatzy.Scoring.FullHouseTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.FullHouse
  alias Yatzy.Scoring.Score

  test "with nothing" do
    roll = %Roll{dice: [1, 2, 3, 4, 6]}
    scoring = %FullHouse{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with a single pair" do
    roll = %Roll{dice: [1, 1, 2, 3, 4]}
    scoring = %FullHouse{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with a single three of a kind" do
    roll = %Roll{dice: [1, 1, 1, 3, 4]}
    scoring = %FullHouse{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with a full house of 1 by 2" do
    roll = %Roll{dice: [1, 1, 1, 2, 2]}
    scoring = %FullHouse{roll: roll}

    assert Score.execute(scoring) == 7
  end

  test "with a full house of 5 by 3" do
    roll = %Roll{dice: [3, 3, 5, 5, 5]}
    scoring = %FullHouse{roll: roll}

    assert Score.execute(scoring) == 21
  end

  test "with a five of a kind" do
    roll = %Roll{dice: [5, 5, 5, 5, 5]}
    scoring = %FullHouse{roll: roll}

    assert Score.execute(scoring) == 0
  end
end
