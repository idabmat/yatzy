defmodule Yatzy do
  @moduledoc """
  Documentation for `Yatzy`.
  """

  @type roll_options :: [
          reroll: [integer()]
        ]

  alias Yatzy.Game

  @doc """
  Starting a game
  """
  @spec new_game([String.t()]) :: {:ok, Game.t()} | {:error, String.t()}
  def new_game(players) do
    {:ok, Game.new(players)}
  rescue
    e in ArgumentError -> {:error, e.message}
  end

  @doc """
  (Re)Rolling the dices for a given player
  """
  @spec roll(game_state :: Game.t(), player :: String.t(), roll_options :: roll_options()) ::
          Game.t()
  def roll(game_state, player, opts \\ []), do: Game.roll(game_state, player, opts)

  @doc """
  Scoring the current roll for a player
  """
  @spec save(game_state :: Game.t(), player :: String.t(), rule :: atom()) :: Game.t()
  def save(game_state, player, rule), do: Game.save(game_state, player, rule)

  @doc """
  Ending a game
  """
  @spec end_game(game_state :: Game.t()) :: Game.t()
  def end_game(game_state), do: Game.finish(game_state)
end
