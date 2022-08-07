defmodule MyflixWeb.PersonController do
  use MyflixWeb, :controller
  alias Myflix.External.Search
  alias Myflix.External.Resources.Person

  def index(conn, _params) do
    person = Search.popular("person")

    render(conn, "index.html", person: person)
  end

  def show(conn, %{"id" => id}) do
    person = Person.get(id)
    render(conn, "show.html", person: person)
  end
end
