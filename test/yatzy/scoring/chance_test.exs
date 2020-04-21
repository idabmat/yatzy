defmodule Yatzy.Scoring.ChanceTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Chance

  test "with anything" do
    roll = [1, 2, 3, 5, 6]
    scoring = %Chance{roll: roll}

    assert Yatzy.Score.execute(scoring) == 17
  end

  test "with a pair" do
    roll = [1, 2, 2, 5, 6]
    scoring = %Chance{roll: roll}

    assert Yatzy.Score.execute(scoring) == 16
  end

  test "with three of a kind" do
    roll = [1, 2, 2, 2, 6]
    scoring = %Chance{roll: roll}

    assert Yatzy.Score.execute(scoring) == 13
  end

  test "with four of a kind" do
    roll = [1, 2, 2, 2, 2]
    scoring = %Chance{roll: roll}

    assert Yatzy.Score.execute(scoring) == 9
  end

  test "with five of a kind" do
    roll = [2, 2, 2, 2, 2]
    scoring = %Chance{roll: roll}

    assert Yatzy.Score.execute(scoring) == 10
  end
end
