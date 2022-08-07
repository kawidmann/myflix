defmodule Myflix.External.Search do
  import Ecto.Query, warn: false
  alias Myflix.External.Search.Results
  alias Myflix.External.TMDB

  def search_all(term) do
    ["movie", "person", "tv"]
    |> Enum.map(&search(&1, term))
  end

  def search(type, term, page \\ 1) do
    "/search/#{type}?#{build_query(%{query: term, page: page})}"
    |> request_to_struct()
  end

  # media_type can be "all", "movie", "tv", or "person"
  # time_window can be "day", "week"

  def trending(media_type \\ "all", time_window \\ "day") do
    "/trending/#{media_type}/#{time_window}"
  end

  def popular(type, page \\ 1) do
    "/#{type}/popular?#{build_query(%{page: page})}"
    |> request_to_struct()
  end

  def build_query(query) do
    Map.merge(%{language: "en-US", include_adult: "false"}, query)
    |> URI.encode_query()
  end

  def request_to_struct(url) do
    TMDB.send_request(url)
    |> Results.changeset()
  end
end
