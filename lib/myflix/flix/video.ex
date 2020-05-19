defmodule Myflix.Flix.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    Named Video and not file because when you alias file it becomes confused with standard library
  """

  schema "video" do
    field(:name, :string)
    field(:path, :string)
    field(:type, :string)
    field(:video_file, :any, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:name, :type, :path, :video_file])
    |> validate_required([:video_file])
    |> put_video_file()
  end

  def put_video_file(changeset) do
    case changeset do
      %Ecto.Changeset{changes: %{video_file: video_file}} ->
        path = Ecto.UUID.generate() <> Path.extname(video_file.filename)

        changeset
        |> put_change(:path, path)
        |> put_change(:name, video_file.filename)
        |> put_change(:type, video_file.content_type)

      _ ->
        changeset
    end
  end
end
