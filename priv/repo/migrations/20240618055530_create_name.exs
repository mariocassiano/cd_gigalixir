defmodule CdGigalixir.Repo.Migrations.CreateName do
  use Ecto.Migration

  def change do
    create table(:name) do
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
