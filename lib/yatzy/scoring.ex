defmodule Yatzy.Scoring do
  @moduledoc """
  Utility functions for calculating scores of a given roll.
  """

  alias Yatzy.Roll
  use TypedStruct

  typedstruct do
    field :roll, Roll.t(), default: %Roll{}
    field :name, String.t(), enforce: true
    field :description, String.t(), enforce: true
    field :score, String.t()
  end

  @doc """
  Counting how many dice show a given number and summing the matching dice

  ## Examples

      iex> Yatzy.Scoring.count([1, 2, 3, 3, 3], 3)
      9

  """
  @spec count(roll :: [integer()], value :: integer()) :: integer()
  def count(roll, value) do
    roll
    |> Enum.filter(fn die -> die == value end)
    |> Enum.sum()
  end

  @doc """
  Checking what is the highest pair, trips, square, etc and the running total

  ## Examples

      iex> Yatzy.Scoring.chunk_by([1, 1, 3, 3, 4], 2)
      6

  """
  @spec chunk_by(roll :: [integer()], length :: integer()) :: integer()
  def chunk_by(roll, length) do
    roll
    |> Enum.sort()
    |> Stream.chunk_every(length, 1, :discard)
    |> Stream.filter(&are_equal/1)
    |> Stream.map(&Enum.sum/1)
    |> Enum.max(fn -> 0 end)
  end

  @spec are_equal([integer()]) :: boolean()
  defp are_equal(list), do: are_equal(list, true)

  defp are_equal([], result), do: result
  defp are_equal([head | tail], result), do: are_equal(tail, result, head)

  defp are_equal([], result, _), do: result

  defp are_equal([head | tail], result, value),
    do: are_equal(tail, result && head == value, value)

  defprotocol Score do
    @fallback_to_any true
    @doc """
    Calculate the score for a given scoring.
    """
    @spec execute(rule :: Yatzy.Scoring.t()) :: integer()
    def execute(_rule)
  end

  defimpl Score, for: Any do
    def execute(_rule), do: 0
  end
end
