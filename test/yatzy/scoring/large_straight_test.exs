defmodule Yatzy.Scoring.LargeStraightTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.LargeStraight
  alias Yatzy.Scoring.Score

  test "with the small straight" do
    roll = %Roll{dice: [1, 2, 3, 4, 5]}
    scoring = %LargeStraight{roll: roll}

    assert Score.execute(scoring) == 0
  end

  test "with the large straight" do
    roll = %Roll{dice: [2, 3, 4, 5, 6]}
    scoring = %LargeStraight{roll: roll}

    assert Score.execute(scoring) == 20
  end

  test "with anything else" do
    roll = %Roll{dice: [1, 2, 3, 4, 6]}
    scoring = %LargeStraight{roll: roll}

    assert Score.execute(scoring) == 0
  end
end
