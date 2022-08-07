defmodule Myflix.External.Resources.Person do
  import Ecto.Query, warn: false
  alias Myflix.External.TMDB
  alias Myflix.External.Resources.People

  def get(id) do
    TMDB.send_request("/person/#{id}")
    |> People.from_map()
  end
end
