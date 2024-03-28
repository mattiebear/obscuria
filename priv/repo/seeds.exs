# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Obscuria.Repo.insert!(%Obscuria.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Obscuria.Accounts.User
alias Obscuria.Repo

%User{}
  |> User.registration_changeset(%{email: "user@example.com", password: "password1234"})
  |> Repo.insert()
