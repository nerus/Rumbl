defmodule Rumbl.Category do
  use Rumbl.Web, :model

  schema "categories" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
  def delete_changeset(category, _id) do
    category
    |> Ecto.Changeset.change
    |> foreign_key_constraint(:videos, name: :videos_category_id_fkey, message: "hay videos con esta categoria")
  end
  def alphabetical(query) do
    from c in query, order_by: c.name
  end
  def names_and_ids(query) do
    from c in  query, select: {c.name, c.id}
  end
end
