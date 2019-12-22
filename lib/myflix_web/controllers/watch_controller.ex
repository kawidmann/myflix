defmodule MyflixWeb.WatchController do
  use MyflixWeb, :controller
  alias Myflix.Flix
  alias Myflix.Flix.Video

  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    video = Flix.get_video!(id)

    offset = get_offset(headers)
    file_size = get_file_size(video.path)

    conn
    |> Plug.Conn.put_resp_header("content-type", video.type)
    |> Plug.Conn.put_resp_header("content-range", "bytes #{offset}-#{file_size-1}/#{file_size}")
    |> Plug.Conn.send_file(206, video.path, offset, file_size - offset)
  end

  defp get_offset(headers) do
    case List.keyfind(headers, "range", 0) do
      {"range", "bytes=" <> start_pos} ->
        String.split(start_pos, "-") |> hd |> String.to_integer()
      nil ->
        0
    end
  end

  defp get_file_size(path) do
    {:ok, %{size: size}} = File.stat path

    size
  end

end
