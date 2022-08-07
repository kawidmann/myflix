defmodule MyflixWeb.MovieController do
  use MyflixWeb, :controller
  alias Myflix.External.Search
  alias Myflix.External.Resources.Movie

  def index(conn, _params) do
    movie = Search.popular("movie")

    render(conn, "index.html", movie: movie)
  end

  def show(conn, %{"id" => id}) do
    movie = Movie.get(id)
    render(conn, "show.html", movie: movie)
  end
end
