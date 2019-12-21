defmodule MyflixWeb.Helpers.Auth do

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!Myflix.Repo.get(Myflix.Accounts.User, user_id)
  end

end
