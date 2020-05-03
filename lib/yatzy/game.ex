defmodule Yatzy.Game do
  @moduledoc """
  Game module responsible for :

  - starting a new game
  - delegating player interactions based on game's turn
  - finishing a game
  """

  use TypedStruct
  alias Yatzy.Player
  alias Yatzy.Result
  alias Yatzy.Roll

  typedstruct do
    field :players, %{
      required(String.t()) => Player.t()
    }

    field :current_player, String.t()
    field :result, :pending | Result.t(), default: :pending
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
    with {:ok, ^game, player} <- find_player(game, player_name),
         {:ok, ^game} <- game_still_running(game),
         {:ok, ^game, player} <- do_player_roll(game, player, opts) do
      update_game_player(game, player)
    else
      _ -> game
    end
  end

  @doc """
  Saving a player's current roll and ending that player's turn.
  """
  @spec save(game :: t(), player_name :: String.t(), rule :: atom()) :: t()
  def save(game = %__MODULE__{}, player_name, rule) do
    with {:ok, ^game, player} <- find_player(game, player_name),
         {:ok, ^game} <- game_still_running(game),
         {:ok, ^game, player} <- save_player_roll(game, player, rule),
         {:ok, game} <- next_turn(game, player) do
      update_game_player(game, player)
    else
      _ -> game
    end
  end

  @doc """
  Finish the game and calculate the results
  """
  @spec finish(game :: t()) :: t()
  def finish(game = %__MODULE__{}), do: %{game | result: Result.new(Map.values(game.players))}

  @spec no_duplicate_names(names :: [String.t()]) :: [String.t()]
  defp no_duplicate_names(names), do: no_duplicate_names(names, Enum.uniq(names) == names)

  defp no_duplicate_names(_names, false),
    do: raise(ArgumentError, "Players must have distinct names")

  defp no_duplicate_names(names, _valid), do: names

  @spec no_blank_names(names :: [String.t()]) :: [String.t()]
  defp no_blank_names(names),
    do: no_blank_names(names, Enum.all?(names, &(String.trim(&1) != "")))

  defp no_blank_names(_names, false), do: raise(ArgumentError, "Player names can't be blank")
  defp no_blank_names(names, _valid), do: names

  @spec find_player(game :: t(), player_name :: String.t()) ::
          {:ok, game :: t(), player :: Player.t()} | {:error, game :: t()}
  defp find_player(game = %__MODULE__{current_player: current_player}, player_name)
       when current_player != player_name do
    {:error, game}
  end

  defp find_player(game = %__MODULE__{current_player: current_player}, player_name)
       when current_player == player_name do
    {:ok, game, game.players[player_name]}
  end

  @spec do_player_roll(game :: t(), player :: Player.t(), opts :: Roll.options()) ::
          {:ok, game :: t(), player :: Player.t()}
  defp do_player_roll(game = %__MODULE__{}, player, opts),
    do: {:ok, game, Player.roll(player, opts)}

  @spec update_game_player(game :: t(), player :: Player.t()) :: t()
  defp update_game_player(game = %__MODULE__{}, player = %Player{}) do
    players = %{game.players | player.name => player}
    %{game | players: players}
  end

  @spec save_player_roll(game :: t(), player :: Player.t(), rule :: atom()) ::
          {:ok | :error, game :: t(), player :: Player.t()}
  defp save_player_roll(game = %__MODULE__{}, player = %Player{}, rule) do
    save_player_roll(game, player, rule, player.current_roll.counter != 0)
  end

  defp save_player_roll(game, player, _rule, false), do: {:error, game, player}
  defp save_player_roll(game, player, rule, _valid), do: {:ok, game, Player.save(player, rule)}

  @spec next_turn(game :: t(), player :: Player.t()) :: {:ok, game :: t()}
  defp next_turn(game = %__MODULE__{}, player = %Player{}) do
    players = Map.keys(game.players)
    current_index = Enum.find_index(players, &(player.name == &1))
    next_index = rem(current_index + 1, length(players))
    next_player = Enum.at(players, next_index)
    {:ok, %{game | current_player: next_player}}
  end

  @spec game_still_running(game :: t()) :: {:ok | :error, game :: t()}
  defp game_still_running(game = %__MODULE__{result: :pending}), do: {:ok, game}
  defp game_still_running(game = %__MODULE__{}), do: {:error, game}
end
