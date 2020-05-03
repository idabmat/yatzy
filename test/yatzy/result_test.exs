defmodule Yatzy.ResultTest do
  use ExUnit.Case, async: true

  alias Yatzy.Player
  alias Yatzy.Result
  alias Yatzy.Roll
  alias Yatzy.Sheet

  doctest Result

  test "result for an empty solo game" do
    players = [%Player{name: "Alice"}]

    assert %Result{
             winners: ["Alice"],
             type: :win,
             status: :aborted
           } = Result.new(players)
  end

  test "result for an empty multiplayer game" do
    players = [
      %Player{name: "Alice"},
      %Player{name: "Bob"}
    ]

    assert %Result{
             winners: ["Alice", "Bob"],
             type: :draw,
             status: :aborted
           } = Result.new(players)
  end

  test "with a complete solo game" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    sheet = filled_sheet_with(roll)
    players = [%Player{name: "Alice", sheet: sheet}]

    assert %Result{
             winners: ["Alice"],
             type: :win,
             status: :finished
           } = Result.new(players)
  end

  test "with a complete draw with two players" do
    roll = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    sheet = filled_sheet_with(roll)

    players = [
      %Player{name: "Alice", sheet: sheet},
      %Player{name: "Bob", sheet: sheet}
    ]

    assert %Result{
             winners: ["Alice", "Bob"],
             type: :draw,
             status: :finished
           } = Result.new(players)
  end

  test "with a complete win with three players" do
    roll1 = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    roll2 = %Roll{dice: [2, 3, 4, 5, 6], counter: 1}

    players = [
      %Player{name: "Alice", sheet: filled_sheet_with(roll1)},
      %Player{name: "Bob", sheet: filled_sheet_with(roll2)},
      %Player{name: "Charlie", sheet: filled_sheet_with(roll1)}
    ]

    assert %Result{
             winners: ["Bob"],
             type: :win,
             status: :finished
           } = Result.new(players)
  end

  test "with a complete draw with two out of three players" do
    roll1 = %Roll{dice: [1, 2, 3, 4, 5], counter: 1}
    roll2 = %Roll{dice: [2, 3, 4, 5, 6], counter: 1}

    players = [
      %Player{name: "Alice", sheet: filled_sheet_with(roll1)},
      %Player{name: "Bob", sheet: filled_sheet_with(roll2)},
      %Player{name: "Charlie", sheet: filled_sheet_with(roll2)}
    ]

    assert %Result{
             winners: ["Bob", "Charlie"],
             type: :draw,
             status: :finished
           } = Result.new(players)
  end

  defp filled_sheet_with(roll) do
    sheet =
      %Sheet{}
      |> Map.from_struct()
      |> Enum.map(fn {rule, scoring} -> {rule, %{scoring | roll: roll}} end)
      |> Enum.into(%{})

    struct(Sheet, sheet)
  end
end
