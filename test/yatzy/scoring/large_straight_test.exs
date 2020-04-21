defmodule Yatzy.Scoring.LargeStraightTest do
  use ExUnit.Case, async: true

  alias Yatzy.Scoring.LargeStraight

  test "with the small straight" do
    roll = [1, 2, 3, 4, 5]
    scoring = %LargeStraight{roll: roll}

    assert Yatzy.Score.execute(scoring) == 0
  end

  test "with the large straight" do
    roll = [2, 3, 4, 5, 6]
    scoring = %LargeStraight{roll: roll}

    assert Yatzy.Score.execute(scoring) == 20
  end

  test "with anything else" do
    roll = [1, 2, 3, 4, 6]
    scoring = %LargeStraight{roll: roll}

    assert Yatzy.Score.execute(scoring) == 0
  end
end
