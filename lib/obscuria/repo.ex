defmodule Obscuria.Repo do
  use Ecto.Repo,
    otp_app: :obscuria,
    adapter: Ecto.Adapters.Postgres
end
