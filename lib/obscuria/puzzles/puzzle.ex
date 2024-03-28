defmodule Obscuria.Puzzles.Puzzle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "puzzles" do
    field :name, :string

    belongs_to :user, Obscuria.Accounts.User

    embeds_many :riddles, Obscuria.Puzzles.Riddle

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(puzzle, attrs) do
    puzzle
    |> cast(attrs, [:name, :user_id])
    |> cast_embed(:riddles, required: true)
    |> validate_required([:name, :user_id])
  end
end
