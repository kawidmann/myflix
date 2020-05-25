defmodule Myflix.External.Resources.Movie do
  import Ecto.Query, warn: false
  alias Myflix.Repo
  alias Myflix.External.TMDB
  alias Myflix.External.Resources.Movies

  def get(id) do
    TMDB.send_request("/movie/#{id}")
    |> Movies.from_map()
  end

  def get_popular() do
    TMDB.send_request("/movie/popular")
    |> Results.changeset()
  end
end
