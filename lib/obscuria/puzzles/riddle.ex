defmodule Obscuria.Puzzles.Riddle do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :question, :string
    field :answer, :string

    belongs_to :user, Obscuria.Accounts.User
    belongs_to :puzzle, Obscuria.Puzzles.Puzzle

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(riddle, attrs) do
    riddle
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
  end
end
