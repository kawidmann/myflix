defmodule MyflixWeb.PageController do
  use MyflixWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
