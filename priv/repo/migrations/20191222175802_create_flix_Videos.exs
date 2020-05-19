defmodule Myflix.Repo.Migrations.CreateFlixVideos do
  use Ecto.Migration

  def change do
    create table(:video) do
      add(:name, :string)
      add(:type, :string)
      add(:path, :string)

      timestamps()
    end
  end
end
