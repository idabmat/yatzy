defmodule Yatzy.Game do
  @moduledoc """
  Game module for creating, playing and ending a game.
  """

  use TypedStruct
  alias Yatzy.Player
  alias Yatzy.Roll

  typedstruct do
    field :players, %{
      required(String.t()) => Player.t()
    }

    field :current_player, String.t()
  end

  @type options :: [
          initial_player :: String.t()
        ]

  @doc """
  Create a new game with a list of players
  """
  @spec new(player_names :: [String.t()], options :: options()) :: t()
  def new(player_names, options \\ [])
  def new([], _options), do: raise(ArgumentError, "Specify some players")

  def new(player_names, options) do
    current_player = Keyword.get(options, :initial_player, Enum.random(player_names))

    players =
      player_names
      |> no_blank_names()
      |> no_duplicate_names()
      |> Enum.map(fn name -> {name, Player.new(name)} end)
      |> Enum.into(%{})

    %__MODULE__{players: players, current_player: current_player}
  end

  @doc """
  (Re)Rolling the dice for a given player
  """
  @spec roll(game :: t(), player_name :: String.t(), opts :: Roll.options()) :: t()
  def roll(game = %__MODULE__{}, player_name, opts \\ []) do
    game
    |> find_player(player_name)
    |> do_player_roll(opts)
    |> update_game_player()
  end

  def save(game = %__MODULE__{}, player_name, rule) do
    game
    |> find_player(player_name)
    |> save_player_roll(rule)
    |> next_turn()
    |> update_game_player()
  end

  defp no_duplicate_names(names), do: no_duplicate_names(names, Enum.uniq(names) == names)

  defp no_duplicate_names(_names, false),
    do: raise(ArgumentError, "Players must have distinct names")

  defp no_duplicate_names(names, _valid), do: names

  def no_blank_names(names), do: no_blank_names(names, Enum.all?(names, &(String.trim(&1) != "")))
  def no_blank_names(_names, false), do: raise(ArgumentError, "Player names can't be blank")
  def no_blank_names(names, _valid), do: names

  defp find_player(game = %__MODULE__{current_player: current_player}, player_name) do
    player = get_current_player(game, current_player == player_name)
    {game, player}
  end

  defp get_current_player(_game, false), do: nil
  defp get_current_player(game, _valid), do: game.players[game.current_player]

  defp do_player_roll({game = %__MODULE__{}, nil}, _opts), do: {game, nil}
  defp do_player_roll({game = %__MODULE__{}, player}, opts), do: {game, Player.roll(player, opts)}

  defp update_game_player({game = %__MODULE__{}, nil}), do: game

  defp update_game_player({game = %__MODULE__{}, player}) do
    players = %{game.players | player.name => player}
    %{game | players: players}
  end

  defp save_player_roll({game = %__MODULE__{}, nil}, _rule), do: {game, nil}

  defp save_player_roll({game = %__MODULE__{}, player}, rule) do
    save_player_roll({game, player}, rule, player.current_roll.counter != 0)
  end

  defp save_player_roll({game, _player}, _rule, false), do: {game, nil}
  defp save_player_roll({game, player}, rule, _valid), do: {game, Player.save(player, rule)}

  defp next_turn({game = %__MODULE__{}, nil}), do: {game, nil}

  defp next_turn({game = %__MODULE__{}, player}) do
    players = Map.keys(game.players)
    current_index = Enum.find_index(players, &(player.name == &1))
    next_index = rem(current_index + 1, length(players))
    next_player = Enum.at(players, next_index)
    {%{game | current_player: next_player}, player}
  end
end
