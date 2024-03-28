defmodule ObscuriaWeb.PuzzleController do
  use ObscuriaWeb, :controller

  import Obscuria.Puzzles

  def index(conn, _params) do
    puzzles = conn.assigns.current_user.id |> list_puzzles_by_user_id()

    render(conn, :index, puzzles: puzzles)
  end
end
