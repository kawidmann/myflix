defmodule MyflixWeb.VideoControllerTest do
  use MyflixWeb.ConnCase

  alias Myflix.File

  @create_attrs %{date_produced: ~N[2010-04-17 14:00:00.000000], name: "some name", path: "some path", runtime: ~T[14:00:00.000000], title: "some title", type: "some type"}
  @update_attrs %{date_produced: ~N[2011-05-18 15:01:01.000000], name: "some updated name", path: "some updated path", runtime: ~T[15:01:01.000000], title: "some updated title", type: "some updated type"}
  @invalid_attrs %{date_produced: nil, name: nil, path: nil, runtime: nil, title: nil, type: nil}

  def fixture(:video) do
    {:ok, video} = File.create_video(@create_attrs)
    video
  end

  describe "index" do
    test "lists all videos", %{conn: conn} do
      conn = get conn, video_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Videos"
    end
  end

  describe "new video" do
    test "renders form", %{conn: conn} do
      conn = get conn, video_path(conn, :new)
      assert html_response(conn, 200) =~ "New Video"
    end
  end

  describe "create video" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, video_path(conn, :create), video: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == video_path(conn, :show, id)

      conn = get conn, video_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Video"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, video_path(conn, :create), video: @invalid_attrs
      assert html_response(conn, 200) =~ "New Video"
    end
  end

  describe "edit video" do
    setup [:create_video]

    test "renders form for editing chosen video", %{conn: conn, video: video} do
      conn = get conn, video_path(conn, :edit, video)
      assert html_response(conn, 200) =~ "Edit Video"
    end
  end

  describe "update video" do
    setup [:create_video]

    test "redirects when data is valid", %{conn: conn, video: video} do
      conn = put conn, video_path(conn, :update, video), video: @update_attrs
      assert redirected_to(conn) == video_path(conn, :show, video)

      conn = get conn, video_path(conn, :show, video)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, video: video} do
      conn = put conn, video_path(conn, :update, video), video: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Video"
    end
  end

  describe "delete video" do
    setup [:create_video]

    test "deletes chosen video", %{conn: conn, video: video} do
      conn = delete conn, video_path(conn, :delete, video)
      assert redirected_to(conn) == video_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, video_path(conn, :show, video)
      end
    end
  end

  defp create_video(_) do
    video = fixture(:video)
    {:ok, video: video}
  end
end
