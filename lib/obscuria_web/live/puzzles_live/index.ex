defmodule ObscuriaWeb.PuzzlesLive.Index do
  use ObscuriaWeb, :live_view

  alias Obscuria.Puzzles.Puzzle

  def mount(_params, _session, socket) do
    dbg "mount"
    puzzle = %Puzzle{} |> Puzzle.changeset(%{}) |> to_form()

    {:ok, assign(socket, puzzle: puzzle)}
  end

  def handle_params(_params, _url, socket) do
    dbg "handle_params"

    # {:noreply, assign(socket, other_word: params["word"])}
    {:noreply, socket}
  end

  def handle_event("validate", %{"puzzle" => params}, socket) do
    dbg "handle_event validate"
    puzzle =
      %Puzzle{}
      |> Puzzle.changeset(params)
      |> Map.put(:action, :insert)
      |> to_form()

    {:noreply, assign(socket, puzzle: puzzle)}
  end
end
