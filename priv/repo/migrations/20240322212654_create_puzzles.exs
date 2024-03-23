defmodule Obscuria.Repo.Migrations.CreatePuzzles do
  use Ecto.Migration

  def change do
    create table(:puzzles) do
      add :name, :string
      add :riddles, {:array, :map}

      timestamps(type: :utc_datetime)
    end
  end
end
