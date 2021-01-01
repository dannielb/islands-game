defmodule IslandsEngine.GameSupervisor do
  use DynamicSupervisor
  alias IslandsEngine.Game

  def start_link(_options), do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_game(name) do
    spec = %{id: name, start: {Game, :start_link, [name]}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def stop_game(name) do
    case pid_from_name(name) do
      pid when is_pid(pid) -> terminate_game(pid, name)
      nil -> {:error, :not_found}
    end
  end

  defp pid_from_name(name) do
    name
    |> Game.via_tuple
    |> GenServer.whereis
  end

  defp terminate_game(pid, name) do
    :ets.delete(:game_state, name)
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
