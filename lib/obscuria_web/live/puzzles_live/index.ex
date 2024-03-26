defmodule ObscuriaWeb.PuzzlesLive.Index do
  use ObscuriaWeb, :live_view

  alias Ecto.Changeset
  alias Obscuria.Puzzles
  alias Obscuria.Puzzles.{Puzzle, Riddle}

  def mount(_params, _session, socket) do
    puzzle = %Puzzle{riddles: [%Riddle{}]}
    changeset = Puzzles.change_puzzle(puzzle)
    form = to_form(changeset)

    {:ok, assign(socket, form: form)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"puzzle" => params}, socket) do
    form =
      %Puzzle{}
      |> Puzzles.change_puzzle(params)
      |> Map.put(:action, "validate")
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("add-riddle", _params, socket) do
    socket =
      update(socket, :form, fn %{source: changeset} ->
        existing = Changeset.get_embed(changeset, :riddles)
        changeset = Changeset.put_embed(changeset, :riddles, existing ++ [%Riddle{}])
        to_form(changeset)
      end)

    {:noreply, socket}
  end

  def handle_event("remove-riddle", %{"index" => index}, socket) do
    socket =
      update(socket, :form, fn %{source: changeset} ->
        existing = Changeset.get_embed(changeset, :riddles)
        changeset = Changeset.put_embed(changeset, :riddles, List.delete_at(existing, String.to_integer(index)))
        to_form(changeset)
      end)

    {:noreply, socket}
  end
end
