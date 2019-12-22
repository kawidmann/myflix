defmodule Myflix.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :name, :string
      add :type, :string
      add :path, :string
      add :title, :string
      add :runtime, :time
      add :date_produced, :naive_datetime

      timestamps()
    end

  end
end
