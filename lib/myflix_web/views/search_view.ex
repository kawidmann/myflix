defmodule MyflixWeb.SearchView do
  use MyflixWeb, :view

  def display_img(conn, path) do
    case path do
      nil -> MyflixWeb.Router.Helpers.static_path(conn, "/images/no_poster.jpeg")
      _ -> "https://image.tmdb.org/t/p/w154/#{path}"
    end
  end

  def result_link(conn, %{type: type} = result) do
    case type do
      "person" -> MyflixWeb.Router.Helpers.person_path(conn, :show, result)
      "movie" -> MyflixWeb.Router.Helpers.movie_path(conn, :show, result)
      "tv" -> MyflixWeb.Router.Helpers.tv_path(conn, :show, result)
      # TODO error
      _ -> nil
    end
  end

  def zero_results?([head | _]) do
    head.total_results == 0
  end
end
