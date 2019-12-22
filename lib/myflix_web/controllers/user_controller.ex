defmodule MyflixWeb.UserController do
  use MyflixWeb, :controller

  alias Myflix.Accounts
  alias Myflix.Accounts.User


  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |>put_session(:current_user_id, user.id)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    user = conn.assigns[:current_user]
    render(conn, "index.html", user: user)
  end

end
