defmodule Yatzy.Scoring.TwosTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.Twos

  test "scoring a roll with a single two" do
    rule = %Twos{roll: [1, 2, 3, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 2
  end

  test "scoring a roll with no twos" do
    rule = %Twos{roll: [1, 1, 3, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 0
  end

  test "scoring a roll with multiple twos" do
    rule = %Twos{roll: [2, 2, 2, 4, 5]}
    score = Yatzy.Score.execute(rule)

    assert score == 6
  end
end
