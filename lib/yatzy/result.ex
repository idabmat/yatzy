defmodule Yatzy.Result do
  @moduledoc """
  Determine the results of a given game
  """
  use TypedStruct

  alias Yatzy.Player
  alias Yatzy.Sheet

  @type result_type :: :win | :draw
  @type result_status :: :finished | :aborted

  typedstruct do
    field :winners, [String.t()]
    field :type, result_type(), enforce: true
    field :status, result_status(), enforce: true
  end

  @doc """
  Returns a new result struct based on the provided list of players
  """
  @spec new([Player.t()]) :: t()
  def new(players) do
    winners = winner_names(players)
    type = win_or_draw(winners)
    status = finished_or_aborted(players)

    %__MODULE__{winners: winners, type: type, status: status}
  end

  @spec win_or_draw([String.t()]) :: result_type()
  defp win_or_draw(winners) when length(winners) == 1, do: :win
  defp win_or_draw(_winners), do: :draw

  @spec finished_or_aborted([Player.t()]) :: result_status()
  defp finished_or_aborted(players) do
    if Enum.all?(players, &Sheet.completed?(&1.sheet)) do
      :finished
    else
      :aborted
    end
  end

  @spec winner_names([Player.t()]) :: [String.t()]
  defp winner_names(players) do
    winner_names(Enum.map(players, &{&1.name, Sheet.total(&1.sheet)}), [])
    |> Enum.map(&elem(&1, 0))
  end

  defp winner_names([], winners), do: winners
  defp winner_names([player | players], []), do: winner_names(players, [player])

  defp winner_names([player = {_player_name, player_total} | players], [
         {_winner_name, winner_total} | _winners
       ])
       when player_total > winner_total do
    winner_names(players, [player])
  end

  defp winner_names([player = {_player_name, player_total} | players], [
         winner = {_winner_name, winner_total} | winners
       ])
       when player_total == winner_total do
    winner_names(players, [winner | winners] ++ [player])
  end

  defp winner_names(_losers, winners), do: winners
end
