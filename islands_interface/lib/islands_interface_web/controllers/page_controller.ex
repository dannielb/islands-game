defmodule IslandsInterfaceWeb.PageController do
  use IslandsInterfaceWeb, :controller

  alias IslandsEngine.GameSupervisor

  def index(conn, _params)  do
    render(conn, "index.html")
  end

  def test(conn, %{"name" => name}) do
    with {:ok, _pid} <- GameSupervisor.start_game(name) do
      conn
      |> put_flash(:info, "You entered the name: " <> name)
      |> render("index.html")
    else
      {:error, {:already_started, _pid}} ->
        conn
        |> put_flash(:info, "A game with the name #{name} was already started!")
        |> render("index.html")
    end
  end
end
