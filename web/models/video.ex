defmodule Rumbl.Video do
  use Rumbl.Web, :model

  schema "videos" do
    field :" url", :string
    field :tiltle, :string
    field :description, :string
    belongs_to :user, Rumbl.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:" url", :tiltle, :description])
    |> validate_required([:" url", :tiltle, :description])
  end
end
