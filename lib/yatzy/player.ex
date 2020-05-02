defmodule Yatzy.Player do
  @moduledoc """
  Module for player interactions
  """
  use TypedStruct

  alias Yatzy.Roll
  alias Yatzy.Sheet

  typedstruct do
    field :name, String.t(), enforce: true
    field :sheet, Sheet.t(), default: %Sheet{}
    field :current_roll, Roll.t(), default: %Roll{}
  end

  @doc """
  Creating a new player with an empty score sheet.

  ## Example

      iex> Yatzy.Player.new("Bob")
      %Yatzy.Player{name: "Bob", sheet: %Yatzy.Sheet{}, current_roll: %Yatzy.Roll{}}

  """
  @spec new(name :: String.t()) :: t()
  def new(""), do: raise(ArgumentError, "Please specify a name")
  def new(name), do: %__MODULE__{name: name}

  @doc """
  Rolling the dice for the player
  """
  @spec roll(player :: t(), opts :: Roll.options()) :: t()
  def roll(player = %__MODULE__{current_roll: current_roll}, opts \\ []) do
    %{player | current_roll: Roll.execute(current_roll, opts)}
  end

  @doc """
  Saving the current roll in the score sheet
  """
  @spec save(player :: t(), rule :: atom()) :: t()
  def save(player = %__MODULE__{current_roll: current_roll, sheet: sheet}, rule) do
    %{player | sheet: Sheet.record(sheet, current_roll, rule), current_roll: %Roll{}}
  end

  @doc """
  Calculating a user's total score
  """
  @spec score(player :: t()) :: integer()
  def score(player) do
    Sheet.total(player.sheet)
  end
end
