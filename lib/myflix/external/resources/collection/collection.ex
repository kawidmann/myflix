defmodule Myflix.External.Resources.Collection do
  import Ecto.Query, warn: false
  alias Myflix.Repo
  alias Myflix.External.TMDB
  alias Myflix.External.Resources.Collections

  def get(id) do
    TMDB.send_request("/collection/#{id}")
    |> Collections.from_map()
  end
end
