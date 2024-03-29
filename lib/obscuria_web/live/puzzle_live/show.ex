defmodule ObscuriaWeb.PuzzleLive.Show do
  use ObscuriaWeb, :live_view

  alias Ecto.Changeset
  alias Obscuria.Puzzles
  alias Obscuria.Puzzles.{Puzzle, Riddle}

  def mount(%{"id" => id}, session, socket) do
    puzzle = Puzzles.get_puzzle_by_user_id!(id, session["user_id"])

    {:ok, assign(socket, puzzle: puzzle)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
