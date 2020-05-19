defmodule MyflixWeb.SearchController do
  use MyflixWeb, :controller
  alias Myflix.Flix

  def index(conn, %{"query" => query}) do
    results = Flix.search(:movie, query)

    render(conn, "show.html", results: results)
  end
end
