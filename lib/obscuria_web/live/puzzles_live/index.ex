defmodule ObscuriaWeb.PuzzlesLive.Index do
  use ObscuriaWeb, :live_view

  alias Ecto.Changeset
  alias Obscuria.Puzzles
  alias Obscuria.Puzzles.{Puzzle, Riddle}

  def mount(_params, _session, socket) do
    params = %{
      "riddles" => [
        %{
          "question" => "",
          "answer" => ""
        }
      ]
    }

    puzzle =
      %Puzzle{}
      |> Puzzles.change_puzzle(params)
      |> to_form()

    {:ok, assign(socket, params: params, puzzle: puzzle)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"puzzle" => params}, socket) do
    puzzle =
      %Puzzle{}
      |> Puzzles.change_puzzle(params)
      |> Map.put(:action, "validate")
      |> to_form()

    dbg params

    {:noreply, assign(socket, params: params, puzzle: puzzle)}
  end

  def handle_event("add", params, socket) do
    dbg params

    params = Map.update(socket.assigns.params, "riddles", [%{"question" => "", "answer" => ""}], &List.insert_at(&1, -1, %{"question" => "", "answer" => ""}))

    puzzle =
      %Puzzle{}
      |> Puzzles.change_puzzle(params)
      |> Map.put(:action, "validate")
      |> to_form()

    {:noreply, assign(socket, params: params, puzzle: puzzle)}
  end
end
