defmodule MyflixWeb.SessionController do
  use MyflixWeb, :controller
  alias Myflix.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    case Accounts.sign_in(auth_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid username/password.")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: session_path(conn, :new))
  end
end
