defmodule Yatzy.Scoring.YatzyTest do
  use ExUnit.Case, async: true

  alias Yatzy.Roll
  alias Yatzy.Scoring.Score

  test "with 5 6s" do
    roll = %Roll{dice: [6, 6, 6, 6, 6]}
    scoring = %Yatzy.Scoring.Yatzy{roll: roll}

    assert Score.execute(scoring) == 50
  end

  test "with 5 3s" do
    roll = %Roll{dice: [3, 3, 3, 3, 3]}
    scoring = %Yatzy.Scoring.Yatzy{roll: roll}

    assert Score.execute(scoring) == 50
  end

  test "with 4 3s" do
    roll = %Roll{dice: [3, 3, 3, 3, 4]}
    scoring = %Yatzy.Scoring.Yatzy{roll: roll}

    assert Score.execute(scoring) == 0
  end
end
