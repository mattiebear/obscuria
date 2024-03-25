defmodule Obscuria.Puzzles.Puzzle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "puzzles" do
    field :name, :string

    embeds_many :riddles, Obscuria.Puzzles.Riddle

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(puzzle, attrs) do
    puzzle
    |> cast(attrs, [:name])
    |> cast_embed(:riddles, required: true)
    |> validate_required([:name])
  end
end
