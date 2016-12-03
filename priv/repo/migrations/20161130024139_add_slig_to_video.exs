defmodule Rumbl.Repo.Migrations.AddSligToVideo do
  use Ecto.Migration

  def change do
  	alter table(:videos) do
  	  add :slug, :string
  	end
  end
end
