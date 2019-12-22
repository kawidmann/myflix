defmodule MyflixWeb.VideoController do
  use MyflixWeb, :controller

  alias Myflix.Flix
  alias Myflix.Flix.Video

  def index(conn, _params) do
    videos = Flix.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Flix.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    case Flix.create_video(video_params) do
      {:ok, video} ->
        persist_file(video, video_params["video_file"])

        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Flix.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Flix.get_video!(id)
    changeset = Flix.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Flix.get_video!(id)

    case Flix.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Flix.get_video!(id)
    {:ok, _video} = Flix.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end

  defp persist_file(video, %{path: temp_path}) do
    video_path = Application.get_env(:myflix, :uploads_dir) |> Path.join(video.path)
    unless File.exists?(video_path) do
      video_path |> Path.dirname() |> File.mkdir_p()
      case File.copy(temp_path, video_path) do
        {:ok, _} -> Flix.update_video(video, %{path: video_path})
        {:error, _} -> nil #TODO error
      end
    end
  end
end
