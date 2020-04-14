defmodule Yatzy do
  @moduledoc """
  Documentation for `Yatzy`.
  """

  @doc """
  Starting a game

  ## Examples

      iex> Yatzy.new_game(["Alice", "Bob"])
      %{}

  """
  def new_game(_players), do: %{}

  @doc """
  Rolling the dices for a given player

  ## Examples

      iex> Yatzy.roll(%{}, "Alice")
      %{}

  """
  def roll(game_state, player), do: roll(game_state, player, [])
  def roll(_game_state, _player, _opts), do: %{}

  @doc """
  Scoring the current roll for a player

  ## Examples

      iex> Yatzy.score(%{}, "Alice", 1)
      %{}

  """
  def score(_game_state, _player, _rule), do: %{}

  @doc """
  Ending a game

  ## Examples

      iex> Yatzy.end_game(%{})
      %{ result: "Alice won." }

  """
  def end_game(_game_state), do: %{result: "Alice won."}
end
