defmodule Yatzy.RollTest do
  use ExUnit.Case, async: true
  alias Yatzy.Roll
  doctest Roll

  test "rolling for the first time sets the counter to 1" do
    %{counter: counter} =
      %Roll{}
      |> Roll.execute()

    assert counter == 1
  end

  test "rolling for the first time returns some dice" do
    %{dice: dice} =
      %Roll{}
      |> Roll.execute(random: &roll_ones/1)

    assert dice == [1, 1, 1, 1, 1]
  end

  test "doing a full reroll increases the counter" do
    %{counter: counter} =
      %Roll{counter: 1}
      |> Roll.execute()

    assert counter == 2
  end

  test "doing a full reroll changes the dice" do
    %{dice: dice} =
      %Roll{dice: [2, 2, 2, 2, 2]}
      |> Roll.execute(random: &roll_ones/1)

    assert dice == [1, 1, 1, 1, 1]
  end

  test "doing a partial reroll increases the counter" do
    %{counter: counter} =
      %Roll{counter: 1}
      |> Roll.execute(reroll: [1, 2])

    assert counter == 2
  end

  test "doing a partial reroll changes the dice" do
    %{dice: dice} =
      %Roll{dice: [2, 2, 2, 2, 2]}
      |> Roll.execute(random: &roll_ones/1, reroll: [1, 2])

    assert dice == [1, 1, 2, 2, 2]
  end

  test "rolling more than 3 times does not change the counter" do
    %{counter: counter} =
      %Roll{counter: 3}
      |> Roll.execute()

    assert counter == 3
  end

  test "rolling more than 3 times does not change the dice" do
    %{dice: dice} =
      %Roll{dice: [1, 2, 3, 4, 5], counter: 5}
      |> Roll.execute()

    assert dice == [1, 2, 3, 4, 5]
  end

  test "dice results are ordered" do
    %{dice: dice} =
      %Roll{dice: [2, 2, 2, 2, 2]}
      |> Roll.execute(random: &roll_ones/1, reroll: [4, 5])

    assert dice == [1, 1, 2, 2, 2]
  end

  test "invalid rerolls do not change counter" do
    %{counter: counter} =
      %Roll{counter: 1}
      |> Roll.execute(reroll: [-1, 0, 2, 6])

    assert counter == 1
  end

  test "invalid rerolls do not change dice" do
    %{dice: dice} =
      %Roll{dice: [1, 1, 1, 1, 1]}
      |> Roll.execute(reroll: [-1, 0, 2, 6])

    assert dice == [1, 1, 1, 1, 1]
  end

  defp roll_ones(_), do: 1
end
