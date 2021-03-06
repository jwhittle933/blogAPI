defmodule Api.Blog.Draft do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :body, :featured_image, :user_id]}

  schema "drafts" do
    field :body, :string
    field :title, :string
    field :featured_image, :string
    belongs_to :user, Api.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(draft, attrs) do
    draft
    |> cast(attrs, [:body, :title, :featured_image, :user_id])
    |> validate_required([:body, :title, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
