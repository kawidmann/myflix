defmodule MyflixWeb.SearchController do
  use MyflixWeb, :controller
  alias Myflix.External.Search

  def index(conn, %{"query" => query}) do
    results = Search.search_all(query)

    render(conn, "index.html", results: List.wrap(results))
  end
end
