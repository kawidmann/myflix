defmodule MyflixWeb.SearchController do
  use MyflixWeb, :controller
  alias Myflix.External.Search
  alias Myflix.External.Resources.Movie

  def index(conn, %{"query" => query}) do
    results = Search.search("movie", query)

    render(conn, "index.html", results: results)
  end

  def show(conn, %{"id" => id}) do
    movie = Movie.get(id)
    render(conn, "show.html", moive: movie)
  end
end
