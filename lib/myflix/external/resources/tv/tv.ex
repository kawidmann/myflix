defmodule Myflix.External.Resources.Tv do
  import Ecto.Query, warn: false
  alias Myflix.Repo
  alias Myflix.External.TMDB
  alias Myflix.External.Resources.Tvs

  def get(id) do
    TMDB.send_request("/tv/#{id}")
    |> Tvs.from_map()
  end
end
