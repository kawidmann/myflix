defmodule Myflix.Repo do
  use Ecto.Repo,
    otp_app: :myflix,
    adapter: Ecto.Adapters.Postgres
end
