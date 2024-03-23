defmodule Obscuria.Puzzles.Puzzle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "puzzles" do
    field :name, :string
    field :riddles, {:array, :map}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(puzzle, attrs) do
    puzzle
    |> cast(attrs, [:name, :riddles])
    |> validate_required([:name, :riddles])
  end
end
