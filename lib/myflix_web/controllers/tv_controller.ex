defmodule MyflixWeb.TvController do
  use MyflixWeb, :controller
  alias Myflix.External.Search
  alias Myflix.External.Resources.Tv

  def index(conn, _params) do
    tv = Search.popular("tv")

    render(conn, "index.html", tv: tv)
  end

  def show(conn, %{"id" => id}) do
    tv = Tv.get(id)
    render(conn, "show.html", tv: tv)
  end
end
