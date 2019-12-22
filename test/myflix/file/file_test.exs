defmodule Myflix.FileTest do
  use Myflix.DataCase

  alias Myflix.File

  describe "videos" do
    alias Myflix.File.Video

    @valid_attrs %{date_produced: ~N[2010-04-17 14:00:00.000000], name: "some name", path: "some path", runtime: ~T[14:00:00.000000], title: "some title", type: "some type"}
    @update_attrs %{date_produced: ~N[2011-05-18 15:01:01.000000], name: "some updated name", path: "some updated path", runtime: ~T[15:01:01.000000], title: "some updated title", type: "some updated type"}
    @invalid_attrs %{date_produced: nil, name: nil, path: nil, runtime: nil, title: nil, type: nil}

    def video_fixture(attrs \\ %{}) do
      {:ok, video} =
        attrs
        |> Enum.into(@valid_attrs)
        |> File.create_video()

      video
    end

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert File.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert File.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      assert {:ok, %Video{} = video} = File.create_video(@valid_attrs)
      assert video.date_produced == ~N[2010-04-17 14:00:00.000000]
      assert video.name == "some name"
      assert video.path == "some path"
      assert video.runtime == ~T[14:00:00.000000]
      assert video.title == "some title"
      assert video.type == "some type"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = File.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      assert {:ok, video} = File.update_video(video, @update_attrs)
      assert %Video{} = video
      assert video.date_produced == ~N[2011-05-18 15:01:01.000000]
      assert video.name == "some updated name"
      assert video.path == "some updated path"
      assert video.runtime == ~T[15:01:01.000000]
      assert video.title == "some updated title"
      assert video.type == "some updated type"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = File.update_video(video, @invalid_attrs)
      assert video == File.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = File.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> File.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = File.change_video(video)
    end
  end
end
