defmodule ObscuriaWeb.PuzzleController do
  use ObscuriaWeb, :controller

  def index(conn, _params) do
    dbg conn.assigns.current_user

    render(conn, :index)
  end
end
