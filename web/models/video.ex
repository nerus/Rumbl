defmodule Rumbl.Video do
  use Rumbl.Web, :model
  @primary_key {:id, Rumbl.Permalink, autogenerate: true}
  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :slug, :string
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Category
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(url title description)
  @optional_fields ~w(category_id)

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> slugfy_title()
    |> assoc_constraint(:category)
  end
  def slugfy_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugfy(title))
    else
      changeset
    end
  end
  defp slugfy(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
  defimpl Phoenix.Param, for: Rumbl.Video do
    def to_param(%{slug: slug, id: id}) do
      "#{id}-#{slug}"
    end
  end
end
