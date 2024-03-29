defmodule Obscuria.Puzzles do
  @moduledoc """
  The Puzzles context.
  """

  import Ecto.Query, warn: false
  alias Obscuria.Repo

  alias Obscuria.Puzzles.Puzzle

  def list_puzzles_by_user_id(user_id) do
    query = from p in Puzzle, where: p.user_id == ^user_id

    Repo.all(query)
  end

  def get_puzzle_by_user_id!(id, user_id) do
    query = from p in Puzzle, where: p.id == ^id and p.user_id == ^user_id

    Repo.one(query)
  end

  def create_puzzle(attrs \\ %{}) do
    %Puzzle{}
    |> Puzzle.changeset(attrs)
    |> Repo.insert()
  end

  def update_puzzle(%Puzzle{} = puzzle, attrs) do
    puzzle
    |> Puzzle.changeset(attrs)
    |> Repo.update()
  end

  def delete_puzzle(%Puzzle{} = puzzle) do
    Repo.delete(puzzle)
  end

  def change_puzzle(%Puzzle{} = puzzle, attrs \\ %{}) do
    Puzzle.changeset(puzzle, attrs)
  end
end
